class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chatroom_user_relationships
  has_many :chatrooms, through: :chatroom_user_relationships
  has_many :messages

  has_many :friendships
  has_many :friends, :through => :friendships

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

end
