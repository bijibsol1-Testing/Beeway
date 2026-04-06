*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot
Resource    ../resources/Login.robot
Resource    ../resources/Service.robot 
Resource    ../pages/BeewayDashboardPage.robot
Resource    ../pages/AddShiftPage.robot

*** Variables ***


*** Keywords ***
Replace Shift In User Login
    [Arguments]    ${USER_LOGIN}    ${PASSWORD}    ${SERVICE_NAME}    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}   ${MONTH}    ${DATE}  ${DOCTOR_NAME}     ${SHIFT_TIME}    ${OPERATION}    ${REPLACE_USER}    
    [Tags]    Smoke    Regression 

    Login and Goto Dashboard   ${USER_LOGIN}    ${PASSWORD}
    Goto Service    ${SERVICE_NAME}
    Wait For Page Loader To Disappear
    Select Hospital     ${HOSPITAL_NAME}
    Wait For Page Loader To Disappear
    Sub Service selection    ${SUBSERVICE_NAME}
    Select Date from My Schedule    ${YEAR}    ${MONTH}    ${DATE}    ${HOSPITAL_NAME} 
    ${DATE_SHIFT_XPATH}=    Set Variable
...    (//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${SHIFT_TIME}']]
    Wait Until Element Is Visible    xpath=${DATE_SHIFT_XPATH}    ${TIMEOUT_LONG}
    Click Element   xpath=${DATE_SHIFT_XPATH}   
    Select Shift Operation    ${OPERATION}
    select Doctor    ${REPLACE_USER}
    Button Click    Replace Shift
    Wait For Page Loader To Disappear
    Wait Until Element Is Visible    xpath=${DATE_SHIFT_XPATH}    ${TIMEOUT}
    Log To Console    ✅ Shift Replaced with '${REPLACE_USER}'

Replace Shift In Admin Login
    [Arguments]    ${USERNAME}    ${PASSWORD}    ${SERVICE_NAME}    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}   ${MONTH}    ${DATE}    ${DOCTOR_NAME}     ${SHIFT_TIME}     ${REPLACE_USER}  
    [Documentation]    End-to-end flow: Login → Beeway → Replace Shift in Admin Login
    [Tags]    Smoke    Regression        

    Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    ${SERVICE_NAME}
    Wait For Page Loader To Disappear
    Select Hospital     ${HOSPITAL_NAME}
    Wait For Page Loader To Disappear
    Sub Service selection    ${SUBSERVICE_NAME}
    Wait For Page Loader To Disappear
    sleep    2s
    Select Date from Hospital Schedule    ${YEAR}    ${MONTH}    ${DATE}    ${HOSPITAL_NAME}
    Click Shift Based On Doctor And Time    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_TIME}
    Button Click    Replace
    Log To Console    ✅ Clicked 'Replace' button in Admin Login
    select Doctor    ${REPLACE_USER}
    Button Click     Edit & Save
    Wait For Page Loader To Disappear
    Log To Console    ✅ Shift replaced with '${REPLACE_USER}' in Admin Login

Select Shift Operation
    [Arguments]    ${OPERATION}

    ${OPERATION_XPATH}=    Set Variable
    ...    (//div[contains(@class,'shift-card') and .//div[normalize-space()='${OPERATION}']])[1]
    Wait Until Element Is Visible    xpath=${OPERATION_XPATH}    ${TIMEOUT_LONG}
    Click Element   xpath=${OPERATION_XPATH}
    Log To Console    ✅ Shift Operation '${OPERATION}' selected

Click Shift Based On Doctor And Time
    [Arguments]    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_TIME}

    # Date container
    ${DATE_CONTAINER}=    Set Variable
    ...    (//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]

    Scroll Element Into View    xpath=${DATE_CONTAINER}

    # Down arrow inside date block
    ${ARROW_XPATH}=    Set Variable
    ...    ${DATE_CONTAINER}//div[contains(@class,'show-more')]//i[contains(@class,'fa-chevron-down')]

    ${arrow_present}=    Run Keyword And Return Status
    ...    Element Should Be Visible    xpath=${ARROW_XPATH}

    # Click arrow only if present
    Run Keyword If    ${arrow_present}
    ...    Click Element    xpath=${ARROW_XPATH}

    # Shift selection
    ${DATE_SHIFT_XPATH}=    Set Variable        
    ...     ${DATE_CONTAINER}//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'time') and normalize-space()='${SHIFT_TIME}']]

    Wait Until Element Is Visible    xpath=${DATE_SHIFT_XPATH}    ${TIMEOUT_LONG}
    Scroll Element Into View        xpath=${DATE_SHIFT_XPATH}
    Click Element        xpath=${DATE_SHIFT_XPATH}
    Log To Console    ✅ Clicked shift for Dr.${DOCTOR_NAME} at ${SHIFT_TIME} on ${DATE}


Validate Replace Shift In User Login
    [Arguments]    ${DOCTORLOGIN}    ${PASSWORD}     ${SERVICE_NAME}    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}     ${MONTH}    ${DATE}    ${REPLACE_USER}    ${SHIFT_TIME}    ${SHIFT_COLOUR}    ${SHIFT_TEXT}

    Validate Shift in Doctor login      ${DOCTORLOGIN}   ${PASSWORD}     ${SERVICE_NAME}    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}     ${MONTH}    ${DATE}     ${REPLACE_USER}    ${SHIFT_TIME}
    Validate Shift Colour Displayed    USER    ${DATE}    ${SHIFT_COLOUR}    ${REPLACE_USER}    ${SHIFT_TIME}
    Log To Console    ✅ Replace Shift colour'${SHIFT_COLOUR}' 
    Hover Shift And Validate Tooltip     USER    ${DATE}    ${REPLACE_USER}    ${SHIFT_TIME}    ${SHIFT_TEXT}


