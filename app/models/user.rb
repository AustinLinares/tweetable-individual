class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  # Associations
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validations
  validates :email, :username, :name, presence: true
  validates :email, :username, uniqueness: true
  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/,
                      message: "must have an email format" }
  validates :encrypted_password, length: { minimum: 6 }
end
