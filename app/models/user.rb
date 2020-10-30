class User < ApplicationRecord
  #change email to lowecase before saving to DB
  before_save {self.email = email.downcase}
  before_save {self.username = username.downcase}

  #flad model as having secure password
  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
                                      length: { minimum: 3, maximum: 30 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
                                      length: { maximum: 100 }, format: {with: URI::MailTo::EMAIL_REGEXP }


  has_many :articles

end