*** Settings ***
# Library    SeleniumLibrary
Resource    ../UIComponents.robot


*** Keywords ***
Select Date With Label
    [Arguments]    ${LABEL}    ${YEAR}    ${MONTH}    ${DAY}
    ${BASE_PATH}=    Set Variable    //div[label[text()="${LABEL}"]]/following-sibling::
    ${MONTH_YEAR_PATH}=    Set Variable    ${BASE_PATH}div/div/div/div/div/span
    ${DP_POPUP_PATH}=    Set Variable    (${BASE_PATH}div/div)[2]
    
    # Scroll Element Into View
    ${SCROLL_PATH}=    Set Variable    xpath=${BASE_PATH}div/input
    Scroll Element Into View    ${SCROLL_PATH}
    Log To Console    Scrolled to date picker with label: ${LABEL}

    # Open date picker input
    ${DATE_PATH}=    Set Variable    xpath=${BASE_PATH}div/input
    Wait Until Element Is Visible    ${DATE_PATH}    ${TIMEOUT}
    Click Element    ${DATE_PATH}
    Log To Console    Date picker opened

    # Open year selection
    ${YEAR_VIEW}=    Set Variable    xpath=(${MONTH_YEAR_PATH})[2]
    Wait Until Element Is Visible    ${YEAR_VIEW}    ${TIMEOUT}
    Click Element    ${YEAR_VIEW}
    Log To Console    Year view opened

    # Navigate to correct year range dynamically
    FOR    ${INDEX}    IN RANGE    0    50
        ${CURRENT_YEARS_TEXT}=    Get Text    xpath=(${DP_POPUP_PATH}/div)[1]/div
        Log To Console    Current year range: ${CURRENT_YEARS_TEXT}

        ${START_YEAR}=    Evaluate    int("${CURRENT_YEARS_TEXT}".split("-")[0].strip())
        ${END_YEAR}=      Evaluate    int("${CURRENT_YEARS_TEXT}".split("-")[1].strip())

        Run Keyword If    ${YEAR} >= ${START_YEAR} and ${YEAR} <= ${END_YEAR}    Exit For Loop
        Run Keyword If    ${YEAR} < ${START_YEAR}    Click Back Year    ${DP_POPUP_PATH}
        Run Keyword If    ${YEAR} > ${END_YEAR}      Click Forward Year    ${DP_POPUP_PATH}

        Sleep    0.5s
    END

    # Click the year
    ${YEAR_PATH}=    Set Variable    xpath=(${DP_POPUP_PATH}/div)[2]/div[normalize-space(.)="${YEAR}"]
    Wait Until Element Is Visible    ${YEAR_PATH}    ${TIMEOUT}
    Click Element    ${YEAR_PATH}
    Log To Console    Year ${YEAR} selected

    # Open month selection
    ${MONTH_VIEW}=    Set Variable    xpath=(${MONTH_YEAR_PATH})[1]
    Wait Until Element Is Visible    ${MONTH_VIEW}    ${TIMEOUT}
    Click Element    ${MONTH_VIEW}
    Log To Console    Month view opened

    # Click the month
    ${MONTH_PATH}=    Set Variable    xpath=(${DP_POPUP_PATH}/div)/div[normalize-space(.)="${MONTH}"]
    Wait Until Element Is Visible    ${MONTH_PATH}    ${TIMEOUT}
    Click Element    ${MONTH_PATH}
    Log To Console    Month ${MONTH} selected

    # Click the day
    ${DAY_PATH}=    Set Variable    xpath=(${DP_POPUP_PATH}/div)[3]/button/time[normalize-space(.)="${DAY}"]
    Wait Until Element Is Visible    ${DAY_PATH}    ${TIMEOUT}
    Click Element    ${DAY_PATH}
    Log To Console    Day ${DAY} selected


# Helper Keywords
Click Back Year
    [Arguments]    ${DP_POPUP_PATH}
    ${BACK_YEAR_PATH}=    Set Variable    xpath=${DP_POPUP_PATH}/div/button/i[contains(@class,"fa-angle-left")]
    Wait Until Element Is Visible    ${BACK_YEAR_PATH}   ${TIMEOUT}
    Click Element    ${BACK_YEAR_PATH}

Click Forward Year
    [Arguments]    ${DP_POPUP_PATH}
    ${NEXT_YEAR_PATH}=    Set Variable    xpath=${DP_POPUP_PATH}/div/button/i[contains(@class,"fa-angle-right")]
    Wait Until Element Is Visible    ${NEXT_YEAR_PATH}   ${TIMEOUT}
    Click Element    ${NEXT_YEAR_PATH}