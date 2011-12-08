Factory.define :story do |story|
  story.title {"My story"}
  story.url {"http://www.mysite.com/story1"}
  story.association :user
end
