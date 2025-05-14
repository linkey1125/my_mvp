class User < ApplicationRecord
    has_secure_password
    has_many :favorites

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }

    def generate_password_reset_token!
    self.reset_token = SecureRandom.urlsafe_base64
    save!
    end

    def clear_password_reset_token!
    self.update(reset_token: nil)
    end
end
