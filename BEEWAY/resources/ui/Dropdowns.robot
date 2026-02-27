*** Settings ***
Library    SeleniumLibrary



*** Keywords ***
Dropdown With Label
    [Arguments]    ${LABEL}    ${VALUE}    ${INDEX}=1
    ${BASE_PATH}=    Set Variable    //div[label[normalize-space(text())="${LABEL}"]]

    ${DROPDOWN_PATH}=    Set Variable    xpath=(${BASE_PATH}select)[${INDEX}]
    Wait Until Element Is Visible    ${DROPDOWN_PATH}    ${TIMEOUT}
    Select From List By Label    ${DROPDOWN_PATH}    ${VALUE}
    Log To Console    Dropdown with label ${LABEL} selected value ${VALUE}

Dropdown With Index
    [Arguments]    ${VALUE}    ${INDEX}=1

    ${DROPDOWN_PATH}=    Set Variable    xpath=(//select)[${INDEX}]
    Wait Until Element Is Visible    ${DROPDOWN_PATH}    ${TIMEOUT}
    Select From List By Label    ${DROPDOWN_PATH}    ${VALUE}
    Log To Console    Dropdown selected value ${VALUE}