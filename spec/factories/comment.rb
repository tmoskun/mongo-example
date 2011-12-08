Factory.define :comment do |comment|
  comment.body {"This is cool"}
  comment.association :user
  comment.association :story
end
