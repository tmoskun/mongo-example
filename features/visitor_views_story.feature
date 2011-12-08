Feature: story pages
   In order to see if I'm interested in the story
   As a visitor
   I can read a story page

Background:
   Given the following story exists:
	   | title    |  url                          | user                      |
	   | My story |  http://www.mysite.com/story1 | email: writer@example.com |
   And the following comment exists:
       | body           |  story           | votes | user                        |
       | This is cool   |  title: My story | 5     | email:commenter@example.com |   
       
Scenario: visitor views a story page
   When I go to the story page for "My story"
   Then I should see a link "My story" to "http://www.mysite.com/story1"
   And I should see "6 votes"
   And I should see a comment "This is cool"
   And I should not see a comment form
   And I should not see an upvoting link
   And I should not see a link "reply"
   And I should see a link "Sign in"


Scenario: registered user views a story page with a comment they haven't upvoted
   Given I have signed in with "me@example.com/test"
   When I go to the story page for "My story"
   Then I should see a link "My story" to "http://www.mysite.com/story1"
   And I should see a comment form
   And I should see an upvoting link for "This is cool"
   And I should see "6 votes"
   And I should see a comment "This is cool"
   And I should see a link "reply"
   And I should not see a link "Sign in"

@javascript
Scenario: registered user views a story page with a comment they have upvoted
   Given I have signed in with "me@example.com/test"
   And I have upvoted on "This is cool" comment for "My story"
   When I go to the story page for "My story"
   Then I should see a link "My story" to "http://www.mysite.com/story1"
   And I should see a comment form
   And I should see "7 votes"
   And I should see a comment "This is cool"
   And I should see a link "reply"
   And I should not see an upvoting link
   And I should not see a link "Sign in"
   
   
   
