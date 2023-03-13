class User < ApplicationRecord
  has_secure_password
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum:3}
    def self.authenticate_with_credentials(email,password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      return user
    end
    return nil
  end 
end


