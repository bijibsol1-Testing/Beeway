*** Settings ***
Library    DateTime
Library    String

*** Keywords ***
Get Day From Date
    [Arguments]    ${date}
    ${day}=    Convert Date    ${date}    result_format=%d
    RETURN    ${day}

Get Month From Date
    [Arguments]    ${date}    ${format}=number    ${uppercase}=False

    IF    '${format}' == 'short'
        ${month}=    Convert Date    ${date}    result_format=%b
    ELSE IF    '${format}' == 'full'
        ${month}=    Convert Date    ${date}    result_format=%B
    ELSE IF    '${format}' == 'number'
        ${month}=    Convert Date    ${date}    result_format=%m
    ELSE
        Fail    Invalid format: ${format}
    END

    IF    ${uppercase}
        ${month}=    Convert To Uppercase    ${month}
    END

    RETURN    ${month}

Get Year From Date
    [Arguments]    ${date}
    ${year}=    Convert Date    ${date}    result_format=%Y
    RETURN    ${year}