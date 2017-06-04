class ArticlesController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

def index
	@articles = Article.all
	@articles = Article.paginate(:page => params[:page], per_page: 2)
	@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

    if params[:search]
     @articles = @articles.search(params[:search])
   else
    @articles = Article.all
  end
  @articles = @articles.order("created_at DESC").paginate(:page => params[:page], per_page: 2)
end


def new 
	 @article = Article.new
end

def create
	current_user.articles.create(article_params)
	redirect_to root_path
 end

 def show
 	@article = Article.find(params[:id])
 end

 def edit
 	@article = Article.find(params[:id])
 end

 def update
 	@article = Article.find(params[:id])
 	@article.update_attributes(article_params)
 	redirect_to root_path
 end

 def destroy
 	 @article = Article.find(params[:id])
 	 @article.destroy
 	 redirect_to root_path
 end

 private

 def article_params
 	params.require(:article).permit(:title, :body)
 end
end
