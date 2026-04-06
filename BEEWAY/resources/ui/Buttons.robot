*** Settings ***
# Library    SeleniumLibrary
Resource    ../UIComponents.robot





*** Keywords ***
Button Click
    [Arguments]    ${LABEL}    ${INDEX}=1
    ${BASE_PATH}=    Set Variable    //button[normalize-space()="${LABEL}"]

    ${BUTTON_PATH}=    Set Variable    xpath=(${BASE_PATH})[${INDEX}]
    Wait Until Element Is Visible    ${BUTTON_PATH}    ${TIMEOUT}
    Click Button    ${BUTTON_PATH}
    Log To Console    Clicked button with label ${LABEL}

Click Element With Path
    [Arguments]    ${PATH}    ${INDEX}=1

    ${ELEMENT_PATH}=    Set Variable    xpath=(${PATH})[${INDEX}]
    Wait Until Element Is Visible    ${ELEMENT_PATH}    ${TIMEOUT}
    Click Element    ${ELEMENT_PATH}
    Log To Console    Clicked element with path ${PATH}