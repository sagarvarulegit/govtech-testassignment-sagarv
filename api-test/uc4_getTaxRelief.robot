*** Settings ***
Library  RequestsLibrary
Library  JSONSchemaLibrary  .//test-data//schemas
Library  JSONLibrary
Library  .//utils//Utils.py


*** Variables ***
${base_url}     http://localhost:8080

*** Test Cases ***
Get Tax Relief \n AC1: a GET endpoint which returns a list consist of natid, tax relief amount and name\n AC2: natid field must be masked from the 5th character onwards with dollar sign $ \n
    [Tags]      schema_validation   sanity

    Create Session    session  ${base_url}
    ${json_obj}     Load Json From File     .//test-data//verify_tax_relief.json
    POST On Session     session     /calculator/insertMultiple  json=${json_obj}    expected_status=202
    ${resp}=   GET On Session  session  /calculator/taxRelief  expected_status=200
    Log To Console    ${resp}
    Should Be Equal As Strings          ${resp.status_code}  200
    Validate Json  relief-resp-schema.json  ${resp.content}
    validate_tax_relief       ${resp.content}

