class PasswordMailer < ApplicationMailer
  default from: "no-reply@uvtechtechto.com"  # ← 認証済みドメインのアドレスを指定

  def password_reset
    @user = params[:user]
    mail(to: @user.email, subject: "パスワードリセットのご案内")
  end
end
