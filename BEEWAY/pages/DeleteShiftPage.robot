** Settings ***
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot
Resource    ../resources/Login.robot
Resource    ../resources/Service.robot 
Resource    ../resources/PageSelect.robot
Resource    ../pages/BeewayDashboardPage.robot
Resource    ../Variables/TEST.robot

*** Variables ***        

*** Keywords ***
Delete Shift in Beeway
    [Arguments]     ${USERNAME}    ${PASSWORD}    ${SERVICE_NAME}    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${YEAR}   ${MONTH}    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_TIME}
    [Documentation]    Login to Bijib and delete shift in Beeway
    [Tags]    Smoke    Regression
    
    Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    ${SERVICE_NAME}
    Wait For Page Loader To Disappear
    Select Hospital     ${HOSPITAL_NAME}
    sleep     2s
    Sub Service selection    ${SUBSERVICE_NAME}
    sleep     2s 
    Select Date from Hospital Schedule    ${YEAR}     ${MONTH}    ${DATE}    ${HOSPITAL_NAME}  
    ${DATE_XPATH}=    Set Variable    (//li[.//div[normalize-space()='${DATE}']])[1]
    ${SHIFT_XPATH}=    Set Variable    xpath=${DATE_XPATH}//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'time') and normalize-space()='${SHIFT_TIME}']]    
    Wait Until Element Is Visible    ${SHIFT_XPATH}    ${TIMEOUT_LONG}
    Click Element   ${SHIFT_XPATH}
    Button Click    Delete
    Button Click    Delete Shift

Verify Shift is Deleted
    
    Wait Until Element Is Not Visible    ${SHIFT_XPATH}    ${TIMEOUT_LONG}
    Log to Console    Shift is deleted successfully with${SHIFT_XPATH}