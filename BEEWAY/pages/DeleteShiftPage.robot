** Settings ***
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot
Resource    ../resources/Login.robot
Resource    ../resources/Service.robot 
Resource    ../resources/PageSelect.robot
Resource    ../pages/BeewayDashboardPage.robot
Resource    ../variables/TEST.robot

*** Variables ***        

*** Keywords ***
Delete Shift in Beeway
    [Arguments]    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}   ${MONTH}    ${DATE}    ${DOCTOR_NAME}    ${TIME}
    [Documentation]    Login to Bijib and delete shift in Beeway
    [Tags]    Smoke    Regression
    
    Login and Goto Dashboard   rgarikapati    E7q_35&ZR]5D*iRZ
    Wait For Page Loader To Disappear
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital     ${HOSPITAL_NAME}
    sleep     2s
    Sub Service selection    ${SUBSERVICE_NAME}
    sleep     2s 
    Select Date from Hospital Schedule    ${YEAR}     ${MONTH}    ${DATE}    ${HOSPITAL_NAME}  
    ${DATE_XPATH}=    Set Variable    (//li[.//div[normalize-space()='${DATE}']])[1]
    ${SHIFT_XPATH}=    Set Variable    xpath=${DATE_XPATH}//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'time') and normalize-space()='${TIME}']]    
    Wait Until Element Is Visible    ${SHIFT_XPATH}    ${TIMEOUT_LONG}
    Click Element   ${SHIFT_XPATH}
    Button Click    Delete
    Button Click    Delete Shift

Verify Shift is Deleted
    [Arguments]    ${DATE}    ${DOCTOR_NAME}    ${TIME}

    ${DATE_XPATH}=    Set Variable    (//li[.//div[normalize-space()='${DATE}']])[1]
    ${SHIFT_XPATH}=    Set Variable    xpath=${DATE_XPATH}//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'time') and normalize-space()='${TIME}']]

    ${status}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${SHIFT_XPATH}    ${TIMEOUT_LONG}

    Run Keyword If    ${status}    Log To Console    Shift is deleted successfully: ${SHIFT_XPATH}
    ...    ELSE    Fail    Shift is still visible: ${SHIFT_XPATH}

Validate Shift Deletion in User Login
    [Arguments]    ${DOCTORLOGIN}    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}   ${MONTH}    ${DATE}    ${DOCTOR_NAME}    ${TIME}    ${SHIFT_TIME}    ${DUTY_TYPE_SYMBOL}    ${PAYMENT_TYPE}
    
    Login and Goto Dashboard   ${DOCTORLOGIN}    E7q_35&ZR]5D*iRZ
    Wait For Page Loader To Disappear
    ${status}=    Run Keyword And Return Status
    ...    Verify UMS Calender Shift
    ...    ${MONTH}    ${YEAR}    ${DATE}    ${SHIFT_TIME}    ${DUTY_TYPE_SYMBOL}    ${PAYMENT_TYPE}    ${DOCTOR_NAME}

    Run Keyword If    ${status}
    ...    Fail    Shift is still visible in UMS Calendar
    ...    ELSE
    ...    Log To Console    Shift is deleted successfully in UMS Calendar
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital     ${HOSPITAL_NAME} 
    sleep     2s
    Sub Service selection    ${SUBSERVICE_NAME}
    Select Date from My Schedule    ${YEAR}     ${MONTH}    ${DATE}    ${HOSPITAL_NAME}
   ${USER_SHIFT_EXISTS}=    Run Keyword And Return Status
    ...    User Shift exist Status
    ...    ${DATE}    ${DOCTOR_NAME}    ${TIME}

    Run Keyword If    ${USER_SHIFT_EXISTS}
    ...    Fail    Shift still exists for ${DOCTOR_NAME} on ${DATE} with timing ${TIME}
    ...    ELSE
    ...    Log To Console    Shift successfully deleted for ${DOCTOR_NAME} on ${DATE} with timing ${TIME}