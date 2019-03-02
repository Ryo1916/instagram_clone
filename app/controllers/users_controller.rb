class UsersController < ApplicationController
  include Users

  before_action :authenticate_user!
  before_action :set_user, except: [:index]

  def show
  end

  def index
    @users = get_users(params[:search]).paginate(page: params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = 'Your profile was successfully updated.'
    else
      render :edit
      flash[:alert] = 'Update failed.'
    end
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :website, :bio, :email, :phone, :gender, :avatar)
    end
end
