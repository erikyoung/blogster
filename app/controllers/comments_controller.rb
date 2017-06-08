class CommentsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

def index
end	

def new
  @comments = Comment.new(params[:id])
  end

def create
	@article = Article.find(params[:article_id])
	@article.comments.create(comment_params.merge(user: current_user))
	redirect_to article_path(@article)
 end

 def edit
  article = Article.find(params[:article_id])
  @comment = article.comments.find(params[:id])
 end

 def show
  @article = Article.find(params[:article_id])
  @comment = @article.comments.find(params[:id])
 end


 def update
  @article = Article.find(params[:article_id])
  @comment = @article.comments.find(params[:id]) 
 	if @comment.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end


 	@comment.update_attributes(comment_params)
 	if @comment.valid?
    redirect_to root_path
  else
    render :edit, status: :unprocessable_entity
  end
 end


 def destroy
  @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  if @comment.article.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end

  @comment.destroy
  redirect_to root_path
 end

 private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def find_article
	@article = Article.find(params[:article_id])
end

  def find_comment
	comment = @article.comments.find(params[:id])
 end
end
