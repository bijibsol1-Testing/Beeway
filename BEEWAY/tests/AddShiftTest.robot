*** Settings ***
Library     SeleniumLibrary
Library    DataDriver    file=../data/AddShiftData.csv    dialect=excel
Resource    ../pages/AddShiftPage.robot

# Suite Setup    Open Browser To Application
# Suite Teardown    Close Application Browser
# Test Template    Add Shift Test

Test Setup    Open Browser To Application
Test Teardown    Close Application Browser
Test Template    Add Shift Test


*** Keywords ***
Add Shift Test
    [Arguments]  
    ...    ${USERNAME}    
    ...    ${PASSWORD} 
    ...    ${HOSPITAL_NAME} 
    ...    ${SUBSERVICE_NAME}  
    ...    ${YEAR}
    ...    ${MONTH}
    ...    ${DATE}
    ...    ${ACTION}
    ...    ${ROLE}
    ...    ${DEPARTMENT}
    ...    ${WARD}
    ...    ${DOCTOR_NAME}
    ...    ${SHIFT_NAME}
    ...    ${SHIFT_NAME_TIME}
    ...    ${DUTY_TYPE}
    ...    ${COMMENTS}
    ...    ${TIME}
    ...    ${DOCTORLOGIN}


    # Open Browser To Application
    Add Shift in Beeway  
    ...   ${USERNAME}    
    ...   ${PASSWORD} 
    ...   ${HOSPITAL_NAME} 
    ...   ${SUBSERVICE_NAME}
    ...   ${YEAR}
    ...   ${MONTH}
    ...   ${DATE}
    ...   ${ACTION}
    ...   ${ROLE}
    ...   ${DEPARTMENT}
    ...   ${WARD}
    ...   ${DOCTOR_NAME}
    ...   ${SHIFT_NAME_TIME}
    ...   ${DUTY_TYPE}
    ...   ${COMMENTS}

    Sleep    2s

    ${SHIFT_EXISTS}=    
    ...    Get Shift Exist Status Admin Login    
    ...   ${DATE}    ${DOCTOR_NAME}    ${SHIFT_NAME}    ${TIME}    ${WARD}

    Should Be True     ${SHIFT_EXISTS}
    Open Browser To Application

    Validate Shift in Doctor login     
    ...    ${DOCTORLOGIN}
    ...    ${PASSWORD}
    ...    ${HOSPITAL_NAME}
    ...    ${SUBSERVICE_NAME}
    ...    ${YEAR}
    ...    ${MONTH}
    ...    ${DATE}
    ...    ${DOCTOR_NAME}
    ...    ${TIME}
    Close Application Browser


*** Test Cases ***
Add Shift Using CSV
    [Tags]    Smoke    Regression




