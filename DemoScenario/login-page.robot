*** Keywords ***
Navigate To Homepage
    Open Browser    ${siteUrl}/#/login    ${browser}
    Maximize Browser Window

Enter Username
    [Arguments]    ${username}
    Wait Until Element Is Visible    username
    Input Text  username    ${username}

Enter Password
    [Arguments]    ${password}
    Input Text  password    ${password}
    
Submit Login Form
    Click Button    submit
    Element Should Be Disabled    submit

Login To Platform
    Navigate To Homepage
    Enter Username    gfaucompre+m_a_admin@alkemics.com
    Enter Password    kUe&q2m1^Rhu8bPx%yXfseNH4i*8^8
    Submit Login Form
    Wait Until Page Contains Element    class:navbar    10
