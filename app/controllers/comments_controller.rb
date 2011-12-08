class CommentsController < ApplicationController
  
  before_filter :authenticate
  skip_before_filter :verify_authenticity_token

  def create
    @story   = Story.find(params[:comment][:story_id])
    @comment = Comment.new(params[:comment].merge(:user => current_user))
    @comment.save
    redirect_to story_url(@story)
  end

  def upvote
    comment_id = BSON::ObjectId.from_string(params[:id])
    @comment = Comment.find(comment_id)
    Comment.upvote(comment_id, current_user.id)
    render :nothing => true
  end
  
end
