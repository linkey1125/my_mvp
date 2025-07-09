class PasswordMailerPreview < ActionMailer::Preview
  def password_reset
    user = User.first || User.new(email: "test@example.com", reset_password_token: "dummy_token")
    PasswordMailer.password_reset(user)
  end
end
