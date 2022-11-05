*** Settings ***
Library  SeleniumLibrary
Test Setup       Open Browser    http://localhost:8080   Chrome
Test Teardown    Close All Browsers

*** Test Cases ***
UC5: As the Governor, I should be able to see a button on the screen so that I can dispense tax relief for my working class heroes

    [Tags]  upload_csv  sanity  postive_tc
    ${dispense_btn}      Get WebElement    css:a[href='dispense']
    Element Text Should Be      ${dispense_btn}        Dispense Now
    ${color}=   Get CSS Property Value    ${dispense_btn}    background-color
    Should Match    ${color}    rgba(220, 53, 69, 1)
    Click Button    ${dispense_btn}
    Page Should Contain    Cash dispensed

*** Keywords ***
Get CSS Property Value
    [Documentation]
    ...    Get the CSS property value of an Element.
    ...
    ...    This keyword retrieves the CSS property value of an element. The element
    ...    is retrieved using the locator.
    ...
    ...    Arguments:
    ...    - locator           (string)    any Selenium Library supported locator xpath/css/id etc.
    ...    - property_name     (string)    the name of the css property for which the value is returned.
    ...
    ...    Returns             (string)    returns the string value of the given css attribute or fails.
    ...
    [Arguments]    ${locator}    ${attribute name}
    ${css}=         Get WebElement    ${locator}
    ${prop_val}=    Call Method       ${css}    value_of_css_property    ${attribute name}
    [Return]     ${prop_val}
