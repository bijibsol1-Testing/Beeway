*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/ReplaceShiftPage.robot



Suite Setup    Open Browser To Application
Suite Teardown  Close Application Browser

*** Test Cases ***
Login And Replace Shift In Beeway
    [Documentation]    End-to-end flow: Login → Beeway → Replace Shift
    [Tags]    Smoke    Regression 


    ${USERNAME} =    Set Variable    rgarikapati
    ${PASSWORD} =    Set Variable    E7q_35&ZR]5D*iRZ
    ${SHIFT_TIME} =    Set Variable    19:00-07:00
    ${SHIFT_NAME} =    Set Variable    N12
    ${YEAR}=    Set Variable    2026
    ${MONTH}=    Set Variable    JUN        
    ${DATE}=    Set Variable    20
    ${DOCTOR_NAME} =    Set Variable    Jessica ILM
    ${FIRSTNAME} =    Set Variable   David                      
    ${LASTNAME} =    Set Variable    AACIS
    ${REPLACE_USER}=  Set Variable    ${FIRSTNAME} ${LASTNAME}
    ${OPERATION} =    Set Variable    Replace Shift
    ${SHIFT_TEXT}=    Set Variable    SR From ${DOCTOR_NAME}
    ${SHIFT_COLOUR} =    Set Variable   bg-septenary 
    # bg-senary   -   open shift(green colour)
    # bg-septenary  -  replace(Blue colour)
    # bg-octonary   -  swap shift (brown colour)

    


   Replace Shift In User Login   jlim    ${PASSWORD}    ${YEAR}   ${MONTH}    ${DATE}  ${DOCTOR_NAME}     ${SHIFT_TIME}    ${OPERATION}    ${REPLACE_USER}    ${FIRSTNAME}    ${LASTNAME}    
   Open Browser To Application
   Validate Replace Shift In User Login     DISAAC    ${PASSWORD}     ${YEAR}     ${MONTH}    ${DATE}     ${REPLACE_USER}     USER    ${SHIFT_TIME}    ${SHIFT_TEXT}      ${SHIFT_COLOUR}
   Open Browser To Application
   Validate shift from Admin Login    ${USERNAME}    ${PASSWORD}    ${YEAR}     ${MONTH}    ${DATE}     ${REPLACE_USER}    ${SHIFT_NAME}     ADMIN   ${DOCTOR_NAME}   ${SHIFT_TIME}     ${SHIFT_TEXT}    ${SHIFT_COLOUR}


