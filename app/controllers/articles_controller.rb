class ArticlesController < ApplicationController

def index
	@articles = Article.all
	@articles = Article.paginate(:page => params[:page], per_page: 2)
end

def new 
	 @article = Article.new
end

def create
	Article.create(article_params)
	redirect_to root_path
 end

 private

 def article_params
 	params.require(:place).permit(:title, :body)

end
