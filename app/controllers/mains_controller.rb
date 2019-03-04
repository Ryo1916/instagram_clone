class MainsController < ApplicationController
  def top
    if user_signed_in?
      redirect_to posts_path
      flash[:alert] = 'You are already logged in.'
    end
  end
end
