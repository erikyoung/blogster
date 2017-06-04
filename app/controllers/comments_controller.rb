class CommentsController < ApplicationController

def index
end	

def create
	@article = Article.find(params[:article_id])
	@article.comments.create(comment_params.merge(user: current_user))
	redirect_to article_path(@article)
 end

 def edit
 	@article = Article.find(params[:id])

 	if comments.comment.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end
 end


 def update
 	@comment.content = comment_params
	if @comment.update(comment_params)
		redirect_to article_path(@article)
	else
		render 'edit'
	end
end


 def destroy
 	@article = Article.find(params[:article_id])
 	@comment = @article.comments.find(params[:id])
 	@comment.destroy
	redirect_to article_path(@article)
 end

 private

  def comment_params
    params.require(:comment).permit(:message, :user_id, :article_id)
  end
end
