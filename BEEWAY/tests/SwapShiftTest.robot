*** Settings ***
Library     SeleniumLibrary
Library    DataDriver    file=../data/ReplaceShiftData.csv    dialect=excel
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/SwapShiftPage.robot

# Suite Setup    Open Browser To Application
# Suite Teardown  Close Application Browser

Test Setup    Open Browser To Application
Test Teardown    Close Application Browser
Test Template    Login And Swap Shift Based On Role

*** Keywords ***
Login And Swap Shift Based On Role
    [Arguments]  
    ...    ${USERNAME}
    ...    ${USER_LOGIN}
    ...    ${SWAP_USER_LOGIN}
    ...    ${PASSWORD}
    ...    ${SERVICE_NAME}
    ...    ${HOSPITAL_NAME}
    ...    ${SUBSERVICE_NAME}
    ...    ${YEAR}
    ...    ${MONTH}
    ...    ${DATE}
    ...    ${DOCTOR_NAME}
    ...    ${SHIFT_TIME}
    ...    ${OPERATION}
    ...    ${SWAP_USER}
    ...    ${SWAP_DATE}
    ...    ${DAY}
    ...    ${EXPECTED_MESSAGE}
    ...    ${ACTION}
    ...    ${VALIDATION_DATE}
    ...    ${SHIFT_NAME}
    ...    ${SHIFT_TEXT}    
    ...    ${SHIFT_COLOUR}  
    ...    ${SWAP_SHIFT_TEXT}
    ...    ${SWAPPING_DATE}


    IF    '${USER_LOGIN}' != ''
        Swap Shift In User Login
        ...    ${USER_LOGIN}
        ...    ${PASSWORD}
        ...    ${SERVICE_NAME}
        ...    ${HOSPITAL_NAME}
        ...    ${SUBSERVICE_NAME}
        ...    ${YEAR}
        ...    ${MONTH}
        ...    ${DATE}
        ...    ${DOCTOR_NAME}
        ...    ${SHIFT_TIME}
        ...    ${OPERATION}
        ...    ${SWAP_USER}
        ...    ${SWAP_DATE}
        ...    ${DAY}
        ...    ${EXPECTED_MESSAGE}
        ...    ${ACTION}
        ...    ${VALIDATION_DATE}

    ELSE
        Swap Shift In Admin Login
        ...    ${USERNAME}
        ...    ${PASSWORD}
        ...    ${SERVICE_NAME}
        ...    ${HOSPITAL_NAME}
        ...    ${SUBSERVICE_NAME}
        ...    ${YEAR}
        ...    ${MONTH}
        ...    ${DATE}
        ...    ${DOCTOR_NAME}
        ...    ${SHIFT_TIME}
        ...    ${OPERATION}
        ...    ${SWAP_USER}
        ...    ${SWAP_DATE}
        ...    ${DAY}
        ...    ${EXPECTED_MESSAGE}
        ...    ${ACTION}
        ...    ${SHIFT_NAME}
    END
    Close Application Browser
    Open Browser To Application
    Validate Swap Shift in User Login 
    ...    ${SWAP_USER_LOGIN}    
    ...    ${PASSWORD}     
    ...    ${SERVICE_NAME}
    ...    ${HOSPITAL_NAME}
    ...    ${SUBSERVICE_NAME}
    ...    ${YEAR}     
    ...    ${MONTH}    
    ...    ${DATE}    
    ...    ${SWAP_USER}    
    ...    ${SHIFT_TIME}    
    ...    ${SHIFT_TEXT}    
    ...    ${SHIFT_COLOUR}
    Close Application Browser
    Open Browser To Application
    Validate Swap Shift from Admin Login    
    ...    ${USERNAME}    
    ...    ${PASSWORD}    
    ...    ${SERVICE_NAME}
    ...    ${HOSPITAL_NAME}
    ...    ${SUBSERVICE_NAME}
    ...    ${YEAR}     
    ...    ${MONTH}    
    ...    ${DATE}    
    ...    ${SWAP_USER}    
    ...    ${SHIFT_NAME}    
    ...    ${DOCTOR_NAME}    
    ...    ${SHIFT_TIME}    
    ...    ${SHIFT_TEXT}    
    ...    ${SHIFT_COLOUR}    
    ...    ${VALIDATION_DATE}    
    ...    ${SWAPPING_DATE}
    ...    ${SWAP_SHIFT_TEXT}
    Close Application Browser

*** Test Cases ***
Login And Swap Shift Based On Role
    [Documentation]    End-to-end flow: Login → Beeway → Swap Shift
    [Tags]    Smoke    Regression

   

