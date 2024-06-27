class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :configure_devise_mapping
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      token = JsonWebToken.encode(user_id: resource.id)
      render json: { user: resource, token: token }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end


  def configure_devise_mapping
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
 
end
