class CommentsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

def index
end	

def create
	@article = Article.find(params[:article_id])
	@article.comments.create(comment_params.merge(user: current_user))
	redirect_to article_path(@article)
 end

 def edit
 end


 def update
 	if @article.comment.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end


 	@article.comment.update_attributes(comment_params)
 	if @article.comment.valid?
    redirect_to root_path
  else
    render :edit, status: :unprocessable_entity
  end
 end


 def destroy
    if @article.comment.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end

    @comment.destroy
    redirect_to root_path
 end

 private

  def comment_params
    params.require(:comment).permit(:message, :user_id, :article_id)
  end

  def find_article
	@article = Article.find(params[:article_id])
end

  def find_comment
	comment = @article.comments.find(params[:id])
 end
end
