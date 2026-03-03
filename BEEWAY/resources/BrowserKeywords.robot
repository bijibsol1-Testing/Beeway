*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/Common.robot

*** Keywords ***
Open Browser To Application
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Create WebDriver    Chrome    options=${chrome_options}
    Go To    ${URL}
    Set Selenium Speed    0.1s




    # Open Browser    ${URL}    ${BROWSER}
    # Maximize Browser Window
    # Set Selenium Speed    0.1s

Close Application Browser
    Close All Browsers
