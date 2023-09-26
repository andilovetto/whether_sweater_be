class User < ApplicationRecord
  has_secure_token :api_key
  has_secure_password 
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
            :presence => { message: "can't be blank" },
            :uniqueness => true
            validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
