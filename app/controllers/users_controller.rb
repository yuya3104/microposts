class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end 
  
    before_action :logged_in_user, only:[:edit, :update]
  
  def new
    @user = User.new
  end

   def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
   end

  
  def edit
    @user = User.find(params[:id])
    if (current_user != @user)
        redirect_to root_path
    end
  end
  
  def followings
    @user  = User.find(params[:id])
    @following_users = @user.following_users
  end
  
  def followers
  @user  = User.find(params[:id])
  @follower_users = @user.follower_users
  end
  
 
  def update
    @user = User.find(params[:id])
    if (current_user != @user)
        redirect_to root_path
    end
   if @user.update(user_params)
     # 保存に成功した場合はトップページへリダイレクト
     redirect_to root_path , notice: 'プロフィール情報を更新しました。'
   else
     # 保存に失敗した場合は編集画面へ戻す
     render 'edit'
   end
  end
  




  private

  def user_params
    params.require(:user).permit(:name, :email,:area, :password,
                                 :password_confirmation)
  end
  
  
  
end
