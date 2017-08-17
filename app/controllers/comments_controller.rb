class CommentsController < ApplicationController

  def create
    @harvest = Harvest.find(params[:harvest_id])
    @comment = @harvest.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @harvest = @comment.harvest
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :harvest_id)
  end
end
