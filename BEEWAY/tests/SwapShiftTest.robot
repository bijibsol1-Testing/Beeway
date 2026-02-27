*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/SwapShiftPage.robot

Suite Setup    Open Browser To Application
Suite Teardown  Close Application Browser

*** Test Cases ***
Login And Swap Shift In Beeway
    [Documentation]    End-to-end flow: Login → Beeway → Swap Shift
    [Tags]    Smoke    Regression

    
    ${USERNAME} =    Set Variable    rgarikapati
    ${PASSWORD} =    Set Variable    E7q_35&ZR]5D*iRZ
    ${SHIFT_TIME} =    Set Variable    19:00-07:00
    ${SHIFT_NAME} =    Set Variable    N12
    ${YEAR}=    Set Variable    2026
    ${MONTH}=    Set Variable    JUN        
    ${DATE}=    Set Variable    22
    ${DOCTOR_NAME} =    Set Variable    Jessica ILM
    ${FIRSTNAME} =    Set Variable   David                      
    ${LASTNAME} =    Set Variable    AACIS
    ${SWAP_USER}=  Set Variable    ${FIRSTNAME} ${LASTNAME}
    ${OPERATION} =    Set Variable    Swap Shift
    ${SWAP_DATE}=    Set Variable    25/06/2026
    ${SWAPPING_DATE}=    Set Variable    22/06/2026
    ${DAY}=    Set Variable    Thursday
    ${EXPECTED_MESSAGE}=    Set Variable    Do you want to Swap shift?
    ${ACTION}=    Set Variable    ACCEPT
    ${VALIDATION_DATE}=    Set Variable    25
    ${OPERATION}=    Set Variable    Swap Shift
    ${SHIFT_TEXT}=    Set Variable    Swap with ${DOCTOR_NAME} ${SWAP_DATE} - 19:00 - 07:00
    ${SHIFT_COLOUR} =    Set Variable   bg-octonary
    # bg-senary   -   open shift(green colour)
    # bg-septenary  -  replace(Blue colour)
    # bg-octonary   -  swap shift (brown colour)



    # Swap Shift In Admin Login    ${USERNAME}    ${PASSWORD}    ${YEAR}   ${MONTH}    ${DATE}    ${DOCTOR_NAME}     ${SHIFT_TIME}    ${OPERATION}    ${SWAP_USER}    ${SWAP_DATE}     ${DAY}     ${EXPECTED_MESSAGE}    ${ACTION}    ${SHIFT_NAME}
    # Swap Shift In User Login     JLIM    ${PASSWORD}    ${YEAR}   ${MONTH}    ${DATE}  ${DOCTOR_NAME}     ${SHIFT_TIME}    ${OPERATION}    ${SWAP_USER}   ${SWAP_DATE}    ${DAY}   ${EXPECTED_MESSAGE}    ${ACTION}    ${VALIDATION_DATE}   
    # Open Browser To Application
    # Validate Swap Shift in User Login    DISAAC    ${PASSWORD}     ${YEAR}     ${MONTH}    ${DATE}    ${SWAP_USER}     USER   ${SHIFT_TIME}    ${SHIFT_TEXT}    ${SHIFT_COLOUR}
    # Open Browser To Application
    # Validate shift from Admin Login    ${USERNAME}    ${PASSWORD}    ${YEAR}     ${MONTH}    ${DATE}     ${SWAP_USER}    ${SHIFT_NAME}     ADMIN    ${DOCTOR_NAME}    ${SHIFT_TIME}    ${SHIFT_TEXT}    ${SHIFT_COLOUR}
    # Open Browser To Application
    # Validate shift from Admin Login    ${USERNAME}    ${PASSWORD}    ${YEAR}     ${MONTH}    ${VALIDATION_DATE}     ${DOCTOR_NAME}    ${SHIFT_NAME}     ADMIN    ${SWAP_USER}    ${SHIFT_TIME}    Swap with ${SWAP_USER} ${SWAPPING_DATE} - 19:00 - 07:00    ${SHIFT_COLOUR}
    Validate Swap Shift from Admin Login    ${USERNAME}    ${PASSWORD}    ${YEAR}     ${MONTH}    ${DATE}     ${SWAP_USER}    ${SHIFT_NAME}     ADMIN    ${DOCTOR_NAME}    ${SHIFT_TIME}    ${SHIFT_TEXT}    ${SHIFT_COLOUR}     ${VALIDATION_DATE}    ${SWAPPING_DATE}