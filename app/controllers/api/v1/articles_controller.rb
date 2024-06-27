class Api::V1::ArticlesController < ApplicationController
    before_action :authorize_request
    before_action :set_article, only: [:show, :update, :destroy]
  
    def index
      @articles = Article.all
      render json: @articles
    end
  
    def show
      render json: @article
    end
  
    def create
      @article = current_user.articles.new(article_params)
  
      if @article.save
        render json: @article, status: :created
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @article.update(article_params)
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @article.destroy
        render json: { message: 'Article deleted successfully' }, status: :ok
      else
        render json: { error: 'Failed to delete article' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :content)
    end
  
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        decoded = JsonWebToken.decode(header)
        @current_user = User.find(decoded[:user_id]) if decoded
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
  