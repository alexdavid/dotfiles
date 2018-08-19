Feature: Working with untracked files in the index and deleted in the working tree

  Background:
    Given I have an untracked file "foo"
    When I add "foo" to the index
    And I delete "foo"
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## Initial commit on master
      AD foo
      ~
      """


  Scenario: Staging
    When I type "j" to go down
    And I type "-" to toggle stage
    Then I see
      """
      ## Initial commit on master
      ~
      """
