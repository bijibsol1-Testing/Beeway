*** Settings ***
Library     SeleniumLibrary
Library    DataDriver    file=../data/ReplaceShiftData.csv    dialect=excel
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/ReplaceShiftPage.robot

# Suite Setup    Open Browser To Application
# Suite Teardown  Close Application Browser

Test Setup    Open Browser To Application
Test Teardown    Close Application Browser
Test Template    Login And Replace Shift In Beeway

*** Keywords ***
Login And Replace Shift In Beeway
   [Arguments]  
    ...    ${USERNAME} 
    ...    ${USER_LOGIN}   
    ...    ${PASSWORD}
    ...    ${SERVICE_NAME}
    ...    ${HOSPITAL_NAME}
    ...    ${SUBSERVICE_NAME}
    ...    ${YEAR}
    ...    ${MONTH}
    ...    ${DATE}
    ...    ${DOCTOR_NAME}
    ...    ${SHIFT_NAME} 
    ...    ${SHIFT_TIME}
    ...    ${WARD}
    ...    ${OPERATION}
    ...    ${REPLACE_USER}
    ...    ${DOCTORLOGIN}
    ...    ${SHIFT_COLOUR}
    ...    ${SHIFT_TEXT}

   IF    '${USER_LOGIN}' != ''
        Replace Shift In User Login
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
        ...    ${REPLACE_USER}

    ELSE
        Replace Shift In Admin Login
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
        ...    ${REPLACE_USER}
    END
   Close Application Browser       
   Open Browser To Application
   Validate Replace Shift In User Login 
   ...    ${DOCTORLOGIN}    
   ...    ${PASSWORD}     
   ...    ${HOSPITAL_NAME}    
   ...    ${SUBSERVICE_NAME}    
   ...    ${YEAR}     
   ...    ${MONTH}    
   ...    ${DATE}     
   ...    ${REPLACE_USER}      
   ...    ${SHIFT_TIME}         
   ...    ${SHIFT_COLOUR}
   ...    ${SHIFT_TEXT}
   Close Application Browser
   Open Browser To Application
   Validate shift from Admin Login    
   ...    ${USERNAME}    
   ...    ${PASSWORD}    
   ...    ${SERVICE_NAME}    
   ...    ${HOSPITAL_NAME}    
   ...    ${SUBSERVICE_NAME}    
   ...    ${YEAR}     
   ...    ${MONTH}    
   ...    ${DATE}     
   ...    ${REPLACE_USER}    
   ...    ${SHIFT_NAME} 
   ...    ${WARD}     
   ...    ${DOCTOR_NAME}   
   ...    ${SHIFT_TIME}     
   ...    ${SHIFT_COLOUR}
   ...    ${SHIFT_TEXT}
   Close Application Browser

*** Test Cases ***
Login And Replace Shift In Beeway
    [Documentation]    End-to-end flow: Login → Beeway → Replace Shift
    [Tags]    Smoke    Regression 



