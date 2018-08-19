Feature: Working with untracked files in the working tree

  Background:
    Given I have an untracked file "foo"
    When I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## Initial commit on master
      ?? foo
      ~
      """


  Scenario: Staging
    When I type "j" to go down
    And I type "-" to toggle stage
    Then I see
      """
      ## Initial commit on master
      A  foo
      ~
      """


  Scenario: Patching
    When I type "j" to go down a line
    And I type "p" to git add --patch the file
    And I wait a second
    Then I see
      """
      Stage this hunk [y,n,q,a,d,/,e,?]?
      """
