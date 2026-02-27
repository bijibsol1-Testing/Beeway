*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot        

*** Keywords ***
Open Beeway
    Wait Until Element Is Visible    xpath=//img[contains(@src,'beeway.png')]/ancestor::li    ${TIMEOUT_LONG}
    Click Element    xpath=//img[contains(@src,'beeway.png')]/ancestor::li
    Wait Until Location Is    ${BEEWAY_URL}    ${TIMEOUT_LONG}
    Log To Console    ✅ Beeway opened


