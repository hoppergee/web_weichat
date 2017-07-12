class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chatroom_user_relationships
  has_many :chatrooms, through: :chatroom_user_relationships
  has_many :messages

  has_many :friendships
  has_many :accepted_friendships, ->{where status: "accepted"}, class_name: 'Friendship'
  has_many :pending_friendships, ->{where.not(status: "accepted")}, class_name: 'Friendship'
  has_many :friends, :through => :accepted_friendships
  has_many :untreated_friends, :through => :pending_friendships, source: :friend

  mount_uploader :avatar, AvatarUploader

  after_create_commit :random_add_some_friends

  def random_add_some_friends
    User.all[0..32].sample(10).each do |user|
      if user != self
        self.request_friendship_with(user)
        user.accept_friendship_with(self)
      end
    end

  end

  def request_friendship_with(friend)
  	unless self == friend or Friendship.exists?(user: self, friend: friend)
  		transaction do
  			Friendship.create(user: self, friend: friend, status: "pending" )
  			Friendship.create(user: friend, friend: self, status: "requested" )
        FriendshipRequestJob.perform_later(friend)
  		end
  	end
  end

  def accept_friendship_with(friend)
  	if self != friend && has_been_requested_by?(friend)
	  	transaction do
	  		Friendship.accept_one_side(self, friend)
	  		Friendship.accept_one_side(friend, self)
        FriendshipRequestJob.perform_later(friend, true)
	  	end
  	end
  end

  def has_been_requested_by?(friend)
  	Friendship.find_by(user: self, friend: friend).status == "requested"
  end

  def friendship_with(friend)
  	Friendship.find_by(user: self, friend: friend)
  end

  def is_friend_of?(user)
    friendship = self.friendship_with(user)
    if friendship && friendship.status == "accepted"
      return true
    else
      return false
    end
  end

  def defriend_with(friend)
  	my_friendship = self.friendship_with(friend)
  	his_frienship = friend.friendship_with(self)
  	if my_friendship 
  		transaction do
  			my_friendship.destroy
  			his_frienship.destroy
  		end
  	end
  end

  def untreated_friendships_count
    self.friendships.where(status: "requested").count
  end

  def unread_messages_count_in(chatroom)
    relationship = self.chatroom_user_relationships.find_by(chatroom: chatroom)
    messages = Message.where(chatroom: chatroom)
    messages.select {|msg| relationship.last_read_at < msg.created_at }.count
  end

  def all_unread_messages_count
    count = 0
    self.chatrooms.each do |room|
      count += self.unread_messages_count_in(room)
    end
    return count
  end

  def avatar_url
    url = self.avatar.url
    if url
      url
    else
      "DefaultAvatar"
    end
  end

end
