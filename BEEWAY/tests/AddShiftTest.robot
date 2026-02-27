*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/AddShiftPage.robot

Suite Setup    Open Browser To Application
Suite Teardown  Close Application Browser

*** Test Cases ***
Login And Add Shift In Beeway
    [Documentation]    End-to-end flow: Login → Beeway → Add Shift
    [Tags]    Smoke    Regression

    ${SHIFT_NAME} =    Set Variable    N12
    ${SHIFT_TIME} =    Set Variable    19:00 to 07:00
    ${SHIFT_NAME_TIME} =    Set Variable    ${SHIFT_NAME} - ${SHIFT_TIME}
    ${DOCTOR_NAME} =    Set Variable    Jessica ILM
    ${DUTY_TYPE} =    Set Variable    On Call
    ${ROLE} =    Set Variable    Obs Anaesthetist
    ${COMMENTS} =    Set Variable    As per email from Dr {name} on {date}.
    ${YEAR}=    Set Variable    2026
    ${MONTH}=    Set Variable    JUN        
    ${DATE}=    Set Variable    20
    ${ACTION}=    Set Variable    Add    
    ${TIME} =    Set Variable    19:00-07:00
    ${PASSWORD} =    Set Variable    E7q_35&ZR]5D*iRZ
    ${DEPARTMENT} =    Set Variable    Operation Theatre 
    ${WARD} =    Set Variable     Endo 2   

    Add Shift in Beeway   ${YEAR}   ${MONTH}    ${DATE}   ${ACTION}    ${ROLE}    ${DEPARTMENT}    ${WARD}    ${DOCTOR_NAME}   ${SHIFT_NAME_TIME}    ${DUTY_TYPE}   ${COMMENTS}
    Sleep    2s
    ${SHIFT_EXISTS}=    Get Shift exist Status    ${DATE}    ${DOCTOR_NAME}    ${SHIFT_NAME}
    Should Be True     ${SHIFT_EXISTS}    Shift not found for ${DOCTOR_NAME} on ${DATE} with shift ${SHIFT_NAME}
    Open Browser To Application
    Validate Shift in Doctor login     JLIM    ${PASSWORD}     ${YEAR}     ${MONTH}    ${DATE}     ${DOCTOR_NAME}    ${TIME}
    Close Browser