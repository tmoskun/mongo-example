Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.sequence(:username) {|n| "user_#{n}" }
  user.email { Factory.next :email }
  user.password         { "password" }
  user.password_confirmation { |instance| instance.password }
end
