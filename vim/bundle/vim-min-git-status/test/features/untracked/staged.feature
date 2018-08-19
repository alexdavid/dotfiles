Feature: Working with untracked files in the index

  Background:
    Given I have an untracked file "foo"
    When I add "foo" to the index
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## Initial commit on master
      A  foo
      ~
      """


  Scenario: Unstaging
    When I type "j" to go down
    And I type "-" to toggle stage
    Then I see
      """
      ## Initial commit on master
      ?? foo
      ~
      """


  Scenario: Patching
    When I type "j" to go down a line
    And I type "p" to git reset --patch the file
    And I wait a second
    Then I see
      """
      Unstage this hunk [y,n,q,a,d,/,e,?]?
      """
