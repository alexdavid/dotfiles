Feature: Working with unmerged and deleted files

  Background:
    Given I have a committed file "foo"
    And I have a "conflict" branch
    And I commit changes to "foo" in "master" branch
    And I delete "foo" in "conflict" branch
    When I merge "conflict" into "master"
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## master
      UD foo
      ~
      """


  Scenario: Staging
    When I type "j" to go down a line
    And I type "-" to toggle stage
    Then I see
      """
      ## master
      ~
      """
