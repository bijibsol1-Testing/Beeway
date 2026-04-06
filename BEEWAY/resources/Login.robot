*** Settings ***
# Library    SeleniumLibrary
Resource    UIComponents.robot

*** Variables ***
${LOGIN_PAGE_TITLE}    Enter Login Credentials

*** Keywords ***
Login and Goto Dashboard
    [Arguments]    ${USERNAME}    ${PASSWORD}
    
    Wait Until Page Contains    ${LOGIN_PAGE_TITLE}     ${TIMEOUT}
    Log to Console    Login Page Loaded Successfully

    Textfield With Placeholder    Enter Username    ${USERNAME}
    Textfield With Placeholder    Enter Password    ${PASSWORD}
    Button Click    Login

    # 🔑 WAIT FOR REDIRECT AFTER LOGIN
    Wait Until Location Is    ${DASHBOARD_URL}    ${TIMEOUT}
    Log to Console    Navigated to Dashboard Successfully