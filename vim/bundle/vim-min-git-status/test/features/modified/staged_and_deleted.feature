Feature: Working with modified in the index and deleted in the working tree

  Background:
    Given I have a committed file "foo"
    When I modify "foo"
    And I add "foo" to the index
    And I delete "foo"
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## master
      MD foo
      ~
      """


  Scenario: Staging
    When I type "j" to go down
    And I type "-" to toggle stage
    Then I see
      """
      ## master
      D  foo
      ~
      """
