Feature: Having Gministatus open in multiple tabs

  Background:
    Given I have an untracked file "foo"
    When I run :Gministatus
    And I run :tabnew
    And I run :Gministatus again


  Scenario: reopening Gministatus renders properly
    Then I see
      """
      ## Initial commit on master
      ?? foo
      ~
      """
