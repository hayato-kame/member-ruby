class ArticlesController < ApplicationController
  
  before_action :login_required, except: [:index, :show]
  
  
  # 記事一覧
  def index
      @articles = Article.visible.order(released_at: :desc)
      
      @articles = @articles.open_to_the_public.open_to_the_public unless current_member
      
      unless current_member&.administrator?
        @articles = @articles.visible
      end
      
      @articles = @articles.page(params[:page]).per(5)
      
  end 
  
  # 記事の詳細表示
  def show
    articles = Article.visible
    
    articles = articles.open_to_the_public unless current_member
    
    
    @article = articles.find(params[:id])
  end
  

end
