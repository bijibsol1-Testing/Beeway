*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/UserSelectionPage.robot
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/PageSelect.robot
Resource    ../resources/Login.robot
Resource    ../resources/Service.robot




*** Keywords ***

Select Hospital
    [Arguments]    ${HOSPITAL_NAME}

    ${DROPDOWN_VISIBLE}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    xpath=//ul[contains(@class,'dropdown-list') and contains(@class,'shown')][1]    ${TIMEOUT}

    IF    ${DROPDOWN_VISIBLE}

        Click Element
        ...    xpath=//ul[contains(@class,'dropdown-list')]/li[contains(normalize-space(.),'${HOSPITAL_NAME}')]
        Log To Console    ✅ Hospital selected: ${HOSPITAL_NAME}

    ELSE

        ${DEFAULT_HOSPITAL}=    Get Text    xpath=//div[contains(@class,'between-xs')]//div[1]
        Should Contain    ${DEFAULT_HOSPITAL}    ${HOSPITAL_NAME}
        Log To Console    ✅ Default hospital verified: ${DEFAULT_HOSPITAL}

    END

Maximize Calendar
    Wait Until Element Is Visible    xpath=(//li[normalize-space()='Maximize'])[1]    ${TIMEOUT_LONG}
    Click Element  xpath=(//li[normalize-space()='Maximize'])[1]
    Log To Console    ✅ Calendar maximized
    sleep  5s

Select SubService
    [Arguments]    ${SUBSERVICE_NAME}

    Wait Until Element Is Visible    xpath=//li[normalize-space()="${SUBSERVICE_NAME}"]   ${TIMEOUT_LONG}
    Click Element    xpath=//li[normalize-space()="${SUBSERVICE_NAME}"]
    Log To Console    ✅ Sub-service selected: ${SUBSERVICE_NAME} 

Select Side Bar links
    [Arguments]    ${LINK}    ${PAGE_NAME}

    Wait Until Element Is Visible     xpath=//li[.//div[contains(@class,'tooltip-message')]]    ${TIMEOUT}
    Mouse Over    xpath=//li[.//div[contains(@class,'tooltip-message')]]//div[normalize-space()='${LINK}']
    Click Element    xpath=//li[.//div[contains(@class,'tooltip-message')]]//div[normalize-space()='${LINK}']
    Log To Console    ✅ Clicked on ${LINK} link in sidebar
    Click Element    Xpath=//li[normalize-space()="${PAGE_NAME}"]
    Log To Console    ✅ Clicked on ${PAGE_NAME} link in sidebar

Select Role
    [Arguments]    ${ROLE}
    Dropdown With Label    Role:    ${ROLE}
    Log To Console    ✅ Role selected

Select Department
  [Arguments]    ${DEPARTMENT}
    Dropdown With Label    Department:    ${DEPARTMENT}    
    Log To Console    ✅ Department selected

Select Ward
    [Arguments]    ${WARD}
    Dropdown With Label    Ward:    ${WARD}    
    Log To Console    ✅ Ward selected 

User Shift exist Status
    [Arguments]    ${DATE}    ${DOCTOR_NAME}    ${TIME} 

    ${USER_SHIFT_LIST}=    Set Variable    //li[.//div[contains(@class,'date') and normalize-space()='${DATE}']]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${TIME}']]
    Log To Console    Shift XPath: ${USER_SHIFT_LIST} 
    Wait Until Element Is Visible    xpath=${USER_SHIFT_LIST}    ${TIMEOUT_LONG} 
    ${exists}=    Run Keyword And Return Status
    ...    Page Should Contain Element    xpath=${USER_SHIFT_LIST}
    RETURN     ${exists}

Select Date from Hospital Schedule
    [Arguments]   ${YEAR}    ${MONTH}    ${DATE}    

    Select Year and Month    ${YEAR}     ${MONTH}
    Maximize Calendar
    Scroll Element Into View        xpath=(//li[.//div[normalize-space()='${DATE}']])[1]
    
Select Date from My Schedule
    [Arguments]   ${YEAR}    ${MONTH}    ${DATE}     

    Select Year and Month    ${YEAR}     ${MONTH}
    Maximize Calendar
    Scroll Element Into View        xpath=(//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]

Sub Service selection
    [Arguments]    ${SUBSERVICE_NAME}

    Wait Until Element Is Visible    xpath=//li[normalize-space()="${SUBSERVICE_NAME}"][1]   ${TIMEOUT_LONG}
    Click Element    xpath=//li[normalize-space()="${SUBSERVICE_NAME}"][1]
    Log To Console    ✅ Sub-service selected: ${SUBSERVICE_NAME}   

Select Month Arrows
    [Arguments]    ${DIRECTION}    ${COUNT}    ${MONTH}    ${YEAR}

    Wait Until Element Is Visible    xpath=//i[contains(@class,'fa-angle-${DIRECTION}')]    ${TIMEOUT}
   FOR    ${i}    IN RANGE    ${COUNT}
        Click Element    xpath=//i[contains(@class,'fa-angle-${DIRECTION}')]
   END
    Wait Until Element Is Visible    ...    xpath=//span[contains(@class,'month-name') and contains(normalize-space(),'${MONTH}') and contains(normalize-space(),'${YEAR}')]    ${TIMEOUT}
    Log To Console    ✅ Clicked on ${DIRECTION} arrow and navigated to ${MONTH} - ${YEAR}

Select Shift Dropdown
    [Arguments]    ${SHIFT_NAME_TIME}    ${DEPARTMENT}=${EMPTY}    ${WARD}=${EMPTY}

    ${INDEX}=    Set Variable    4

    IF    '${DEPARTMENT}'!='' or '${WARD}'!=''
        ${INDEX}=    Set Variable    5
    END

    IF    '${DEPARTMENT}'!='' and '${WARD}'!=''
        ${INDEX}=    Set Variable    6
    END

    Wait Until Element Is Visible    xpath=(//select)[${INDEX}]    ${TIMEOUT}
    Select From List By Label        xpath=(//select)[${INDEX}]    ${SHIFT_NAME_TIME}

    Log To Console    ✅ Shift '${SHIFT_NAME_TIME}' selected from dropdown index ${INDEX}

Select Duty type Dropdown
    [Arguments]    ${DUTY_TYPE}    ${DEPARTMENT}    ${WARD}

    ${INDEX}=    Set Variable    4

    IF    '${DEPARTMENT}'!='' or '${WARD}'!=''
        ${INDEX}=    Set Variable    5
    END

    IF    '${DEPARTMENT}'!='' and '${WARD}'!=''
        ${INDEX}=    Set Variable    6
    END

    Wait Until Element Is Visible    xpath=(//select)[${INDEX}]    ${TIMEOUT}
    Select From List By Label        xpath=(//select)[${INDEX}]    ${DUTY_TYPE}

    Log To Console    ✅ Duty type '${DUTY_TYPE}' selected from dropdown index ${INDEX}

Select Comments Dropdown
    [Arguments]    ${COMMENTS}    ${DEPARTMENT}    ${WARD}

    ${INDEX}=    Set Variable    5

    IF    '${DEPARTMENT}'!='' or '${WARD}'!=''
        ${INDEX}=    Set Variable    6
    END

    IF    '${DEPARTMENT}'!='' and '${WARD}'!=''
        ${INDEX}=    Set Variable    7
    END

    Wait Until Element Is Visible    xpath=(//select)[${INDEX}]    ${TIMEOUT}
    Select From List By Label        xpath=(//select)[${INDEX}]    ${COMMENTS}

    Log To Console    ✅ Comments '${COMMENTS}' selected from dropdown index ${INDEX}

Select Role Department Ward
    [Arguments]    ${ROLE}=${EMPTY}    ${DEPARTMENT}=${EMPTY}    ${WARD}=${EMPTY}

    Run Keyword If    '${ROLE}'!=''    
    ...    Log To Console    🔹 Selecting UI field: Role: ${ROLE}

    Run Keyword If    '${ROLE}'!=''    
    ...    Select Role    ${ROLE}

    Run Keyword If    '${ROLE}'==''    
    ...    Log To Console    ⚠️ Role: not provided, skipping

    Run Keyword If    '${DEPARTMENT}'!=''    
    ...    Log To Console    🔹 Selecting UI field: Department: ${DEPARTMENT}

    Run Keyword If    '${DEPARTMENT}'!=''    
    ...    Select Department    ${DEPARTMENT}

    Run Keyword If    '${DEPARTMENT}'==''    
    ...    Log To Console    ⚠️ Department: not provided, skipping

    Run Keyword If    '${WARD}'!=''    
    ...    Log To Console    🔹 Selecting UI field: Ward: ${WARD}

    Run Keyword If    '${WARD}'!=''    
    ...    Select Ward    ${WARD}

    Run Keyword If    '${WARD}'==''    
    ...    Log To Console    ⚠️ Ward: not provided, skipping

    Log To Console    ✅ Role / Department / Ward selection completed 