Feature: Create a story
  As a user
  I can write stories
  So that other visitors can read them

Scenario: user creates a story
  Given I have signed in with "me@example.com/test"
  When I go to the new story page
  And I publish a story with "My story" and "http://www.mysite.com/story1"
  Then I should be on the story page for "My story"
  And I should see "You have published a story"
  #And I should see "My story" within "a#story-link"

Scenario: user tries to create a story with an empty title and empty url
  Given I have signed in with "me@example.com/test" 
  When I go to the new story page
  And I publish a story with "" and ""
  Then I should see error messages
  

  
  


