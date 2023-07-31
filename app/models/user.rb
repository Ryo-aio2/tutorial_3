class User < ApplicationRecord
    before_save { email.downcase! }
    #before_save { self.email = self.email.downcase と同等

    validates :name, presence: true, length: { maximum: 50 }
    #validates(:name, presence: true)と同等

    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
                    
    has_secure_password
    validates :password, presence: true, length: { minimum: 6}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
end
