*** Settings ***
# Library     SeleniumLibrary
Resource    ../variables/Common.robot

*** Keywords ***
Open Browser To Application

    # ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # Call Method    ${options}    add_argument    --headless=new
    # Call Method    ${options}    add_argument    --window-size=1920,1080
    Open Browser    ${URL}    chrome    options=add_argument("--headless=new");add_argument("--window-size=1920,1080")

    # Open Browser    ${URL}    ${BROWSER}
    # Maximize Browser Window
    # Set Selenium Speed    0s

Close Application Browser
    Close All Browsers
