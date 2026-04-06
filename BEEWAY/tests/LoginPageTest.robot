*** Settings ***
Library    SeleniumLibrary    screenshot_root_directory=results/Screenshots
Library     String
Library    DataDriver    file=../data/Login_Testdata.csv    dialect=excel

Resource    ../pages/LoginPage.robot


# Suite Setup    Open Browser To Application
# Suite Teardown  Close Application Browser
# Test Template    Login Test

Test Setup    Open Browser To Application
Test Teardown    Close Application Browser
Test Template    Login Test


***Keywords***

Login Test
    [Arguments]    ${USERNAME}    ${PASSWORD}    ${EXPECTED_ERROR}    ${SUCCESS}

    Submit Login    ${USERNAME}    ${PASSWORD}

    IF    '${SUCCESS}' == 'True'
        Login Should Be Successful
    ELSE
        Verify Login Error Message    ${EXPECTED_ERROR}
    END  


*** Test Cases ***

Login Data Driven Test
    [Tags]    Regression
   
