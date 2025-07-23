class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.external_providers = [ :google ]
  end

  attr_accessor :password_confirmation

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :reviews, dependent: :destroy
  has_many :search_histories

  validates :email, presence: true, uniqueness: true
validates :password, presence: true, length: { minimum: 6 },
  if: -> { provider.nil? && (new_record? || changes[:crypted_password]) }

validates :password, confirmation: true,
  if: -> { provider.nil? && (new_record? || changes[:crypted_password]) }

validates :password_confirmation, presence: true,
  if: -> { provider.nil? && (new_record? || changes[:crypted_password]) }

  validates :reset_password_token, uniqueness: true, allow_nil: true

def self.from_omniauth(auth)
  user = find_by(provider: auth.provider, uid: auth.uid)
  if user.nil?
    user = find_by(email: auth.info.email)

    if user
      user.update(provider: auth.provider, uid: auth.uid)
    else
      user = create!(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        name: auth.info.name,
        password: SecureRandom.hex(10)
      )
    end
  end

  user
end


  def generate_password_reset_token!
    update!(reset_password_token: SecureRandom.urlsafe_base64, reset_password_sent_at: Time.current)
  end

  def clear_password_reset_token!
    update!(reset_password_token: nil, reset_password_sent_at: nil)
  end

  def password_reset_expired?
    return false if reset_password_sent_at.nil?
    reset_password_sent_at < 1.hour.ago
  end

  def recommended_posts(limit = 10)
    keywords = search_histories.order(created_at: :desc).limit(5).pluck(:keyword).uniq
    return Post.order(created_at: :desc).limit(limit) if keywords.empty?

    query_fragments = []
    query_params = []
    keywords.each do |kw|
      query_fragments << "(title LIKE ? OR content LIKE ?)"
      query_params.push("%#{kw}%", "%#{kw}%")
    end

    Post.where(query_fragments.join(" OR "), *query_params).limit(limit)
  end
end
