*** Settings ***
Library     SeleniumLibrary
Library    DataDriver    file=../data/OpenShiftData.csv    dialect=excel
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/OpenShiftPage.robot

# Suite Setup    Open Browser To Application
# Suite Teardown  Close Application Browser

Test Setup    Open Browser To Application
Test Teardown    Close Application Browser
Test Template    Login and Open Shift Based On Role


*** Keywords ***
Login and Open Shift Based On Role
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
    ...    ${SHIFT_TIME}
    ...    ${OPERATION}
    ...    ${SHIFT}
    ...    ${SHIFT_COLOUR}
    ...    ${NAME_OF_USER_TO_OPEN_SHIFT}

    IF    '${USER_LOGIN}' != ''
        Open Shift In User Login
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
        ...    ${SHIFT}
        ...    ${SHIFT_COLOUR}

    ELSE
        Open Shift In Admin Login
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
        ...    ${NAME_OF_USER_TO_OPEN_SHIFT}
        ...    ${SHIFT}
        ...    ${SHIFT_COLOUR}
    END
    
*** Test Cases ***
Login and Open Shift Based On Role
    [Documentation]    End-to-end flow: Login → Beeway → Open Shift
    [Tags]    Smoke    Regression 

