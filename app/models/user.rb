class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_validation { email.downcase! }
  validates :name, length: { maximum: 30 }
  validates :email, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }
  has_secure_password
  before_destroy :admin_cannot_delete

  private
  
  def admin_cannot_delete
    throw :abort if User.exists?(admin: true) && self.admin == true
  end
end
