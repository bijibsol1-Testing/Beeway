*** Settings ***
# Library    SeleniumLibrary
Resource    UIComponents.robot
Resource    ../variables/Common.robot

*** Keywords ***
Page Selection
    [Arguments]    ${CATEGORY_ICON}    ${PAGE_NAME}

    ${CATEGORY_PATH}=    Set Variable    //li[contains(@class,"nav-item")]//i[contains(@class,"${CATEGORY_ICON}")]
    ${PAGE_PATH}=        Set Variable    //span[normalize-space()="${PAGE_NAME}"]

    Click Element With Path    ${CATEGORY_PATH}
    Click Element With Path    ${PAGE_PATH}
    
    Log to Console    Navigated to ${PAGE_NAME} Page


Wait For Page Loader To Disappear
    Wait Until Element Is Not Visible    xpath=//div[contains(@class,'loader-wrapper')]
    ...    ${TIMEOUT_LONG}


Select Year and Month
    [Arguments]    ${YEAR}    ${MONTH}  

    sleep   2s
    Click Element With Path    //i[contains(@class,"fa-solid fa-calendar-days")]
    ${SMALL_CALENDAR_PATH}=    Set Variable    //div[contains(@class,"small-calender")]
    Click Element With Path    ${SMALL_CALENDAR_PATH}/div/div/ul/li[normalize-space(text())="${MONTH}"]
    Click Element With Path    ${SMALL_CALENDAR_PATH}/ul/li[normalize-space(text())="Year"]
    Click Element With Path    ${SMALL_CALENDAR_PATH}/div/ul/li[normalize-space(text())="${YEAR}"]
    Button Click    Done   
    sleep  2s