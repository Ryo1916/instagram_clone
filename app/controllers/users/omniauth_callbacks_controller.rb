# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :user_signed_in?

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.nil?
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    else
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    end
  end

  # GET|POST /users/auth/providers/callback
  def failure
    flash[:alert] = "Something went wrong!"
    redirect_to new_user_registration_path
  end
end
