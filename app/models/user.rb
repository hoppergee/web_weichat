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
  has_many :friends, :through => :accepted_friendships

  mount_uploader :avatar, AvatarUploader

  def request_friendship_with(friend)
  	unless self == friend or Friendship.exists?(user: self, friend: friend)
  		transaction do
  			Friendship.create(user: self, friend: friend, status: "pending" )
  			Friendship.create(user: friend, friend: self, status: "requested" )
  		end
  	end
  end

  def accept_friendship_with(friend)
  	if self != friend && has_been_requested_by?(friend)
	  	transaction do
	  		Friendship.accept_one_side(self, friend)
	  		Friendship.accept_one_side(friend, self)
	  	end
  	end
  end

  def has_been_requested_by?(friend)
  	Friendship.find_by(user: self, friend: friend).status == "requested"
  end

  def friendship_with(friend)
  	Friendship.find_by(user: self, friend: friend)
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

  def unread_messages_count_in(chatroom)
    relationship = self.chatroom_user_relationships.find_by(chatroom: chatroom)
    messages = Message.where(chatroom: chatroom)
    messages.select {|msg| relationship.last_read_at < msg.created_at }.count
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
