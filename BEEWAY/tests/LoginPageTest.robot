*** Settings ***
Library     SeleniumLibrary
Library     String
Library    DataDriver    file=../data/Login_Testdata.csv    dialect=excel

Resource    ../pages/AddShiftPage.robot
Resource    ../pages/LoginPage.robot

Suite Setup    Open Browser To Application
Suite Teardown  Close Application Browser
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
   
# Login with Empty Credentials Should Fail
#     [Tags]    Regression
#     Submit Login    ${USERNAME}    ${PASSWORD}
#     Verify Login Error Message   ${EXPECTED_ERROR} 
#     Log To Console    ✅ Verified error message for empty credentials
    
# Login with Empty Username Should Fail
#     [Tags]    Regression
#      Submit Login    ${USERNAME}   ${PASSWORD}
#     Verify Login Error Message    ${EXPECTED_ERROR}  
#     Log To Console    ✅ Verified error message for empty username

# Login with Empty Password Should Fail
#     [Tags]    Regression
#     Submit Login    ${USERNAME}    ${PASSWORD}
#     Verify Login Error Message   ${EXPECTED_ERROR}
#     Log To Console    ✅ Verified error message for empty password

# Login with Invalid Username Should Fail
#     [Tags]    Regression
#     Submit Login   ${USERNAME}    ${PASSWORD}        
#     Verify Login Error Message    ${EXPECTED_ERROR}
#     Log To Console    ✅ Verified error message for invalid username


# Login with Invalid Password Should Fail
#     [Tags]    Regression
#     Submit Login    ${USERNAME}    ${PASSWORD}   
#     Verify Login Error Message    ${EXPECTED_ERROR}      
#     Log To Console    ✅ Verified error message for invalid password

# Login With Valid Credentials
#     [Tags]    Smoke
#     Submit Login    ${USERNAME}    ${PASSWORD}        
#     Login Should Be Successful
#     Log To Console    ✅ Login successful with valid credentials

    