Validate shift from Admin Login
    [Arguments]    ${USERNAME}    ${PASSWORD}    ${SERVICE_NAME}    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}     ${MONTH}    ${DATE}     ${REPLACE_USER}    ${SHIFT_NAME}    ${WARD}    ${DOCTOR_NAME}    ${SHIFT_TIME}    ${SHIFT_COLOUR}    ${SHIFT_TEXT}

    Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    ${SERVICE_NAME}
    Wait For Page Loader To Disappear
    Select Hospital     ${HOSPITAL_NAME}
    sleep   2s
    Wait For Page Loader To Disappear
    Sub Service selection    ${SUBSERVICE_NAME}
    Wait For Page Loader To Disappear
    sleep    2s
    Select Date from Hospital Schedule    ${YEAR}    ${MONTH}    ${DATE}    ${HOSPITAL_NAME}
    ${SHIFT_EXISTS}=    Get Shift Exist Status Admin Login    ${DATE}     ${REPLACE_USER}   ${SHIFT_NAME}    ${SHIFT_TIME}    ${WARD}
    Should Be True     ${SHIFT_EXISTS}    Shift not found for ${REPLACE_USER} on ${DATE} with shift name ${SHIFT_NAME}
    Validate Shift Colour Displayed     ADMIN    ${DATE}    ${SHIFT_COLOUR}    ${REPLACE_USER}    ${SHIFT_TIME}
    Log To Console    ✅ Replace Shift colour'${SHIFT_COLOUR}' 
    Hover Shift And Validate Tooltip     ADMIN    ${DATE}    ${REPLACE_USER}    ${SHIFT_TIME}     ${SHIFT_TEXT}
    Log To Console    ✅ Shift '${SHIFT_NAME}' found for ${REPLACE_USER} on ${DATE} in Admin Login
   
Hover Shift And Validate Tooltip
    [Arguments]    ${ROLE}    ${DATE}    ${REPLACE_USER}    ${SHIFT_TIME}    ${SHIFT_TEXT} 

    ${DATE_CONTAINER}=    Set Variable
    ...    (//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]

    IF    '${ROLE}' == 'USER'

        ${SHIFT_XPATH}=    Set Variable
        ...    ${DATE_CONTAINER}//h4[normalize-space()='${REPLACE_USER}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${SHIFT_TIME}']]

    ELSE IF    '${ROLE}' == 'ADMIN'

        ${SHIFT_XPATH}=    Set Variable
        ...    ${DATE_CONTAINER}//h4[normalize-space()='${REPLACE_USER}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'time') and normalize-space()='${SHIFT_TIME}']]

    END

    Wait Until Element Is Visible    xpath=${SHIFT_XPATH}    ${TIMEOUT_LONG}
    Scroll Element Into View         xpath=${SHIFT_XPATH}
    Mouse Over     xpath=${SHIFT_XPATH}

    ${TOOLTIP_XPATH}=    Set Variable
    ...    ${SHIFT_XPATH}//span[normalize-space()='${SHIFT_TEXT}']

    Wait Until Element Is Visible    xpath=${TOOLTIP_XPATH}    ${TIMEOUT_LONG}
    Element Text Should Be      xpath=${TOOLTIP_XPATH}    ${SHIFT_TEXT}

    Log To Console    ✅ Tooltip '${SHIFT_TEXT}' validated for ${ROLE} role


Validate Shift Colour Displayed 
    [Arguments]    ${ROLE}    ${DATE}    ${SHIFT_COLOUR}    ${DOCTOR_NAME}    ${SHIFT_TIME}

    ${DATE_CONTAINER}=    Set Variable
    ...    (//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]

    IF    '${ROLE}' == 'USER'

        ${SHIFT_XPATH}=    Set Variable    ${DATE_CONTAINER}//div[contains(@class,'${SHIFT_COLOUR}')]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${SHIFT_TIME}']]

    ELSE IF    '${ROLE}' == 'ADMIN'

        ${SHIFT_XPATH}=    Set Variable     ${DATE_CONTAINER}//div[contains(@class,'${SHIFT_COLOUR}')][.//h4[normalize-space()='${DOCTOR_NAME}'] and .//span[contains(@class,'time') and contains(normalize-space(),'${SHIFT_TIME}')]]

    ELSE
        Fail    Invalid ROLE provided: ${ROLE}
    END
    Log To Console   SHIFT_XPATH: ${SHIFT_XPATH} Role:${ROLE}
    ${status}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    xpath=${SHIFT_XPATH}    ${TIMEOUT}

    Run Keyword If    ${status}
    ...    Log To Console    ✅ ${ROLE} - Shift colour '${SHIFT_COLOUR}' is displayed
    ...  ELSE
    ...    Fail    ❌ ${ROLE} - Shift colour '${SHIFT_COLOUR}' is NOT displayed



