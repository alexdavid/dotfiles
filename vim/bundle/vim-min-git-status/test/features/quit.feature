Feature: Gministatus can be quit with q

  Scenario: pressing q closes Gministatus
    When I run :Gministatus
    And I type "q" to quit Gministatus
    Then I don't see Gministatus
