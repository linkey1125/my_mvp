class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "会員登録が完了しました！"
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      redirect_to login_path, alert: "ログインしてください"
    end
  end

  def edit
    @user = User.find_by(id: session[:user_id])
    redirect_to login_path, alert: "ログインしてください" if @user.nil?
  end

  def update
    @user = User.find_by(id: session[:user_id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました！"
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
