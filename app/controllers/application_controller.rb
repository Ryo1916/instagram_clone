class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      added_attrs = %i[
        name
        username
        email
        phone
        password
        password_confirmation
        remember_me
        avatar
      ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    def after_sign_in_path_for(current_user)
      user_path(current_user)
    end

    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end
end
