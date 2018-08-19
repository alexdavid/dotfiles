Feature: Working with files renamed in the index

  Background:
    Given I have a committed file "foo"
    When I rename "foo" to "bar"
    And I remove "foo" from the index
    And I add "bar" to the index
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## master
      R  foo -> bar
      ~
      """


  Scenario: Unstaging
    When I type "j" to go down a line
    And I type "-" to toggle stage
    Then I see
      """
      ## master
      ?? bar
       D foo
      ~
      """
