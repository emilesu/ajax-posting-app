class Post < ApplicationRecord
  validates_presence_of :content
  belongs_to :user


  # 按赞功能

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  def find_like(user)
    self.likes.where( :user_id => user.id).first
  end
end
