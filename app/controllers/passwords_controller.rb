class PasswordsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      # 仮の処理（本番ではメール送信機能を追加）
      flash[:notice] = "パスワードリセット用のリンクを送信しました"
      redirect_to login_path
    else
      flash[:alert] = "メールアドレスが見つかりません"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(reset_token: params[:token])
    unless @user
      redirect_to login_path, alert: "無効なリンクです"
    end
  end

  def update
    @user = User.find_by(reset_token: params[:token])
    if @user.update(password_params)
      flash[:notice] = "パスワードが変更されました"
      redirect_to login_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
