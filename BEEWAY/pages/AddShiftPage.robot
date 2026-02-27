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
    [Arguments]     ${YEAR}   ${MONTH}    ${DATE}    ${ACTION}    ${ROLE}   ${DEPARTMENT}   ${WARD}   ${DOCTOR_NAME}   ${SHIFT_NAME}    ${DUTY_TYPE}   ${COMMENTS}
    [Documentation]    Login to Bijib and add shift in Beeway
    [Tags]    Smoke    Regression
    
    Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital     Prince of Wales Private Hospital 
    sleep     2s  
    Select Date from Hospital Schedule    ${YEAR}     ${MONTH}    ${DATE}    
    ${DATE_XPATH}=    Set Variable    (//li[.//div[normalize-space()='${DATE}']])[1]
    Wait Until Element Is Visible    xpath=${DATE_XPATH}//li[normalize-space()='${ACTION}']     ${TIMEOUT_LONG}
    Click Element    xpath=${DATE_XPATH}//li[normalize-space()='${ACTION}']
    Add Shift   ${ROLE}   ${DEPARTMENT}    ${WARD}   ${DOCTOR_NAME}   ${SHIFT_NAME}    ${DUTY_TYPE}   ${COMMENTS}


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
    
Add Shift
    [Arguments]    ${ROLE}    ${DEPARTMENT}    ${WARD}    ${DOCTOR_NAME}   ${SHIFT_NAME_TIME}    ${DUTY_TYPE}   ${COMMENTS}

    #select Role
    # Dropdown With Label    Role:    ${ROLE}
    # Log To Console    ✅ Role selected

    Select Role Department Ward If Present     ${ROLE}   ${DEPARTMENT}    ${WARD}
    #user select button
    Click Button    xpath=//button[normalize-space()='Select']
    select Doctor    ${DOCTOR_NAME}
    Log To Console    ✅ Doctor selected

    #select Shift & Duty type
    Dropdown With Index    ${SHIFT_NAME_TIME}    4
    Dropdown With Index    ${DUTY_TYPE}    4
    Log To Console    ✅ Shift & duty type selected

    #verify clash
    Checkbox Should Be Selected    xpath=//input[@id='clash_checkbox']
    Log To Console    ✅ Clash verified
    
   #add comments and save

    Dropdown With Index    ${COMMENTS}    5
    Button Click    Save
    Log To Console    ✅ Shift saved successfully

#validate shift added successfully in Admin Login
Get Shift exist Status
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


Validate Shift in Doctor login
    [Arguments]    ${DOCTORLOGIN}    ${PASSWORD}     ${YEAR}     ${MONTH}    ${DATE}     ${DOCTOR_NAME}    ${TIME}

    Login and Goto Dashboard   ${DOCTORLOGIN}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital     Prince of Wales Private Hospital 
    sleep     2s  
    Select Date from My Schedule    ${YEAR}     ${MONTH}    ${DATE}  
    ${USER_SHIFT_EXISTS}=    User Shift exist Status    ${DATE}    ${DOCTOR_NAME}    ${TIME}
    Should Be True    ${USER_SHIFT_EXISTS}    Shift not found for ${DOCTOR_NAME} on ${DATE} with timing ${TIME}
    Log To Console    ✅ Shift for Dr.${DOCTOR_NAME} at ${TIME} on ${DATE} found in Doctor Login
    
User Shift exist Status
    [Arguments]    ${DATE}    ${DOCTOR_NAME}    ${TIME} 

    ${USER_SHIFT_LIST}=    Set Variable    //li[.//div[contains(@class,'date') and normalize-space()='${DATE}']]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${TIME}']]
    Log To Console    Shift XPath: ${USER_SHIFT_LIST} 
    Wait Until Element Is Visible    xpath=${USER_SHIFT_LIST}    ${TIMEOUT_LONG} 
    ${exists}=    Run Keyword And Return Status
    ...    Page Should Contain Element    xpath=${USER_SHIFT_LIST}
    RETURN     ${exists}

Select Role Department Ward If Present
    [Arguments]    ${ROLE}   ${DEPARTMENT}    ${WARD}

    # -------- ROLE --------

    ${role_present}=    Run Keyword And Return Status
    ...    Page Should Contain Element    xpath=//label[contains(normalize-space(.),'Role')]/following::select[1]        ${TIMEOUT}

   IF    ${role_present} and '${ROLE}' != ''
    Wait Until Element Is Visible     xpath=//label[contains(normalize-space(.),'Role')]/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label[contains(normalize-space(.),'Role')]/following::select[1]    ${ROLE}
    Log To Console    ✅ Role selected
   ELSE
    Log To Console    ⚠ Role not displayed — skipping
   END

    # -------- DEPARTMENT --------
 
    ${dept_present}=    Run Keyword And Return Status
    ...    Page Should Contain Element    xpath=//div[label[normalize-space(text())="Department:"]]       ${TIMEOUT}

    IF    ${dept_present} and '${DEPARTMENT}' != ''
        Dropdown With Label    Department:    ${DEPARTMENT}
        Log To Console    ✅ Department selected
    ELSE
        Log To Console    ⚠ Department not displayed — skipping
    END

    # -------- WARD --------
   
    ${ward_present}=    Run Keyword And Return Status
    ...    Page Should Contain Element    xpath=//div[label[normalize-space(text())="Ward:"]]       ${TIMEOUT}

    IF    ${ward_present} and '${WARD}' != ''
        Dropdown With Label    Ward:    ${WARD}
        Log To Console    ✅ Ward selected
    ELSE
        Log To Console    ⚠ Ward not displayed — skipping
    END