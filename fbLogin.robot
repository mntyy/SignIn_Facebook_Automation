*** Settings ***
Library    SeleniumLibrary
Library     BuiltIn
Test Teardown    Close Browser



*** Variables ***
${URL}    https://www.facebook.com
${BROWSER}    chrome
${input-user}    id=email
${input-pass}    id=pass
${correct-USERNAME}    mnty.test@gmail.com
${correct-PASSWORD}    Mnty19999
${incorrect-username}    any
${incorrect-password}    mon1234
${Login_btn}    name=login
${Logout_btn}    xpath=//span[text()='Log out']


*** Keywords ***
Open the website
    [Arguments]    ${URL}    ${BROWSER}
    Open Browser    ${URL}    ${BROWSER}

Login to Facebook
    [Arguments]    ${email}    ${pass}
    Input Text    ${input-user}    ${email}
    Input Text    ${input-pass}    ${pass}
    Wait Until Element Is Visible    ${Login_btn}    30s
    Click Button    ${Login_btn}

Verify Login Successful
    Wait Until Element Is Visible    xpath=//div[@role='main']    30s

Verify Login Failed
    Wait Until Element Is Visible    ${Login_btn}    30s

Logout from Facebook
    Wait Until Element Is Visible    xpath=//div[@aria-label='Your profile']    40s
    Sleep    3s
    Click Element    xpath=//div[@aria-label='Your profile']
    Sleep    2s
    Wait Until Element Is Visible    ${Logout_btn}    30s
    Click Element    ${Logout_btn}
    Wait Until Page Contains Element    xpath=//body[contains(@class,'UIPage_LoggedOut')]    40s

*** Test Cases ***
TC_01 : Facebook Login Success
    Open the website    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login to Facebook    ${correct-USERNAME}    ${correct-PASSWORD}
    Sleep    5s
    Verify Login Successful
    Sleep    5s

TC_02 : Login Failed - Incorrect Password
    Open the website    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login to Facebook    ${correct-USERNAME}    ${incorrect-password}
    Sleep    5s
    Verify Login Failed
    Sleep    5s

TC_03 : Login Failed - Username not found
    Open the website    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login to Facebook    ${incorrect-username}    ${correct-PASSWORD}
    Verify Login Failed
    Sleep    5s

TC_04 : Facebook Logout
    Open the website    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login to Facebook    ${correct-USERNAME}    ${correct-PASSWORD}
    Logout from Facebook
    Sleep    5s

