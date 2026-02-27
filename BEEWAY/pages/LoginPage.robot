*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/UIComponents.robot

*** Variables ***
${ERROR_MSG_PATH}    //p[contains(@class,"alert alert-danger")]

*** Keywords ***
Enter Username
   [Arguments]    ${USERNAME}
   Textfield With Placeholder    Enter Username    ${USERNAME}

Enter Password
   [Arguments]    ${PASSWORD}
   Textfield With Placeholder    Enter Password    ${PASSWORD}

Click Login Button
   Button Click    Login

Click Login with OTP Button
   Button Click    Login with OTP

Click Forgot Password Link
   Click Element With Path    //a[text()='Forgot Password?']

Submit Login
   [Arguments]    ${username}    ${password}
   Enter Username    ${username}
   Enter Password    ${password}
   Click Login Button     

Verify Login Error Message
   [Arguments]    ${EXPECTED_ERROR_MESSAGE}
   ${actual_error_message}=    Get Error Msg
   Should Be Equal    ${actual_error_message}    ${EXPECTED_ERROR_MESSAGE}
   Wait Until Error Msg Disappear

Get Error Msg
   Wait Until Element Is Visible    ${ERROR_MSG_PATH}    ${TIMEOUT}
   ${msg}=    Get Text    ${ERROR_MSG_PATH}
   ${msg}=    Strip String    ${msg}
   RETURN    ${msg}

Wait Until Error Msg Disappear
    Wait Until Page Does Not Contain Element    ${ERROR_MSG_PATH}    ${TIMEOUT}
    Log To Console    ✅ Error Msg Disappear
   
Login Should Be Successful
   Wait Until Location Is    ${DASHBOARD_URL}     ${TIMEOUT}   