*** Settings ***
Library     SeleniumLibrary
Library     String

Resource    ../pages/AddShiftPage.robot
Resource    ../pages/LoginPage.robot

Suite Setup    Open Browser To Application
Suite Teardown  Close Application Browser

*** Test Cases ***
 
Login with Empty Credentials Should Fail
    [Tags]    Regression
    Submit Login    ${EMPTY}    ${EMPTY}
    Verify Login Error Message   ${USERNAME_ERROR_MESSAGE}  
    Log To Console    ✅ Verified error message for empty credentials
    
# Login with Empty Username Should Fail
#     [Tags]    Regression
#     Submit Login    ${EMPTY}    ${PASSWORD}
#     Verify Login Error Message    ${USERNAME_ERROR_MESSAGE}  
#     Log To Console    ✅ Verified error message for empty username

Login with Empty Password Should Fail
    [Tags]    Regression
    Submit Login    ${USERNAME}    ${EMPTY}
    Verify Login Error Message   ${PASSWORD_ERROR_MESSAGE}
    Log To Console    ✅ Verified error message for empty password

Login with Invalid Username Should Fail
    [Tags]    Regression
    Submit Login   ${invalidUserName}    ${PASSWORD}        
    Verify Login Error Message    ${WRONG_PASSWORD_ERROR_MESSAGE}
    Log To Console    ✅ Verified error message for invalid username


Login with Invalid Password Should Fail
    [Tags]    Regression
    Submit Login    ${USERNAME}    ${invalidPassword}    
    Verify Login Error Message    ${WRONG_PASSWORD_ERROR_MESSAGE}      
    Log To Console    ✅ Verified error message for invalid password

Login With Valid Credentials
    [Tags]    Smoke
    Submit Login    ${USERNAME}    ${PASSWORD}        
    Login Should Be Successful
    Log To Console    ✅ Login successful with valid credentials
    
