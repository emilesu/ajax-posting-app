class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  def display_name
    self.email.split("@").first
  end


  # 按赞功能

  has_many :likes, :dependent => :destroy
  has_many :liked_posts, :through => :likes, :source => :post


  # 收藏功能

  has_many :collections, :dependent => :destroy
  has_many :collectiond_posts, :through => :collections, :source => :post


  # 核选方块

  def is_admin?
    role == "admin"
  end

end
