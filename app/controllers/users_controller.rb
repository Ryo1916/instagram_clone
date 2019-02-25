class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index]

  def show
    @posts = @user.posts
  end

  def index
    @users = User.all
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

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :website, :bio, :email, :phone, :gender, :avatar)
    end
end
