# govtech-testassignment-sagarv

This project is showcase test automation of Oppenheimer Project which is part of hiring test engineer role.
Test script are written in RobotFramework based on Python3. Test scripts cover automation of all the User-stories and its,
Acceptance Criteria as well edge cases and negative scenarios.


## Pre-requiste
- ``Python 3.10.8 or higher``
- ``RobotFramework 6.0``
- Make sure application is running on http://localhost:8080

## Steps to Run Tests
1. ``pip install -r requirements.txt``
2. ``cd {project dir path}``
3. run ``python -m "robot" --variable app_url:http://localhost:8080 --variable browser:chrome .``. This will run entire test-suite which consist of API and UI tests both.

## Description
Test Suite is segregated into directories conveying its usage as below.

|           |                                                              |
|-----------|--------------------------------------------------------------|
| api-tests | Contains all the API tests RequestLibrary                    |
| ui-tests  | Contains all the UI Tests using SeleniumLibrary              | 
| test-data | Contains all the test data file (.json, .csv) used scenarios |
| utils     | Utility module written in python to help with custom methods |

### Reports
Reports are generated in mentioned files below:
- Output:  `{root}\output.xml`
- Log:     `{root}\log.html`
- Report:   `{root}\report.html`

*1 Failed Test in report is genuine failed scenario. Application is not rounding decimal when value has .5, which is genuine defect*


## Defects
1.	When we click on Browse button and select a file, the path or filename is not displayed in the “Choose file” text box. Only tool tip is displayed on mouse over.
2.	No message is displayed if uploaded file is successful or not.
3.	Name of the working-class heroes is not displayed to the Bookkeeper in the UI.
4.	On Dispense cash button click without any data(When no records are present), the message still shows cash dispensed.
5.	Decimal values are displayed in certain scenarios when decimal values are greater than 0.50
6.	Duplicate Records 

    *Defects are reported in `{root}\Defect-List.docx` file 

## Enhancements
1.	Option to Click on Upload button instead of only Browse option to upload the csv file into the database.
2.	Message should be displayed whether file is uploaded successfully or not.
3.	UI could be more user-friendly.
4.	Need Endpoint to fetch Hero/Person details from DB
5.	Need Endpoint to Delete and Update Records


