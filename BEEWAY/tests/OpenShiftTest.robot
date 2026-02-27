*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/OpenShiftPage.robot

Suite Setup    Open Browser To Application
Suite Teardown  Close Application Browser

*** Test Cases ***
Login And Open Shift In Beeway
    [Documentation]    End-to-end flow: Login → Beeway → Open Shift
    [Tags]    Smoke    Regression

    
    ${USERNAME} =    Set Variable    rgarikapati
    ${PASSWORD} =    Set Variable    E7q_35&ZR]5D*iRZ
    ${SHIFT_TIME} =    Set Variable    19:00-07:00
    ${YEAR}=    Set Variable    2026
    ${YEAR}=    Set Variable    2026
    ${MONTH}=    Set Variable    JUN        
    ${DATE}=    Set Variable    02
    ${DOCTOR_NAME} =    Set Variable    Jessica ILM
    ${OPERATION} =    Set Variable    Open Shift
    ${SHIFT} =   Set Variable   1st Half
    ${NAME_OF_USER_TO_OPEN_SHIFT} =    Set Variable    User
    ${SHIFT_COLOUR} =    Set Variable    bg-senary
    # bg-senary   -   open shift(green colour)
    # bg-septenary  -  replace(Blue colour)
    # bg-octonary   -  swap shift (brown colour)


    
    Open Shift In User Login     jlim   ${PASSWORD}     ${YEAR}     ${MONTH}     ${DATE}     ${DOCTOR_NAME}     ${SHIFT_TIME}     ${OPERATION}     ${SHIFT}    ${SHIFT_COLOUR}    USER
    # Open Shift in Admin Login     ${USERNAME}    ${PASSWORD}    ${YEAR}   ${MONTH}    ${DATE}  ${DOCTOR_NAME}    ${SHIFT_TIME}     ${OPERATION}    ${NAME_OF_USER_TO_OPEN_SHIFT}    ${SHIFT}    ${SHIFT_COLOUR}    ADMIN
