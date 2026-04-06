*** Settings ***
# Library    SeleniumLibrary
Resource    ../UIComponents.robot

*** Keywords ***
Textfield With Label
    [Arguments]    ${LABEL}    ${VALUE}    ${INDEX}=1
    ${BASE_PATH}=    Set Variable    //div[label[text()="${LABEL}"]]/following-sibling::

    ${INPUT_PATH}=    Set Variable    xpath=(${BASE_PATH}div/input)[${INDEX}]
    Wait Until Element Is Visible    ${INPUT_PATH}    ${TIMEOUT}
    Clear Element Text    ${INPUT_PATH}
    Input Text    ${INPUT_PATH}    ${VALUE}
    Log To Console    Textfield with label ${LABEL} filled with value ${VALUE}

Textfield With Placeholder
    [Arguments]    ${PLACEHOLDER}    ${VALUE}    ${INDEX}=1

    ${INPUT_PATH}=    Set Variable    xpath=(//input[@placeholder="${PLACEHOLDER}"])[${INDEX}]
    Wait Until Element Is Visible    ${INPUT_PATH}    ${TIMEOUT}
    Clear Element Text    ${INPUT_PATH}
    Input Text    ${INPUT_PATH}    ${VALUE}
    Log To Console    Textfield with placeholder ${PLACEHOLDER} filled with value ${VALUE}

Textfield With Path
    [Arguments]    ${PATH}    ${VALUE}    ${INDEX}=1

    ${INPUT_PATH}=    Set Variable    xpath=(${PATH})[${INDEX}]
    Wait Until Element Is Visible    ${INPUT_PATH}    ${TIMEOUT}
    Clear Element Text    ${INPUT_PATH}
    Input Text    ${INPUT_PATH}    ${VALUE}
    Log To Console    Textfield with path ${PATH} filled with value ${VALUE}