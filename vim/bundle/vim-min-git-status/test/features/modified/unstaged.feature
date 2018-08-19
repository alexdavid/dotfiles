Feature: Working with files modified in the working tree

  Background:
    Given I have a committed file "foo"
    When I modify "foo"
    And I run :Gministatus


  Scenario: Viewing
    Then I see
      """
      ## master
       M foo
      ~
      """


  Scenario: Staging
    When I type "j" to go down a line
    And I type "-" to toggle stage
    Then I see
      """
      ## master
      M  foo
      ~
      """


  Scenario: Patching
    When I type "j" to go down a line
    And I type "p" to git add --patch the file
    And I wait a second
    Then I see
      """
      Stage this hunk [y,n,q,a,d,/,e,?]?
      """
