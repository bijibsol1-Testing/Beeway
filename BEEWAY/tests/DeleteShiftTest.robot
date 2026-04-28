*** Settings ***
Library     SeleniumLibrary    screenshot_root_directory=${EXECDIR}/results/Screenshots
Library     allure_robotframework
Library     DataDriver    file=../data/Delete_Shift_data.csv    dialect=excel
Resource    ../pages/DeleteShiftPage.robot
Resource    ../resources/DateKeywords.robot

Test Setup    Open Browser To Application
Test Teardown    Close Application Browser
Test Template    Delete Shift Test


*** Test Cases ***
Delete Shift Test in CSV    

*** Keywords ***
Delete Shift Test
    [Arguments]    ${HOSPITAL_NAME}    ${SUBSERVICE_NAME}    ${SHIFT_DATE_CONSTANT}    ${DOCTOR_NAME}    ${TIME}    ${SHIFT_TIME}    ${DOCTORLOGIN}   ${DUTY_TYPE_SYMBOL}    ${PAYMENT_TYPE}
    [Tags]    Smoke    Regression
     
    ${DATE}=    Get Day From Date    ${SHIFT_DATE_CONSTANT}
    ${MONTH}=    Get Month From Date    ${SHIFT_DATE_CONSTANT}    short    True
    ${YEAR}=    Get Year From Date    ${SHIFT_DATE_CONSTANT}

    Delete Shift in Beeway     
    ...    ${HOSPITAL_NAME}    
    ...    ${SUBSERVICE_NAME}    
    ...    ${YEAR}   
    ...    ${MONTH}    
    ...    ${DATE}    
    ...    ${DOCTOR_NAME}    
    ...    ${TIME}
    Sleep     2s
    Verify Shift is Deleted     
    ...    ${DATE}    
    ...    ${DOCTOR_NAME}    
    ...    ${TIME}
    Close Application Browser

    Open Browser To Application
    ${DATE}=    Get Day From Date    ${SHIFT_DATE_CONSTANT}
    ${MONTH}=    Get Month From Date    ${SHIFT_DATE_CONSTANT}    short    True
    ${YEAR}=    Get Year From Date    ${SHIFT_DATE_CONSTANT}
  
    Validate Shift Deletion in User Login    
    ...    ${DOCTORLOGIN}    
    ...    ${HOSPITAL_NAME}    
    ...    ${SUBSERVICE_NAME}    
    ...    ${YEAR}   
    ...    ${MONTH}    
    ...    ${DATE}    
    ...    ${DOCTOR_NAME} 
    ...    ${TIME}   
    ...    ${SHIFT_TIME}    
    ...    ${DUTY_TYPE_SYMBOL}    
    ...    ${PAYMENT_TYPE}