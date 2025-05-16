class UserMailerPreview < ActionMailer::Preview
  def password_reset
    user = User.first || User.new(email: "test@example.com", reset_token: "dummy_token")
    UserMailer.password_reset(user)
  end
end
