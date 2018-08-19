Feature: Gministatus sizes itself properly

  * Gministatus should not be larger than it needs to be
  * Gministatus should not take up more than 50% of terminal height


  Scenario: Gministatus only takes up as much space as it needs to display files
    Given my terminal is 100 rows high
    And I have 7 untracked files
    When I run :Gministatus
    Then Gministatus only takes up 10 lines


  Scenario Outline: Gministatus takes up half of the terminal window
    Given my terminal is <TERMINAL_HEIGHT> rows high
    And I have 200 untracked files
    When I run :Gministatus
    Then Gministatus only takes up <GMINISTATUS_HEIGHT> lines

    Examples:
      | TERMINAL_HEIGHT | GMINISTATUS_HEIGHT |
      | 50              | 25                 |
      | 100             | 50                 |
      | 151             | 75                 |
      | 152             | 76                 |
