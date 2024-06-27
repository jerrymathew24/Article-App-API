class Api::V1::SessionsController < Devise::SessionsController

  before_action :configure_devise_mapping
  respond_to :json

  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    token = JsonWebToken.encode(user_id: resource.id)
    render json: { token: token, user: resource }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end

  def configure_devise_mapping
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
end
