class ApplicationController < ActionController::API
    # Ensure that authorize_request runs before any action in controllers inheriting from ApplicationController
    before_action :authorize_request
  
    # Handle ActiveRecord not found errors
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: { error: exception.message }, status: :not_found
    end
  
    # Handle ActiveRecord validation errors
    rescue_from ActiveRecord::RecordInvalid do |exception|
      render json: { error: exception.message }, status: :unprocessable_entity
    end
  
    private
  
    # Method to authorize requests based on JWT token
    def authorize_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      begin
        decoded = JsonWebToken.decode(token)
        @current_user = User.find(decoded[:user_id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :unauthorized
      rescue JWT::DecodeError
        render json: { errors: 'Invalid token' }, status: :unauthorized
      end
    end
  
    # Method to get the current authenticated user
    def current_user
      @current_user
    end
  end
  