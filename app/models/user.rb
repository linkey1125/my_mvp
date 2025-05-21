class User < ApplicationRecord
    has_secure_password
    has_many :posts, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorite_posts, through: :favorites, source: :post

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
    validates :reset_password_token, uniqueness: true, allow_nil: true

  def generate_password_reset_token!
    update!(reset_password_token: SecureRandom.urlsafe_base64, reset_password_sent_at: Time.current)
  end

  def clear_password_reset_token!
    update!(reset_password_token: nil, reset_password_sent_at: nil)
  end

def password_reset_expired?
  return false if reset_password_sent_at.nil? # nil の場合は期限切れではない
  reset_password_sent_at < 1.hour.ago
end


end
