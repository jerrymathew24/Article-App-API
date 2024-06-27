# app/controllers/api/v1/articles_controller.rb
class Api::V1::ArticlesController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource

  def index
    @articles = Article.page(params[:page]).per(params[:per_page] || 10)
    render json: @articles.map { |article| ArticlePresenter.new(article).as_json }
  end

  def show
    render json: ArticlePresenter.new(@article).as_json
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
