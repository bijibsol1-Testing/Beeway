*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/UserSelectionPage.robot
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot
Resource    ../resources/Login.robot
Resource    ../resources/Service.robot





*** Keywords ***

Select Hospital
    [Arguments]    ${HOSPITAL_NAME}

    ${HOSPITAL_DROPDOWN}=    Set Variable
    ...    //li[contains(@class,'cus-select-dropdown')]

    Click Element    xpath=${HOSPITAL_DROPDOWN}

    Wait Until Element Is Visible
    ...    xpath=//ul[contains(@class,'dropdown-list') and contains(@class,'shown')][1]     ${TIMEOUT} 

    ${HOSPITAL_OPTION}=    Set Variable
    ...    //ul[contains(@class,'dropdown-list')]/li[normalize-space(.)='${HOSPITAL_NAME}']

    Click Element    xpath=${HOSPITAL_OPTION}
    Log To Console    ✅ Hospital selected: ${HOSPITAL_NAME}


Maximize Calendar
    Wait Until Element Is Visible    xpath=(//li[normalize-space()='Maximize'])[1]    ${TIMEOUT_LONG}
    Click Element  xpath=(//li[normalize-space()='Maximize'])[1]
    Log To Console    ✅ Calendar maximized
    sleep  5s

