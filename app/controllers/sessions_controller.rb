class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me] == "1")
    if user
      redirect_to user_path(user), notice: "ログインしました！"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています"
      render :new, status: :unprocessable_entity
    end
  end

  # 👇 Googleログイン用コールバック
  def create_from_google
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth) # モデル側で定義したGoogle情報からユーザー取得・作成
    session[:user_id] = user.id
    redirect_to user_path(user), notice: "Googleでログインしました！"
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
