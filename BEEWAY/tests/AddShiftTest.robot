*** Settings ***
Library     SeleniumLibrary
Library    allure_robotframework
Library    DataDriver    file=../data/AddShiftData.csv    dialect=excel
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/LoginPage.robot

# Suite Setup    Open Browser To Application
# Suite Teardown    Close Application Browser
# Test Template    Add Shift Test

Test Setup    Open Browser To Application
Test Teardown    Run Keywords    Attach Screenshot To Allure    AND    Close Application Browser
Test Template    Add Shift Test


*** Keywords ***
Add Shift Test
    [Arguments]  
    ...    ${USERNAME}    
    ...    ${PASSWORD}
    ...    ${SERVICE_NAME} 
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
    ...    ${STARTHOUR}
    ...    ${STARTMIN}                
    ...    ${ENDHOUR}
    ...    ${ENDMIN}


    # Open Browser To Application
    Add Shift in Beeway  
    ...   ${USERNAME}    
    ...   ${PASSWORD}
    ...   ${SERVICE_NAME} 
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
    ...   ${STARTHOUR}
    ...   ${STARTMIN}   
    ...   ${ENDHOUR}    
    ...   ${ENDMIN}

    Sleep    2s

    ${SHIFT_EXISTS}=    
    ...    Get Shift Exist Status Admin Login    
    ...   ${DATE}    ${DOCTOR_NAME}    ${SHIFT_NAME}    ${TIME}    ${WARD}

    Should Be True     ${SHIFT_EXISTS}
    Open Browser To Application

    Validate Shift in Doctor login     
    ...    ${DOCTORLOGIN}
    ...    ${PASSWORD}
    ...    ${SERVICE_NAME}
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




