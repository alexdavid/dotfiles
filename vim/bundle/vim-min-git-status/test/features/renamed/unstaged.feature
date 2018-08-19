Feature: Working with files renamed in the working tree

  Background:
    Given I have a committed file "foo"
    When I rename "foo" to "bar"
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## master
      ?? bar
       D foo
      ~
      """


  Scenario: Staging
    When I type "j" to go down to bar
    And I type "-" to toggle stage on bar
    When I type "j" to go down to foo
    And I type "-" to toggle stage on foo
    Then I see
      """
      ## master
      R  foo -> bar
      ~
      """
