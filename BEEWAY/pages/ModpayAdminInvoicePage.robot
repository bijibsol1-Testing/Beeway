*** Settings ***
# Library    SeleniumLibrary    
Resource    ../resources/BrowserKeywords.robot
Resource    ../resources/UIComponents.robot
Resource    ../resources/Login.robot
Resource    ../pages/BeewayDashboardPage.robot


*** Variables ***  


***Keywords***

Wait For Modpay Loader To Disappear
    [Arguments]    ${locator}=//app-bijib-loader

    # Step 1: Wait briefly for loader to appear (optional)
    ${is_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    # Step 2: If visible, wait for it to disappear
    IF    ${is_visible}
        Wait Until Element Is Not Visible    ${locator}    ${TIMEOUT}
    END

Select SubService in Modpay
    [Arguments]    ${SUBSERVICE_NAME_IN_MODPAY}

    Wait For Modpay Loader To Disappear    //app-bijib-loader
    # Open correct dropdown
    ${dropdown}=    Set Variable    //div[contains(@class,'form-group')][.//label[contains(.,'Sub Service')]]//li[contains(@class,'dropdown')]
    Wait Until Element Is Visible    ${dropdown}    ${TIMEOUT}
    Click Element    ${dropdown}

    # Select option using visible text (NOT label)
    ${option_xpath}=    Set Variable    //li[contains(@class,'list-item') and contains(normalize-space(),'${SUBSERVICE_NAME_IN_MODPAY}')]
    Wait Until Element Is Visible    ${option_xpath}    ${TIMEOUT}
    Click Element    ${option_xpath}

    Wait For Modpay Loader To Disappear    //app-bijib-loader

    Log To Console    ✅ Subservice selected: ${SUBSERVICE_NAME_IN_MODPAY}
    
Select Role in Modpay
    [Arguments]    ${ROLE}
    
    wait Until Element Is Visible    xpath=//label[normalize-space()='Role']/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label[normalize-space()='Role']/following::select[1]    ${ROLE}
    Log To Console    ✅ Role selected: ${ROLE}

User Search in Modpay
    [Arguments]    ${DOCTOR_NAME}
    
    ${search_xpath}=    Set Variable    xpath=//input[@name='auto-text']
    Wait Until Element Is Visible    ${search_xpath}    ${TIMEOUT_LONG}
    Input Text    ${search_xpath}    ${DOCTOR_NAME}

    ${userselect_xpath}=    Set Variable    xpath=//label[normalize-space(.)="${DOCTOR_NAME}"]
    Wait Until Element Is Visible    xpath=//label[normalize-space(.)="${DOCTOR_NAME}"]    ${TIMEOUT_LONG}
    Click Element    xpath=//label[normalize-space(.)="${DOCTOR_NAME}"]
    Log To Console    ✅ User searched: ${DOCTOR_NAME}

Select Usertype in Modpay
    [Arguments]    ${USERTYPE_IN_MODPAY}
        
    wait Until Element Is Visible    xpath=//label/span[normalize-space()='User Type']/following::select[1]    ${TIMEOUT_LONG}
    Click Element    xpath=//label/span[normalize-space()='User Type']/following::select[1]/option[normalize-space()='${USERTYPE_IN_MODPAY}']   
    Log To Console    ✅ User Type selected: ${USERTYPE_IN_MODPAY}

Select Month in Modpay
    [Arguments]    ${MODPAY_MONTH}
        
    wait Until Element Is Visible    xpath=//label[normalize-space()='Month']/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label[normalize-space()='Month']/following::select[1]    ${MODPAY_MONTH}
    Log To Console    ✅ Month selected: ${MODPAY_MONTH}

Select Year in Modpay
    [Arguments]    ${YEAR}       

    wait Until Element Is Visible    xpath=//label[normalize-space()='Year']/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label[normalize-space()='Year']/following::select[1]    ${YEAR}
    Log To Console    ✅ Year selected: ${YEAR}

Select PayCycle in Modpay
    [Arguments]    ${PAYCYCLE_IN_MODPAY}        

    wait Until Element Is Visible    xpath=//label[normalize-space()='PayCycle']/following::select[1]    ${TIMEOUT}
    Select From List By Label    xpath=//label[normalize-space()='PayCycle']/following::select[1]    ${PAYCYCLE_IN_MODPAY}
    Log To Console    ✅ PayCycle selected: ${PAYCYCLE_IN_MODPAY}

Select PayCycle/Month/Year in Modpay
    [Arguments]    ${MODPAY_MONTH}    ${YEAR}    ${PAYCYCLE_IN_MODPAY}

    ${is_paycycle_visible}=    Run Keyword And Return Status
    ...    Element Should Be Visible    xpath=//label[normalize-space()='PayCycle']/following::select[1]

    IF    ${is_paycycle_visible}
        Log To Console    ✅ PayCycle is visible → selecting PayCycle
        Select From List By Label    xpath=//label[normalize-space()='PayCycle']/following::select[1]    ${PAYCYCLE_IN_MODPAY}
    ELSE
        Log To Console    🔄 PayCycle not visible → selecting Month & Year

        Wait Until Element Is Visible    xpath=//label[normalize-space()='Month']/following::select[1]    ${TIMEOUT}
        Select From List By Label        xpath=//label[normalize-space()='Month']/following::select[1]    ${MODPAY_MONTH}

        Wait Until Element Is Visible    xpath=//label[normalize-space()='Year']/following::select[1]    ${TIMEOUT}
        Select From List By Label        xpath=//label[normalize-space()='Year']/following::select[1]    ${YEAR}
    END

Check User Invoice in Modpay
    [Arguments]    ${MODPAY_DOCTOR_NAME}    ${DAY_DATE}    ${SHIFT-TIME}    ${DUTY_TYPE_SYMBOL}
    
    Click Element With Path    //p[text()='${MODPAY_DOCTOR_NAME}']
    Wait Until Element Is Visible      xpath=//td//span[contains(normalize-space(.), '${DAY_DATE}') and contains(normalize-space(.), '${SHIFT-TIME}') and .//img[@class='${DUTY_TYPE_SYMBOL}-img']]     ${TIMEOUT}
    Scroll Element Into View      xpath=//td//span[contains(normalize-space(.), '${DAY_DATE}') and contains(normalize-space(.), '${SHIFT-TIME}') and .//img[@class='${DUTY_TYPE_SYMBOL}-img']]
    Click Element      xpath=//td//span[contains(normalize-space(.), '${DAY_DATE}') and contains(normalize-space(.), '${SHIFT-TIME}') and .//img[@class='${DUTY_TYPE_SYMBOL}-img']]
    Log To Console    ✅ Checked User Invoice in Modpay ${MODPAY_DOCTOR_NAME} on ${DAY_DATE} at ${SHIFT-TIME} with duty type symbol ${DUTY_TYPE_SYMBOL}

    
Capture Screenshot Step
    [Arguments]    ${step_name}

    ${time}=    Get Time    epoch
    ${file}=    Set Variable    ${step_name}_${time}.png
    Capture Page Screenshot    ${file}
    Log To Console    ✅ Captured screenshot: ${file}

Check User Shift in Modpay
    [Arguments]    ${SUBSERVICE_NAME_IN_MODPAY}    ${ROLE}    ${DOCTOR_NAME}    ${USERTYPE_IN_MODPAY}    ${MODPAY_MONTH}    ${YEAR}    ${PAYCYCLE_IN_MODPAY}    ${MODPAY_DOCTOR_NAME}     ${DAY_DATE}    ${SHIFT-TIME}    ${DUTY_TYPE_SYMBOL}    ${PAYMENT_TYPE}

    Select SubService in Modpay    ${SUBSERVICE_NAME_IN_MODPAY}
    Select Role in Modpay    ${ROLE}
    User Search in Modpay    ${DOCTOR_NAME}
    Select Usertype in Modpay    ${USERTYPE_IN_MODPAY}
    Select PayCycle/Month/Year in Modpay    ${MODPAY_MONTH}    ${YEAR}    ${PAYCYCLE_IN_MODPAY} 
    Button Click    Search
    Wait For Modpay Loader To Disappear
    Log To Console   Clicked Search Button
    IF    '${PAYMENT_TYPE}' == 'P'
        Log To Console    Payment Type P → Records should be displayed
        Check User Invoice in Modpay    ${MODPAY_DOCTOR_NAME}    ${DAY_DATE}    ${SHIFT-TIME}    ${DUTY_TYPE_SYMBOL}
        Scroll To Specific Element    ${DAY_DATE}    ${SHIFT-TIME}    ${DUTY_TYPE_SYMBOL}
        Capture Screenshot Step    Invoice${MODPAY_DOCTOR_NAME}
     ELSE
        Log To Console    Payment Type UP → No records should be displayed
        Wait Until Element Is Visible    (//p[text()='No Records Found'])[1]    ${TIMEOUT}
        Element Should Be Visible        (//p[text()='No Records Found'])[1]
        Capture Screenshot Step    NoRecords${MODPAY_DOCTOR_NAME}
    END

Scroll To Specific Element
    [Arguments]    ${DAY_DATE}    ${SHIFT-TIME}    ${DUTY_TYPE_SYMBOL}

    ${locator}=    Set Variable    xpath=//td//span[contains(normalize-space(.), '${DAY_DATE}') and contains(normalize-space(.), '${SHIFT-TIME}') and .//img[@class='${DUTY_TYPE_SYMBOL}-img']]
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Scroll Element Into View         ${locator}
    Log To Console    ✅ Scrolled to element: ${locator}


        
   