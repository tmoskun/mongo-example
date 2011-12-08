class StoriesController < ApplicationController
  
  before_filter :authenticate, :except => [:index, :show]
  
  def index
    @page    = (params[:page] || 1).to_i
    @stories = Story.paginate(:page => @page, :per_page => 15)
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(params[:story])
    @story.user = current_user  
    if @story.save  
      flash[:notice] = "You have published a story"
      redirect_to story_path(@story)
    else
      flash[:notice] = "Cannot create a story"
      render :template => 'stories/new'
    end 
  end
  
  def show
    @story    = Story.find_by_id(params[:id])
    @comments = Comment.threaded_with_field(@story)
  end
  
    # Uses the class method of upvote to fire and forget.
  def upvote
    story_id = BSON::ObjectId.from_string(params[:id])
    Story.upvote(story_id, current_user.id)
    render :nothing => true
  end
  
end
