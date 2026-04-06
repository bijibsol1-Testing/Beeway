*** Settings ***
# Library    SeleniumLibrary
Resource    ../variables/Common.robot
Resource    ../resources/UIComponents.robot



*** Keywords ***
Goto Service
    [Arguments]    ${SERVICE_NAME}    ${HOSPITAL_NAME}=""

    Location Should Be    ${DASHBOARD_URL}
    Log to Console    Navigated to Dashboard

    Click Element With Path    //li[@title="${SERVICE_NAME}"]/div[normalize-space()="${SERVICE_NAME}"]

    IF    ${HOSPITAL_NAME} != ""
        ${SUBMENU_PATH}=    Set Variable    //div[contains(@class,"submenu dsktp-vw-dsply")]/span[normalize-space()="${SERVICE_NAME}"]
        ${HOSPITAL_PATH}=    Set Variable    ${SUBMENU_PATH}/following-sibling::ul//li[normalize-space()="${HOSPITAL_NAME}"]
        Click Element With Path    ${HOSPITAL_PATH}
    END
    Wait Until Location Is    ${BEEWAY_URL}    ${TIMEOUT_LONG}
    Log to Console    Navigated to ${SERVICE_NAME} Service