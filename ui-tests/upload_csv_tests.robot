*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library   .//utils//Utils.py
Test Setup       Open Browser    http://localhost:8080   Chrome
Test Teardown    Close All Browsers


*** Test Cases ***
UC3: User can insert recpord through uploading csv
    [Tags]  upload_csv  sanity  postive_tc
    ${DIR}=     pwd
    Log To Console    ${DIR}
    Choose File     css:input[type='file']  ${DIR}//test-data//sample_data.csv


    

