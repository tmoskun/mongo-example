require 'spec_helper'

describe StoriesController, 'routes' do
  it { should route(:get, 'stories').to(:action => 'index')}
  it { should route(:get, 'stories/new').to(:action => 'new')}
  it { should route(:get, 'stories/1').to(:action => 'show', :id => 1) }
  it { should route(:get, 'stories/1/upvote').to(:action => 'upvote', :id => 1) }
end

describe StoriesController, "POST to create without authenticating" do
  before do
    post :create, :user_id => 1, :title => "My Story", :url => "http://www.mysite.com/story1" 
  end
  it { should redirect_to(sign_in_path) }
end
 
describe StoriesController, "authenticated POST to create" do
  let(:user) {Factory(:user)}
  before do
    controller.current_user = user
    post :create, :story => {:user_id => user.id, :title => "My Story", :url => "http://www.mysite.com/story1"}
    assigns(:story).should_not be_new_record
  end
  it 'creates a slug' do
    assigns(:story).slug.should_not be_nil
  end
  it {should redirect_to(story_path(assigns(:story)))}
  it 'makes the signed in user upvote on the story' do
    assigns(:story).voter?(controller.current_user).should be_true
  end
end

