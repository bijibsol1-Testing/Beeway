*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot
Resource    ../resources/Login.robot
Resource    ../resources/Service.robot 
Resource    ../resources/PageSelect.robot
Resource    ../pages/BeewayDashboardPage.robot


*** Variables ***

*** Keywords ***

Add Shift in Beeway
    [Arguments]     ${USERNAME}    ${PASSWORD}    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}   ${MONTH}    ${DATE}    ${ACTION}    ${ROLE}   ${DEPARTMENT}   ${WARD}    ${DOCTOR_NAME}   ${SHIFT_NAME}    ${DUTY_TYPE}   ${COMMENTS}   
    [Documentation]    Login to Bijib and add shift in Beeway
    [Tags]    Smoke    Regression
    
    Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital     ${HOSPITAL_NAME}
    Sub Service selection    ${SUBSERVICE_NAME}
    sleep     2s 
    Select Date from Hospital Schedule    ${YEAR}     ${MONTH}    ${DATE}    
    ${DATE_XPATH}=    Set Variable    (//li[.//div[normalize-space()='${DATE}']])[1]
    Wait Until Element Is Visible    xpath=${DATE_XPATH}//li[normalize-space()='${ACTION}']     ${TIMEOUT_LONG}
    Click Element    xpath=${DATE_XPATH}//li[normalize-space()='${ACTION}']
    Add Shift   ${ROLE}   ${DEPARTMENT}    ${WARD}   ${DOCTOR_NAME}   ${SHIFT_NAME}    ${DUTY_TYPE}   ${COMMENTS}

    
Add Shift
    [Arguments]    ${ROLE}    ${DEPARTMENT}    ${WARD}    ${DOCTOR_NAME}   ${SHIFT_NAME_TIME}    ${DUTY_TYPE}   ${COMMENTS}

 
    Select Role Department Ward    ${ROLE}   ${DEPARTMENT}    ${WARD}
    # Select Role    ${ROLE}
    # Select Department    ${DEPARTMENT}
  
    Click Button    xpath=//button[normalize-space()='Select']
    Select Doctor    ${DOCTOR_NAME}
    Log To Console    ✅ Doctor selected
    Select Shift Dropdown    ${SHIFT_NAME_TIME}    ${DEPARTMENT}   ${WARD}
    Select Duty type Dropdown    ${DUTY_TYPE}    ${DEPARTMENT}    ${WARD}
    Log To Console    ✅ Shift & duty type selected
    Checkbox Should Be Selected    xpath=//input[@id='clash_checkbox']
    Log To Console    ✅ Clash verified
    Select Comments Dropdown    ${COMMENTS}    ${DEPARTMENT}    ${WARD}
    Button Click    Save
    Log To Console    ✅ Shift saved successfully

#validate shift added successfully in Admin Login
Get Shift exist Status without Ward
    [Arguments]    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_NAME}

     # --- Step 0: Wait for date to load ---
    ${DATE_TEXT_XPATH}=    Set Variable
    ...    //div[contains(@class,'date-text') and normalize-space(.)='${DATE}']

    Wait Until Element Is Visible    xpath=${DATE_TEXT_XPATH}    ${TIMEOUT_LONG} 

    # --- Step 1: Check & expand date (down arrow) if present ---
    ${DATE_ARROW_XPATH}=    Set Variable
    ...    //div[contains(@class,'date-text') and normalize-space(.)='${DATE}']
    ...    //i[contains(@class,'fa-chevron-down')]

    ${is_visible}=    Run Keyword And Return Status
    ...    Element Should Be Visible    xpath=${DATE_ARROW_XPATH}

    Run Keyword If    ${is_visible}
    ...    Click Element    xpath=${DATE_ARROW_XPATH}

    # --- Step 2: Build shift XPath ---
    ${SHIFT_LIST}=    Set Variable    //li[descendant::div[contains(@class,'date-text') and normalize-space(.)='${DATE}']]//div[contains(@class,'user-section-list')]//div[contains(@class,'user-section')][descendant::h4[normalize-space(.)='${DOCTOR_NAME}'] and descendant::div[contains(@class,'shift-name')]//span[contains(normalize-space(.),'${SHIFT_NAME}')]]
    Log To Console    Shift XPath: ${SHIFT_LIST}
    
    # --- Step 3: Check shift exists ---
    Wait Until Element Is Visible    xpath=${SHIFT_LIST}    ${TIMEOUT_LONG} 
    ${exists}=    Run Keyword And Return Status
    ...    Page Should Contain Element    xpath=${SHIFT_LIST}
    RETURN     ${exists}

Get Shift exist Status with Ward
    [Arguments]    ${DATE}    ${DOCTOR_NAME}    ${TIME}    ${WARD}

    ${DATE_TEXT_XPATH}=    Set Variable
    ...    //div[contains(@class,'date-text') and normalize-space(.)='${DATE}']

    Wait Until Element Is Visible    xpath=${DATE_TEXT_XPATH}    ${TIMEOUT_LONG} 
    ${DATE_ARROW_XPATH}=    Set Variable
    ...    //div[contains(@class,'date-text') and normalize-space(.)='${DATE}']
    ...    //i[contains(@class,'fa-chevron-down')]

    ${is_visible}=    Run Keyword And Return Status
    ...    Element Should Be Visible    xpath=${DATE_ARROW_XPATH}

    Run Keyword If    ${is_visible}
    ...    Click Element    xpath=${DATE_ARROW_XPATH}

    ${SHIFT_LIST}=    Set Variable    //li[descendant::div[contains(@class,'date-text') and normalize-space(.)='${DATE}']]//div[contains(@class,'user-section-list')]//div[contains(@class,'user-section')][descendant::h4[normalize-space(.)='${DOCTOR_NAME}'] and .//span[contains(@class,'time') and contains(normalize-space(),'${TIME}')] and .//div[contains(@class,'shift-name')]//span[normalize-space()='${WARD}']]
    Log To Console    Shift XPath: ${SHIFT_LIST}

     Wait Until Element Is Visible    xpath=${SHIFT_LIST}    ${TIMEOUT_LONG} 
    ${exists}=    Run Keyword And Return Status
    ...    Page Should Contain Element    xpath=${SHIFT_LIST}
    RETURN     ${exists}

Get Shift Exist Status Admin Login
    [Arguments]    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_NAME}    ${TIME}    ${WARD}

    IF    '${WARD}' == '' or '${WARD}' == '${EMPTY}'
        ${exists}=    Get Shift exist Status without Ward    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_NAME}
    ELSE
        ${exists}=    Get Shift exist Status with Ward    ${DATE}    ${DOCTOR_NAME}    ${TIME}    ${WARD}
    END
    RETURN    ${exists}

Validate Shift in Doctor login
    [Arguments]    ${DOCTORLOGIN}    ${PASSWORD}     ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}     ${MONTH}    ${DATE}     ${DOCTOR_NAME}    ${TIME}

    Login and Goto Dashboard   ${DOCTORLOGIN}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital     ${HOSPITAL_NAME} 
    Sub Service selection    ${SUBSERVICE_NAME}
    sleep     2s  
    Select Date from My Schedule    ${YEAR}     ${MONTH}    ${DATE}  
    ${USER_SHIFT_EXISTS}=    User Shift exist Status    ${DATE}    ${DOCTOR_NAME}    ${TIME}
    Should Be True    ${USER_SHIFT_EXISTS}    Shift not found for ${DOCTOR_NAME} on ${DATE} with timing ${TIME}
    Log To Console    ✅ Shift for Dr.${DOCTOR_NAME} at ${TIME} on ${DATE} found in Doctor Login
    





    