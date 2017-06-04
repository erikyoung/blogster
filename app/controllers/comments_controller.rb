class CommentsController < ApplicationController
	

def create
	@article = Article.find(params[:article_id])
	@article.comments.create(comment_params.merge(user: current_user))
	redirect_to article_path(@article)
 end



 private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
