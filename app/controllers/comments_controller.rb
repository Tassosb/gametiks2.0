class CommentsController < ApplicationController

  def create
    @harvest = Harvest.find(params[:harvest_id])
    @comment = @harvest.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @post
        end
        format.js 
      end
    else
      redirect_to @harvest.user
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :harvest_id)
  end
end
