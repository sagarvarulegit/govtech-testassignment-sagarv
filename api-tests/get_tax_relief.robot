*** Settings ***
Library  RequestsLibrary
Library  JSONSchemaLibrary  .//test-data//schemas
Library  JSONLibrary
Library  OperatingSystem
Library  .//utils//Utils.py
Library  Collections

Documentation           UC4 AC1 to AC6: Get Tax Relief \n AC1: a GET endpoint which returns a list consist of natid, tax relief amount and name AC2: natid field must be masked from the 5th character onwards with dollar sign $ \n


*** Test Cases ***
Verify Tax Relief schema
    [Tags]      schema_validation   sanity
    Create Session    session  ${app_url}
    ${json_obj}     Load Json From File     .//test-data//verify_tax_relief.json
    POST On Session     session     /calculator/insertMultiple  json=${json_obj}    expected_status=202
    ${resp}=   GET On Session  session  /calculator/taxRelief  expected_status=200
    Log To Console    ${resp}
    Should Be Equal As Strings          ${resp.status_code}  200
    Validate Json  relief-resp-schema.json  ${resp.content}
    validate_tax_relief       ${resp.content}


Validate Tax Relief rounding on edge case. In this case Calulated Tax Relief = 50.5 so after normal round Final Tax Relief should be 51
    [Tags]      edge_case   regression
    Create Session    session  ${app_url}
    ${body}=    Create Dictionary   birthday=11101943   gender=M    name=testK  natid=DA444     salary=2500     tax=1490
    ${resp1}=    POST On Session     session     /calculator/insert  json=${body}    expected_status=202
    ${resp2}=   GET On Session  session  /calculator/taxRelief  expected_status=200
    Should Be Equal As Strings          ${resp2.status_code}  200
    ${resp_li}=   Convert To List    ${resp2.json()}
    ${d}=       Create Dictionary   name=testK
    ${dict}=    get_dict_from_list  ${resp_li}      ${d}
    ${relief_amt}=  Get From Dictionary    ${dict}    relief
    Should Be Equal    ${relief_amt}    51.00

Verify Total Amount in Tax Relief Summary is correct
        [Tags]      sanity
        Create Session    session  http://localhost:8080
        ${resp}=   GET On Session  session  /calculator/taxRelief  expected_status=200
        ${amount}=      calculate_tax_amount    ${resp.content}
        Log To Console    ${amount}
        ${resp}=   GET On Session  session  /calculator/taxReliefSummary
        Should Be Equal    ${amount}    ${resp.json()}[totalTaxReliefAmount]





 


