require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

When /^(?:|I )publish a story (?:with|as) "([^"]*)" and "([^"]*)"$/ do |title, url|
  fill_in "Story title", :with => title
  fill_in "Url", :with => url
  click_button "Post"
end

=begin
When /^(?:|I )have upvoted on "([^"]*)" (?:with|as) "([^"]*)"$/ do |title, email|
  user = User.find_by_email(email)
  story = Story.find_by_title(title)
  story.upvote(user)
end
=end

When /^(?:|I )have upvoted on "([^"]*)"$/ do |title|
  story = Story.find_by_title(title)
  When %{I go to the stories page}
  And %{I follow "^" within "#story_#{story.id} .upvote"}
end

When /^(?:|I )have upvoted on "([^"]*)" comment for "([^"]*)"$/ do |body, title|
  story = Story.find_by_title(title)
  comment = Comment.find_by_body(body)
  When %{I go to to the story page for "#{title}"}
  And %{I follow "^" within "#comment_#{comment.id} .upvote"}
end

Then /^(?:|I )should see an upvoting link for "([^"]*)"$/ do |title|
  story = Story.find_by_title(title)
  if story.nil?
    comment = Comment.find_by_body(title)
    Then %{I should see a link "^" within "#comment_#{comment.id} .upvote"}
  else
    Then %{I should see a link "^" within "#story_#{story.id} .upvote"}
  end
end


Then /^(?:|I )should not see an upvoting link$/ do
  Then %{I should not see a link "^"}
end

Then /^(?:|I )should see a comment "([^"]*)"/ do |body|
  comment = Comment.find_by_body(body)
  Then %{I should see "#{body}" within "#comment_#{comment.id} .body"}
end

Then /^(?:|I )should see a comment form$/ do
  if page.respond_to? :should
    page.should have_selector('form', :action =>"#{comments_path}")
  else
    assert page.has_selector?('form', :action =>"#{comments_path}")
  end
end

Then /^(?:|I )should not see a comment form$/ do
  if page.respond_to? :should
    page.should have_no_selector('form', :action => "#{comments_path}")
  else
    assert page.has_no_selector?('form', :action => "#{comments_path}")
  end
end
 

