@run1
Feature: Register Flow Test Suite

  Background:
    Given "/index.php?route=account/register" endpoint is accessed

  Scenario: Register Page can be accessed from the Home Page
    Given "/" endpoint is accessed
    When registerLink from Header menu is clicked
    Then the current url contains "route=account/register" keyword

  @debug
  Scenario: The Account Page URL is opened when the registration is successful
    When the following form from "RegisterPage" is populated as follow:
      | firstNameInput | Random         |
      | lastNameInput  | Random         |
      | emailInput     | RandomEmail    |
      | passwordInput  | RandomPassword |
    And the "privacyToggle" from "RegisterPage" is clicked
    And the "continueBtn" from "RegisterPage" is clicked
    Then the current url contains "route=account/success" keyword

  Scenario: User remains on registerPage when the continue button is not clicked
    When the following form from "RegisterPage" is populated as follow:
      | firstNameInput | Random         |
      | lastNameInput  | Random         |
      | emailInput     | RandomEmail    |
      | passwordInput  | RandomPassword |
    Then the current url contains "route=account/register" keyword

  @Smoke
  Scenario Outline: An error message is displayed when invalid <impacted attribute> is used for register flow
    When the following form from "RegisterPage" is populated as follow:
      | firstNameInput | <firstName>    |
      | lastNameInput  | <lastName>     |
      | emailInput     | <emailData>    |
      | passwordInput  | <passwordData> |
    And the "privacyToggle" from "RegisterPage" is clicked
    And the "continueBtn" from "RegisterPage" is clicked
    Then the following list of error messages is displayed:
      | <impacted attribute> must be between 1 and 32 characters! |
    Examples:
      | impacted attribute | firstName                         | lastName                             | emailData   | passwordData |
      | First Name         | 32421353vt4326vv25243453244322424 | Random                               | RandomEmail | Random       |
      | Last Name          | Andrei                            | 32421353vt4326vv25243453244324234242 | RandomEmail | Random       |