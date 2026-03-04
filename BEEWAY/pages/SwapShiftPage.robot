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
Swap Shift In User Login
    [Arguments]    ${USERNAME}    ${PASSWORD}    ${YEAR}   ${MONTH}    ${DATE}  ${DOCTOR_NAME}     ${SHIFT_TIME}    ${OPERATION}    ${SWAP_USER}   ${SWAP_DATE}     ${DAY}   ${EXPECTED_MESSAGE}    ${ACTION}    ${VALIDATION_DATE}     
    [Documentation]    End-to-end flow: Login → Beeway → Swap Shift
    [Tags]    Smoke    Regression 

    Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital    Prince of Wales Private Hospital
    Sleep    2s
    Select Date from My Schedule    ${YEAR}    ${MONTH}    ${DATE} 
    wait Until Element Is Visible    xpath=(//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${SHIFT_TIME}']]   ${TIMEOUT_LONG}
    # Scroll to element    xpath=(//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${SHIFT_TIME}']]   
    ${DATE_SHIFT_XPATH}=    Set Variable
    ...    (//li[.//div[contains(@class,'date') and normalize-space()='${DATE}']])[1]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'shift-tme') and normalize-space()='${SHIFT_TIME}']]
    Log To Console    ✅ Shift element XPath: ${DATE_SHIFT_XPATH}
    Wait Until Element Is Visible    xpath=${DATE_SHIFT_XPATH}    ${TIMEOUT_LONG}
    Click Element   xpath=${DATE_SHIFT_XPATH}   
    Select Shift Operation    ${OPERATION}
    Select User For Swap Shift    ${SWAP_USER}    ${SWAP_DATE}     ${DAY}
    Button Click    Save
    sleep   2s
    Alert Handling With Validation    ${EXPECTED_MESSAGE}    ${ACTION}
    Wait For Page Loader To Disappear
    ${USER_SHIFT_EXISTS}=    User Shift exist Status    ${VALIDATION_DATE}    ${DOCTOR_NAME}    ${SHIFT_TIME}
    Should Be True    ${USER_SHIFT_EXISTS}    Shift not found for ${DOCTOR_NAME} on ${VALIDATION_DATE} with timing ${SHIFT_TIME}
    Log To Console    ✅ Shift for Dr.${DOCTOR_NAME} at ${SHIFT_TIME} on ${VALIDATION_DATE} found in Doctor Login


Swap Shift In Admin Login
    [Arguments]    ${USERNAME}    ${PASSWORD}    ${YEAR}   ${MONTH}    ${DATE}    ${DOCTOR_NAME}     ${SHIFT_TIME}    ${OPERATION}    ${SWAP_USER}    ${SWAP_DATE}     ${DAY}     ${EXPECTED_MESSAGE}    ${ACTION}     ${SHIFT_NAME}
    [Documentation]    End-to-end flow: Login → Beeway → Swap Shift in Admin Login
    [Tags]    Smoke    Regression        

    Login and Goto Dashboard   ${USERNAME}    ${PASSWORD}
    Wait For Page Loader To Disappear
    Goto Service    BeeWay
    Wait For Page Loader To Disappear
    Select Hospital    Prince of Wales Private Hospital
    Wait For Page Loader To Disappear
    sleep    2s
    Select Date from Hospital Schedule    ${YEAR}    ${MONTH}    ${DATE}
    Click Shift Based On Doctor And Time    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_TIME}
    Select Shift Operation    ${OPERATION}
    Select User For Swap Shift    ${SWAP_USER}    ${SWAP_DATE}     ${DAY}
    Button Click    Save
    sleep   2s
    Alert Handling With Validation    ${EXPECTED_MESSAGE}    ${ACTION}
    Wait For Page Loader To Disappear
    ${SHIFT_EXISTS}=    Get Shift exist Status    ${DATE}     ${SWAP_USER}   ${SHIFT_NAME}
    Should Be True     ${SHIFT_EXISTS}    Shift not found for ${SWAP_USER} on ${DATE} with shift name ${SHIFT_NAME}
    
    
Select User For Swap Shift
    [Arguments]    ${SWAP_USER}    ${DATE}     ${DAY}

    Wait Until Element Is Visible    xpath=//ul/li[.//div[normalize-space()='${SWAP_USER}'] and .//span[normalize-space()='${DATE} - ${DAY}']]
    Click Element    xpath=//ul/li[.//div[normalize-space()='${SWAP_USER}'] and .//span[normalize-space()='${DATE} - ${DAY}']]
    Log To Console    ✅ User '${SWAP_USER}' selected for swap shift on ${DATE} - ${DAY}

Alert Handling With Validation
    [Arguments]    ${EXPECTED_MESSAGE}    ${ACTION}

    ${ALERT_STATUS}=    Run Keyword And Return Status    Alert Should Be Present    text=${EXPECTED_MESSAGE}    action=LEAVE
    Log To Console    Alert Status: ${ALERT_STATUS}
    Run Keyword If    ${ALERT_STATUS}    Handle Alert    action=${ACTION}

Validate Swap Shift in User Login
  [Arguments]    ${DOCTORLOGIN}    ${PASSWORD}     ${YEAR}     ${MONTH}    ${DATE}    ${SWAP_USER}     ${ROLE}    ${SHIFT_TIME}    ${SHIFT_TEXT}    ${SHIFT_COLOUR}
  
  Validate Shift in Doctor login   ${DOCTORLOGIN}    ${PASSWORD}     ${YEAR}     ${MONTH}    ${DATE}     ${SWAP_USER}    ${SHIFT_TIME}
  Validate Shift Colour Displayed     ${ROLE}    ${DATE}    ${SHIFT_COLOUR}    ${SWAP_USER}    ${SHIFT_TIME}
  Log To Console    ✅ Swap Shift colour'${SHIFT_COLOUR}' 
  Hover Shift And Validate Tooltip     ${ROLE}    ${DATE}    ${SWAP_USER}    ${SHIFT_TIME}    ${SHIFT_TEXT}

Validate Swap Shift from Admin Login
    [Arguments]    ${USERNAME}    ${PASSWORD}    ${YEAR}     ${MONTH}    ${DATE}     ${SWAP_USER}    ${SHIFT_NAME}     ${ROLE}    ${DOCTOR_NAME}    ${SHIFT_TIME}    ${SHIFT_TEXT}    ${SHIFT_COLOUR}     ${VALIDATION_DATE}    ${SWAPPING_DATE}

    Validate shift from Admin Login     ${USERNAME}    ${PASSWORD}    ${YEAR}     ${MONTH}    ${DATE}     ${SWAP_USER}    ${SHIFT_NAME}     ${ROLE}    ${DOCTOR_NAME}    ${SHIFT_TIME}    ${SHIFT_TEXT}    ${SHIFT_COLOUR}
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//li[.//div[contains(@class,'date') and normalize-space()='${VALIDATION_DATE}']])[1]//h4[normalize-space()='${DOCTOR_NAME}']/ancestor::div[contains(@class,'user-section')][1][.//span[contains(@class,'time') and normalize-space()='${SHIFT_TIME}']]   ${TIMEOUT_LONG}
    Log To Console    ✅ Shift for Dr.${DOCTOR_NAME} at ${SHIFT_TIME} on ${VALIDATION_DATE} found in Admin Login
    Validate Shift Colour Displayed     ${ROLE}    ${VALIDATION_DATE}    ${SHIFT_COLOUR}    ${DOCTOR_NAME}    ${SHIFT_TIME}
    Log To Console    ✅ Swap Shift colour'${SHIFT_COLOUR}' 
    Hover Shift And Validate Tooltip     ${ROLE}    ${VALIDATION_DATE}    ${DOCTOR_NAME}    ${SHIFT_TIME}    Swap with ${SWAP_USER} ${SWAPPING_DATE} - 19:00 - 07:00
   
    



    