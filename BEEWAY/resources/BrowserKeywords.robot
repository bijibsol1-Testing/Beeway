*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/Common.robot

*** Keywords ***
Open Browser To Application
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.1s

Close Application Browser
    Close All Browsers
