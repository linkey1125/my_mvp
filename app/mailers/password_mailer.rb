class PasswordMailer < ApplicationMailer
  def password_reset
    @user = params[:user]

    mail(
      to: @user.email,
      from: "no-reply@uvtechtechto.com",  # 認証済みドメイン
      subject: "パスワードリセットのご案内"
    )
  end
end
