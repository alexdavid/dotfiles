Feature: Working with files renamed in the index and modified in the working tree

  Background:
    Given I have a committed file "foo"
    When I rename "foo" to "bar"
    And I remove "foo" from the index
    And I add "bar" to the index
    And I modify "bar"
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## master
      RM foo -> bar
      ~
      """


  Scenario: Staging
    Then I see
      """
      ## master
      RM foo -> bar
      ~
      """
    When I type "j" to go down a line
    And I type "-" to toggle stage
    Then I see
      """
      ## master
      R  foo -> bar
      ~
      """
