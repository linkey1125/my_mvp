class UserMailer < ApplicationMailer
    def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードリセットのご案内"
    end
end