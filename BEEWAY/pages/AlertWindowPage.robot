*** Settings ***
Library    SeleniumLibrary
Library    String
Variables  ../globals.py

*** Variables ***
${ERROR_ALERT}    (//app-alert-window/div/div[contains(@class,"danger")]/div)[1]
${SUCCESS_ALERT}  (//app-alert-window/div/div[contains(@class,"success")]/div)[1]

*** Keywords ***
Get Error Alert Message
    Wait Until Element Is Visible    ${ERROR_ALERT}    ${TIMEOUT}
    ${msg}=    Get Text    ${ERROR_ALERT}
    ${msg}=    Strip String    ${msg}
    RETURN    ${msg}

Get Success Alert Message
    Wait Until Element Is Visible    ${SUCCESS_ALERT}    ${TIMEOUT}
    ${msg}=    Get Text    ${SUCCESS_ALERT}
    ${msg}=    Strip String    ${msg}
    RETURN    ${msg}

Error Alert Should Be
    [Arguments]    ${expected}
    ${actual}=    Get Error Alert Message
    Should Be Equal    ${actual}    ${expected}

Success Alert Should Be
    [Arguments]    ${expected}
    ${actual}=    Get Success Alert Message
    Should Be Equal    ${actual}    ${expected}



