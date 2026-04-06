*** Settings ***
# Library    SeleniumLibrary    
Resource    ../../BEEWAY/resources/BrowserKeywords.robot
Resource    ../../BEEWAY/resources/UIComponents.robot
Resource    ../../BEEWAY/resources/Login.robot


*** Variables ***    

*** Keywords ***
Select SubService in Modpay
    [Arguments]    ${SUBSERVICE_NAME_IN_MODPAY}
    Dropdown With Label    Sub Service    ${SUBSERVICE_NAME_IN_MODPAY}
    

Select Role in Modpay
    [Arguments]    ${ROLE_NAME_IN_MODPAY}
    
    wait Until Element Is Visible    xpath=//label[normalize-space()='Role']/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label[normalize-space()='Role']/following::select[1]    ${ROLE_NAME_IN_MODPAY}

User Search in Modpay
    [Arguments]    ${USER_NAME_IN_MODPAY}
        
    wait Until Element Is Visible    xpath=//input[@name='auto-text']    ${TIMEOUT}
    Input Text    xpath=//input[@name='auto-text']    ${USER_NAME_IN_MODPAY}
    Click Element    xpath=//label[normalize-space()='${USER_NAME_IN_MODPAY}']

Select Usertype in Modpay
    [Arguments]    ${USERTYPE_IN_MODPAY}
        
    wait Until Element Is Visible    xpath=//label/span[normalize-space()='User Type']/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label/span[normalize-space()='User Type']/following::select[1]    ${USERTYPE_IN_MODPAY}

Select Month in Modpay
    [Arguments]    ${MONTH_IN_MODPAY}
        
    wait Until Element Is Visible    xpath=//label[normalize-space()='Month']/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label[normalize-space()='Month']/following::select[1]    ${MONTH_IN_MODPAY}

Select Year in Modpay
    [Arguments]    ${YEAR_IN_MODPAY}        

    wait Until Element Is Visible    xpath=//label[normalize-space()='Year']/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label[normalize-space()='Year']/following::select[1]    ${YEAR_IN_MODPAY}

Check User Invoice in Modpay
    [Arguments]    ${USER_NAME_IN_MODPAY}    ${DAY-DATE}    ${SHIFT-TIME}
        
    wait Until Element Is Visible    xpath=(//p[text()='${USER_NAME_IN_MODPAY}'])[1]    ${TIMEOUT}
    Click Element    xpath=(//p[text()='${USER_NAME_IN_MODPAY}'])[1]
    Wait Until Element Is Visible      xpath=//td//span[contains(normalize-space(.), '${DAY-DATE}') and contains(normalize-space(.), '${SHIFT-TIME}')]     ${TIMEOUT}
    Click Element      xpath=//td//span[contains(normalize-space(.), '${DAY-DATE}') and contains(normalize-space(.), '${SHIFT-TIME}')]

Highlight Element
    [Arguments]    ${ELEMENT_XPATH}  
    Wait Until Element Is Visible    ${ELEMENT_XPATH}    ${TIMEOUT}
    ${element}=    Get WebElement    ${ELEMENT_XPATH}
    Execute JavaScript
    ...    arguments[0].style.background='yellow';
    ...    arguments[0].style.border='3px solid red';
    ...    ${element}
    
Capture Screenshot Step
    [Arguments]    ${step_name}

    ${test}=    Set Variable    ${TEST NAME}
    ${time}=    Get Time    result_format=%Y%m%d_%H%M%S
    ${file}=    Set Variable    ${test}_${step_name}_${time}.png
    Capture Page Screenshot    ${file}