class ArticlePresenter
    def initialize(article)
      @article = article
    end
  
    def as_json(*)
      {
        id: @article.id,
        title: @article.title,
        content: @article.content,
        user: {
          id: @article.user.id,
          email: @article.user.email
        },
        created_at: @article.created_at,
        updated_at: @article.updated_at
      }
    end
  end
   