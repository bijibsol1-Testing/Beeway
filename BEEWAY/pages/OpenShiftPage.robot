*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot
Resource    ../resources/Login.robot
Resource    ../resources/Service.robot 
Resource    ../pages/BeewayDashboardPage.robot
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/ReplaceShiftPage.robot

*** Variables ***


*** Keywords ***
Open Shift In User Login
    [Arguments]    ${USERNAME}    ${PASSWORD}    ${YEAR}   ${MONTH}    ${DATE}  ${DOCTOR_NAME}     ${SHIFT_TIME}    ${OPERATION}   ${SHIFT}   ${SHIFT_COLOUR}    ${ROLE}
    [Tags]    Smoke    Regression 

     Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital    Prince of Wales Private Hospital
    Wait For Page Loader To Disappear
    Select Date from My Schedule    ${YEAR}    ${MONTH}    ${DATE}     
    ${DATE_SHIFT_XPATH}=    Set Variable
...    (//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${SHIFT_TIME}']]
    Wait Until Element Is Visible    xpath=${DATE_SHIFT_XPATH}    ${TIMEOUT_LONG}
    Click Element   xpath=${DATE_SHIFT_XPATH}   
    Select Shift Operation    ${OPERATION}
    Click Element    xpath=//label[contains(normalize-space(), '${SHIFT}')]
    Button Click    Open Shift
    Log To Console    ✅ Shift Opened with '${SHIFT}' for '${DOCTOR_NAME}' in User Login 
    Wait For Page Loader To Disappear
    Sleep    2s
    Select Date from My Schedule    ${YEAR}    ${MONTH}    ${DATE}
    ${DATE_SHIFT_XPATH}=    Set Variable
    ...    (//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${SHIFT_TIME}']]
    Wait Until Element Is Visible    xpath=${DATE_SHIFT_XPATH}    ${TIMEOUT_LONG}
    Validate Shift Colour Displayed      ${ROLE}    ${DATE}    ${SHIFT_COLOUR}    ${DOCTOR_NAME}    ${SHIFT_TIME}
    Log To Console    ✅ Shift colour '${SHIFT_COLOUR}' validated for '${DOCTOR_NAME}' in User Login
    




Open Shift in Admin Login
    [Arguments]    ${USERNAME}    ${PASSWORD}    ${YEAR}   ${MONTH}    ${DATE}  ${DOCTOR_NAME}    ${SHIFT_TIME}     ${OPERATION}    ${NAME_OF_USER_TO_OPEN_SHIFT}    ${SHIFT}    ${SHIFT_COLOUR}    ${ROLE}
    [Documentation]    End-to-end flow: Login → Beeway → Open Shift
    [Tags]    Smoke    Regression 

    Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital    Prince of Wales Private Hospital
    sleep    2s
    Select Date from Hospital Schedule    ${YEAR}    ${MONTH}    ${DATE} 
    Click Shift Based On Doctor And Time    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_TIME}
    Select Shift Operation    ${OPERATION}
    Click Element    xpath=//label[normalize-space()='${NAME_OF_USER_TO_OPEN_SHIFT}']
    Click Element    xpath=//label[contains(normalize-space(), '${SHIFT}')]
    Button Click    Open Shift
    Wait For Page Loader To Disappear
    Sleep    2s
    Select Date from Hospital Schedule    ${YEAR}    ${MONTH}    ${DATE} 
    Validate Shift Colour Displayed       ${ROLE}    ${DATE}    ${SHIFT_COLOUR}    ${DOCTOR_NAME}    ${SHIFT_TIME}
    Log To Console    ✅ Shift Opened with '${SHIFT}' for '${DOCTOR_NAME}' in Admin Login
   
    


    