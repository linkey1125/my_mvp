class PasswordMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    mail(to: @user.email, subject: "パスワードリセットのご案内")
  end
end
