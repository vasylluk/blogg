class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :nickname, :password, :email, presence: true
  validates :nickname, length: { in: 5..15 }
  validates :nickname, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }

 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :postcomments
  has_many :photos
  has_many :votes
  has_many :images
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/default.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
