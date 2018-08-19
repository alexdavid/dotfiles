Feature: Working with files modified in the index and modified in the working tree

  Background:
    Given I have a committed file "foo"
    When I modify "foo"
    And I add "foo" to the index
    And I modify "foo"
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## master
      MM foo
      ~
      """


  Scenario: Staging
    When I type "j" to go down
    And I type "-" to toggle stage
    Then I see
      """
      ## master
      M  foo
      ~
      """
