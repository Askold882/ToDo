class User < ApplicationRecord
  has_many :tasks
  has_secure_password
  has_secure_token :confirm_token
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
