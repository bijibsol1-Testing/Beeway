*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/Common.robot
Resource    ../resources/UIComponents.robot


*** Keywords ***
select Doctor
    [Arguments]   ${DOCTOR_NAME}

    Wait Until Element Is Visible    xpath=//div/span[normalize-space()='${DOCTOR_NAME}']    ${TIMEOUT_LONG}
    Click Element    xpath=//div/span[normalize-space()='${DOCTOR_NAME}']
    Log To Console    ✅ Doctor selected

select Admin User
    [Arguments]   ${ADMIN_USER}    ${JOB_CATEGORY}

    Wait Until Element Is Visible  xpath=//label[normalize-space()='Admin']    ${TIMEOUT_LONG}
    Click Element    xpath=//label[normalize-space()='Admin']
    #Job Category selection    
    Dropdown With Label    Required Job Category    ${JOB_CATEGORY}   
    Log To Console    ✅ Job Category selected   
    select Doctor    ${ADMIN_USER}
        

select Available User
    [Arguments]   ${AVAILABLE_USER}    
   
    Wait Until Element Is Visible  xpath=//label[normalize-space()='Available Users']    ${TIMEOUT_LONG}
    Click Element    xpath=//label[normalize-space()='Available Users']  
    select Doctor    ${AVAILABLE_USER} 
       

Search with Firstname and Lastname
    [Arguments]    ${FIRSTNAME}    ${LASTNAME}

    Textfield With Placeholder    Enter First Name    ${FIRSTNAME}
    Textfield With Placeholder    Enter Last Name     ${LASTNAME}
    Button Click    Search 