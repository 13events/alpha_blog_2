class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
                                      length: { minimum: 3, maximum: 30 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
                                      length: { maximum: 100 }, format: {with: URI::MailTo::EMAIL_REGEXP }


end