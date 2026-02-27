*** Variables ***
${LOGIN_PAGE_TITLE}    Enter Login Credentials
${BROWSER}             chrome

${TIMEOUT}             10s
${TIMEOUT_LONG}        30s

${WRONG_PASSWORD_ERROR_MESSAGE}    Enter Valid Credentials.
${PASSWORD_ERROR_MESSAGE}           Please Enter Password
${USERNAME_ERROR_MESSAGE}           Please Enter User Name/Mobile/Email
${ENV}    TEST

*** Settings ***
Resource    ${ENV}.robot