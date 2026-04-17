*** Settings ***
Library     SeleniumLibrary    screenshot_root_directory=${EXECDIR}/results/Screenshots
Resource    ../pages/DeleteShiftPage.robot

Test Setup    Open Browser To Application
Test Teardown    Close Application Browser
Test Template    Delete Shift Test


*** Test Cases ***
Delete Shift Test in CSV    

*** Keywords ***
