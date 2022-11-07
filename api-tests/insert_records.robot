*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary


*** Test Cases ***
UC1_AC1: As the Clerk, I should be able to insert a single record of working class hero into database via an API
    [Tags]      sanity      positive_tc
    Create Session    session    ${app_url}
    ${body}=    Create Dictionary   birthday=11101985   gender=M    name=Sagar  natid=33333     salary=1000     tax=10
    ${resp}=    POST On Session     session     /calculator/insert  json=${body}    expected_status=202
    Log To Console    ${resp}

UC1_AC1: Insert Endpoint should not accept Invalid Birthdate
    [Tags]      regression  negative_tc
    Create Session    session    ${app_url}
    ${body}=    Create Dictionary   birthday=1110198   gender=M    name=Sagar  natid=33333     salary=1000     tax=10
    ${resp}=    POST On Session     session     /calculator/insert  json=${body}    expected_status=500
    Should Be Equal    ${resp.json()}[message]      Text '1110198' could not be parsed at index 4
    Log To Console    ${resp}

UC1_AC1: Insert Endpoint should not accept Gender more than 1 character
    [Tags]      regression  negative_tc
    Create Session    session    ${app_url}
    ${body}=    Create Dictionary   birthday=11101985   gender=Male    name=Sagar  natid=33333     salary=1000     tax=10
    ${resp}=    POST On Session     session     /calculator/insert  json=${body}    expected_status=500
    Should Be Equal    ${resp.json()}[message]      could not execute statement; SQL [n/a]; nested exception is org.hibernate.exception.DataException: could not execute statement
    Log To Console    ${resp}


UC2_AC2. As the Clerk, I should be able to insert more than one working class hero into database via an API
    [Tags]      multiple_hero
    Create Session    session    ${app_url}
    ${json_obj}     Load Json From File     .//test-data//insert_multiple.json
    ${resp}=    POST On Session     session     /calculator/insertMultiple  json=${json_obj}    expected_status=202
    Log To Console    ${resp}




