class PasswordsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      PasswordMailer.with(user: user).password_reset.deliver_later
      redirect_to login_path, notice: "パスワードリセット用のメールを送信しました。"
    else
      flash[:alert] = "メールアドレスが見つかりません。"
      render :new, status: :unprocessable_entity
    end
  end

def edit
  @user = User.find_by(reset_password_token: params[:token])
  if @user.nil? || @user.password_reset_expired?
    redirect_to login_path, alert: "パスワードリセットの有効期限が切れています。"
  end
end

  def update
    @user = User.find_by(reset_password_token: params[:token])
    if @user&.update(password_params)
      @user.clear_password_reset_token!
      redirect_to login_path, notice: "パスワードを変更しました。"
    else
      flash[:alert] = "パスワード変更に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
