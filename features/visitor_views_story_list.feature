Feature: story list
   In order to see what stories are available and upvote
   As a visitor
   I can see a list of stories

Background:
   Given the following stories exist:
       | title         |  url                           | votes  | user                       |
	   | My story      |  http://www.writer1.com/story1 | 5      | email: writer1@example.com |
       | My best story |  http://www.writer2.com/story1 | 10     | email: writer2@example.com |

Scenario: visitor views story list
   When I go to the stories page
   Then I should see a link "My story" to "http://www.writer1.com/story1"
   And I should see "6 votes"
   And I should see a link "My best story" to "http://www.writer2.com/story1"
   And I should see "11 votes"
   And I should see a link "Sign in"
   And I should not see an upvoting link

Scenario: registered user views story list with stories they haven't upvoted
   Given I have signed in with "me@example.com/test"
   When I go to the stories page
   Then I should see a link "My story" to "http://www.writer1.com/story1"
   And I should see an upvoting link for "My story"
   And I should see "6 votes"
   And I should see a link "My best story" to "http://www.writer2.com/story1"
   And I should see an upvoting link for "My best story"
   And I should see "11 votes"
   And I should not see a link "Sign in"


@javascript
Scenario: registered user views story list with stories they have upvoted
   Given I have signed in with "me@example.com/test"
   And I have upvoted on "My story"
   And I have upvoted on "My best story"
   When I go to the stories page
   Then I should see a link "My story" to "http://www.writer1.com/story1"
   And I should see "7 votes"
   And I should see a link "My best story" to "http://www.writer2.com/story1"
   And I should see "12 votes"
   And I should not see an upvoting link
   And I should not see a link "Sign in"
      
   
   
   