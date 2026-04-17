*** Settings ***
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot  
Resource    ../pages/ModpayAdminInvoicePage.robot
Resource    ../pages/AddShiftPage.robot
Resource    ../resources/DateKeywords.robot


*** Keywords ***
UMS Refresh Button

    wait Until Element Is Visible    xpath=//div[normalize-space()='Refresh']    ${TIMEOUT}
    Click Element    xpath=//div[normalize-space()='Refresh']
    Wait For Page Loader To Disappear 
    Log to Console    UMS Refresh Button Clicked Successfully

UMS Calennder Year and Month Selection
    [Arguments]    ${MONTH}    ${YEAR}

    ${Calender_Icon_Path}=    Set Variable    xpath=//img[@alt='calendar-img']    
    wait Until Element Is Visible    ${Calender_Icon_Path}    ${TIMEOUT}
    Click Element    ${Calender_Icon_Path}
    Wait For Page Loader To Disappear 
    Log to Console    UMS Calender icon Clicked Successfully
    Wait Until Element Is Visible    xpath=//ul//li[normalize-space(.)='Month']    ${TIMEOUT}
    Click Element    xpath=//ul//li[normalize-space(.)='${MONTH}']
    Wait Until Element Is Visible    xpath=//ul//li[normalize-space(.)='Year']    ${TIMEOUT}
    Click Element    xpath=//ul//li[normalize-space(.)='Year']
    Sleep    1s
    Click Element    xpath=//li[normalize-space(text())='2026']
    Button Click    Done
    Wait For Page Loader To Disappear

Check Shift with date
    [Arguments]    ${DATE}    ${SHIFT_TIME}    ${DUTY_TYPE_SYMBOL}    ${PAYMENT_TYPE}    ${DOCTOR_NAME}

     # --- Step 0: Wait for date to load ---

    ${shift_path}=    Set Variable    //div[contains(@class,'day-data-item')][.//p[normalize-space(.)='${DATE}']]//div[contains(@class,'user-event-dtls')][.//span[contains(@class,'time') and normalize-space(.)='${SHIFT_TIME}']][.//img[contains(@class,'${DUTY_TYPE_SYMBOL}-img')]]
    ${dollar_symbol_path}=    Set Variable    [.//img[contains(@class,'dollar-img')]]
    IF    '${PAYMENT_TYPE}' == 'P'
        ${xpath}=    Set Variable    ${shift_path}${dollar_symbol_path}
        Log To Console    ✅ Verifying paid shift with dollar symbol
    ELSE
        ${xpath}=    Set Variable    ${shift_path}
        Log To Console    ⛔ Skipping dollar filter (un-paid shift)
    END

    # Scroll Element Into View    xpath=${xpath}
    Capture Screenshot Step    UMS_Shift${DOCTOR_NAME}
    Log To Console    Screenshot Captured successfully

Verify UMS Calender Shift 
    [Arguments]    ${MONTH}    ${YEAR}    ${DATE}    ${SHIFT-TIME}    ${DUTY_TYPE_SYMBOL}    ${PAYMENT_TYPE}      ${DOCTOR_NAME}  
    
    UMS Refresh Button
    UMS Calennder Year and Month Selection    ${MONTH}    ${YEAR}
    Check Shift with date     ${DATE}    ${SHIFT-TIME}    ${DUTY_TYPE_SYMBOL}    ${PAYMENT_TYPE}    ${DOCTOR_NAME}


