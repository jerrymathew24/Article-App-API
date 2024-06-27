class Api::V1::AuthenticationController < ApplicationController
    before_action :configure_devise_mapping
  
    def login
      @user = User.find_by_email(params[:email])
      if @user&.valid_password?(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        render json: { token: token, user: @user }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    private
  
    def configure_devise_mapping
      request.env["devise.mapping"] = Devise.mappings[:user]
    end
  end
  