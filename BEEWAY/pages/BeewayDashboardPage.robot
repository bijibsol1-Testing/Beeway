*** Settings ***
# Library    SeleniumLibrary
Resource    ../pages/UserSelectionPage.robot
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/PageSelect.robot
Resource    ../resources/Login.robot
Resource    ../resources/Service.robot


*** Keywords ***

Select Hospital
    [Arguments]    ${HOSPITAL_NAME}

    Click Element    xpath=//li[contains(@class,'cus-select-dropdown')]
    ${DROPDOWN_VISIBLE}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    
    ...    xpath=//ul[contains(@class,'dropdown-list') and contains(@class,'shown')]    ${TIMEOUT_LONG}

    IF    ${DROPDOWN_VISIBLE}
        Wait Until Element Is Visible    
        ...    xpath=//ul[contains(@class,'dropdown-list') and contains(@class,'shown')]//li[contains(normalize-space(), '${HOSPITAL_NAME}')]    ${TIMEOUT_LONG}
        Click Element    
        ...    xpath=//ul[contains(@class,'dropdown-list') and contains(@class,'shown')]//li[contains(normalize-space(), '${HOSPITAL_NAME}')]
        Log To Console    ✅ Hospital selected: ${HOSPITAL_NAME}

    ELSE
        ${DEFAULT_HOSPITAL}=    Get Text    
        ...    xpath=//li[contains(@class,'cus-select-dropdown')]//div[contains(@class,'b-p-2')]//div[1]
        Should Be Equal    ${DEFAULT_HOSPITAL}    ${HOSPITAL_NAME}
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

Click Side Bar Menu
    [Arguments]    ${LINK}    ${SUBLINK}
  
    ${MENU}=    Set Variable    xpath=//li[.//div[normalize-space()='${LINK}']]
    ${SUBMENU}=    Set Variable    Xpath=//ul[contains(@class,'submenu')]//li[normalize-space()='${SUBLINK}']
    ${TOOLTIP}=    Set Variable    xpath=//div[contains(@class,'tooltip-message') and normalize-space()='${LINK}']
    Wait Until Element Is Visible    ${MENU}    ${TIMEOUT_LONG}
    Mouse Over    ${MENU}
    Wait Until Element Is Visible    ${TOOLTIP}    ${TIMEOUT}
    Element Text Should Be    ${TOOLTIP}    ${LINK}
    Click Element    ${MENU}
    Wait Until Element Is Visible    ${SUBMENU}    ${TIMEOUT}
    Click Element    ${SUBMENU}

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
    Scroll Element Into View    xpath=${USER_SHIFT_LIST}    
    ${exists}=    Run Keyword And Return Status
    ...    Page Should Contain Element    xpath=${USER_SHIFT_LIST}
    RETURN     ${exists}

Select Date from Hospital Schedule
    [Arguments]   ${YEAR}    ${MONTH}    ${DATE}    ${HOSPITAL_NAME}

    Select Year and Month    ${YEAR}     ${MONTH}
    IF    'Chris' not in '${HOSPITAL_NAME}'
        Maximize Calendar
    END
    Scroll Element Into View    xpath=(//li[.//div[normalize-space()='${DATE}']])[1]
    
Select Date from My Schedule
    [Arguments]   ${YEAR}    ${MONTH}    ${DATE}    ${HOSPITAL_NAME}     

    Select Year and Month    ${YEAR}     ${MONTH}
    IF    'Chris' not in '${HOSPITAL_NAME}'
        Maximize Calendar
    END
    Scroll Element Into View    xpath=(//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]

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
    [Arguments]    ${SHIFT_NAME_TIME}    ${DEPARTMENT}    ${WARD}    ${STARTHOUR}   ${STARTMIN}   ${ENDHOUR}    ${ENDMIN}

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
    # Execute only if shift is Custom
    IF    '${SHIFT_NAME_TIME}' == 'Custom'
        Log To Console    ⏱ Selecting custom shift time
        Select Custom Shift Time    ${STARTHOUR}    ${STARTMIN}    ${ENDHOUR}    ${ENDMIN}
    END

Select Custom Shift Time
    [Arguments]    ${STARTHOUR}    ${STARTMIN}    ${ENDHOUR}    ${ENDMIN}

    Wait Until Element Is Visible    (//div[contains(@class,'custom-equal-width')]//select)[3]    ${TIMEOUT}
    Click Element    (//div[contains(@class,'custom-equal-width')]//select)[3]//option[normalize-space()='${STARTHOUR}']   
    Wait Until Element Is Visible    (//div[contains(@class,'custom-equal-width')]//select)[4]    ${TIMEOUT}
    Click Element    (//div[contains(@class,'custom-equal-width')]//select)[4]//option[normalize-space()='${STARTMIN}']    
    Wait Until Element Is Visible    (//div[contains(@class,'custom-equal-width')]//select)[5]    ${TIMEOUT}
    Click Element    (//div[contains(@class,'custom-equal-width')]//select)[5]//option[normalize-space()='${ENDHOUR}']   
    Wait Until Element Is Visible    (//div[contains(@class,'custom-equal-width')]//select)[6]    ${TIMEOUT}
    Click Element    (//div[contains(@class,'custom-equal-width')]//select)[6]//option[normalize-space()='${ENDMIN}']    
    Log To Console    ✅ Custom shift time selected: ${STARTHOUR}:${STARTMIN} - ${ENDHOUR}:${ENDMIN}

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

Get Toggle Text
    [Arguments]    ${locator}

    Wait Until Element Is Visible    ${locator}    10s
    ${checkbox}=    Set Variable    ${locator}//input
    ${label}=       Set Variable    ${locator}//span[contains(@class,'switch-label')]
    ${is_checked}=    Run Keyword And Return Status    
    ...    Checkbox Should Be Selected    ${checkbox}
    ${on}=     Get Element Attribute    ${label}    data-on
    ${off}=    Get Element Attribute    ${label}    data-off
    ${state}=    Set Variable If    ${is_checked}    ${on}    ${off}
    RETURN    ${state}

Check Payment Type
    ${status}=    Get Toggle Text    //label[.//span[@data-on='P']]
    Log To Console    Payment Type: ${status}
    RETURN    ${status}

Select Comments Dropdown
    [Arguments]    ${COMMENTS}    ${DEPARTMENT}    ${WARD}    ${SHIFT_NAME_TIME}

    ${INDEX}=    Set Variable    5
    IF    '${DEPARTMENT}'!='' and '${WARD}'!=''
        ${INDEX}=    Evaluate    ${INDEX}+2
    ELSE IF    '${DEPARTMENT}'!='' or '${WARD}'!=''
        ${INDEX}=    Evaluate    ${INDEX}+1
    END

    IF    '${SHIFT_NAME_TIME}'=='Custom'
        ${INDEX}=    Evaluate    ${INDEX}+4
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