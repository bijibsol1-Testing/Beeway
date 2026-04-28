*** Settings ***
Library     SeleniumLibrary    screenshot_root_directory=${EXECDIR}/allure-results/Screenshots
Library     allure_robotframework
Library    DataDriver    file=../data/add_shift_data.csv    dialect=excel
Resource    ../pages/AddShiftPage.robot
Resource    ../pages/LoginPage.robot
Resource    ../pages/ModpayAdminInvoicePage.robot
Resource    ../resources/DateKeywords.robot


# Suite Setup    Open Browser To Application
# Suite Teardown    Close Application Browser
# Test Template    Add Shift Test

Test Setup    Open Browser To Application
Test Teardown    Close Application Browser
Test Template    Add Shift Test

*** Test Cases ***
Add Shift Test in CSV


*** Keywords ***
Add Shift Test
    [Arguments]  
    ...    ${USERNAME}    
    ...    ${PASSWORD}
    ...    ${SERVICE_NAME} 
    ...    ${HOSPITAL_NAME} 
    ...    ${SUBSERVICE_NAME}  
    ...    ${SHIFT_DATE_CONSTANT}    
    ...    ${ACTION}
    ...    ${ROLE}
    ...    ${DEPARTMENT}
    ...    ${WARD}
    ...    ${DOCTOR_NAME}
    ...    ${SHIFT_NAME}
    ...    ${SHIFT_NAME_TIME}
    ...    ${DUTY_TYPE}
    ...    ${COMMENTS}
    ...    ${TIME}
    ...    ${DOCTORLOGIN}
    ...    ${STARTHOUR}
    ...    ${STARTMIN}                
    ...    ${ENDHOUR}
    ...    ${ENDMIN}
    ...    ${SUBSERVICE_NAME_IN_MODPAY}
    ...    ${MODPAY_DOCTOR_NAME}
    ...    ${USERTYPE_IN_MODPAY}
    ...    ${PAYCYCLE_IN_MODPAY}
    ...    ${DAY_DATE}
    ...    ${SHIFT-TIME}
    ...    ${DUTY_TYPE_SYMBOL}

    ${DATE}=    Get Day From Date    ${SHIFT_DATE_CONSTANT}
    ${MONTH}=    Get Month From Date    ${SHIFT_DATE_CONSTANT}    short    True
    ${YEAR}=    Get Year From Date    ${SHIFT_DATE_CONSTANT}

    ${payment_type}=    Add Shift in Beeway  
    ...   ${USERNAME}    
    ...   ${PASSWORD}
    ...   ${SERVICE_NAME} 
    ...   ${HOSPITAL_NAME} 
    ...   ${SUBSERVICE_NAME}
    ...   ${YEAR}
    ...   ${MONTH}
    ...   ${DATE}
    ...   ${ACTION}
    ...   ${ROLE}
    ...   ${DEPARTMENT}
    ...   ${WARD}
    ...   ${DOCTOR_NAME}
    ...   ${SHIFT_NAME_TIME}
    ...   ${DUTY_TYPE}
    ...   ${COMMENTS}
    ...   ${STARTHOUR}
    ...   ${STARTMIN}   
    ...   ${ENDHOUR}    
    ...   ${ENDMIN}

    Sleep    2s

    ${SHIFT_EXISTS}=    Get Shift Exist Status Admin Login    
    ...    ${DATE}    
    ...    ${DOCTOR_NAME}    
    ...    ${SHIFT_NAME}    
    ...    ${TIME}    
    ...    ${WARD}

    Should Be True     ${SHIFT_EXISTS}
    Capture Screenshot Step    Shift${DOCTOR_NAME}
    sleep    2s
    IF    '${payment_type}' == 'P'
       Navigate To Modpay
       ${MODPAY_MONTH}=    Get Month From Date    ${SHIFT_DATE_CONSTANT}    full
       Check User Shift in Modpay    
        ...    ${SUBSERVICE_NAME_IN_MODPAY}    
        ...    ${ROLE}    
        ...    ${DOCTOR_NAME}   
        ...    ${USERTYPE_IN_MODPAY}    
        ...    ${MODPAY_MONTH}    
        ...    ${YEAR}   
        ...    ${PAYCYCLE_IN_MODPAY} 
        ...    ${MODPAY_DOCTOR_NAME}      
        ...    ${DAY_DATE}    
        ...    ${SHIFT-TIME}
        ...    ${DUTY_TYPE_SYMBOL}
        ...    ${payment_type}
    ELSE 
    Log To Console    ⛔ Payment type is not P. Skipping Modpay validation.
    END   
    
    Close Application Browser
    Open Browser To Application

    ${DATE}=    Get Day From Date    ${SHIFT_DATE_CONSTANT}
    ${MONTH}=    Get Month From Date    ${SHIFT_DATE_CONSTANT}    short    True
    ${YEAR}=    Get Year From Date    ${SHIFT_DATE_CONSTANT}
    # ${payment_type}=    Set Variable    P

    Validate Shift in Doctor login     
    ...    ${DOCTORLOGIN}
    ...    ${PASSWORD}
    ...    ${SERVICE_NAME}
    ...    ${HOSPITAL_NAME}
    ...    ${SUBSERVICE_NAME}
    ...    ${YEAR}
    ...    ${MONTH}
    ...    ${DATE}
    ...    ${DOCTOR_NAME}
    ...    ${TIME}
    ...    ${SHIFT-TIME}
    ...    ${DUTY_TYPE_SYMBOL}
    ...    ${payment_type}

