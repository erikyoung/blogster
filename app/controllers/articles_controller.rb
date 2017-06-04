class ArticlesController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
	@article = current_user.articles.create(article_params)
  if @article.valid?
    redirect_to root_path
  else
    render :new, status: :unprocessable_entity
  end
 end

 def show
 	@article = Article.find(params[:id])
 end

 def edit
 	@article = Article.find(params[:id])

 	if @article.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end
 end

 def update
 	@article = Article.find(params[:id])

 	if @article.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end


 	@article.update_attributes(article_params)
 	if @article.valid?
    redirect_to root_path
  else
    render :edit, status: :unprocessable_entity
  end
 end

 def destroy
 	 @article = Article.find(params[:id])
 	 if @article.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end


 	 @article.destroy
 	 redirect_to root_path
 end

 private

 def article_params
 	params.require(:article).permit(:title, :body)
 end
end
