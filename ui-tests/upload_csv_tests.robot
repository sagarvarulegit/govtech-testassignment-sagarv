*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library   .//utils//Utils.py
Test Teardown    Close All Browsers

Documentation       UC3: User can insert recpord through uploading csv
*** Test Cases ***
Upload Valid CSV
    [Tags]  upload_csv  sanity  postive_tc
    ${driver_path}=     get_driver_path_with_browser        ${browser}
    Create Webdriver     Chrome     executable_path=${driver_path}
    Go To    ${app_url}
    ${DIR}=     pwd
    Log To Console    ${DIR}
    Choose File     css:input[type='file']  ${DIR}//test-data//sample_data.csv

Upload InValid CSV
    [Tags]  upload_csv  sanity  postive_tc
    ${driver_path}=     get_driver_path_with_browser        ${browser}
    Create Webdriver     Chrome     executable_path=${driver_path}
    Go To    ${app_url}
    ${DIR}=     pwd
    Log To Console    ${DIR}
    Choose File     css:input[type='file']  ${DIR}//test-data//invalid.csv


    

