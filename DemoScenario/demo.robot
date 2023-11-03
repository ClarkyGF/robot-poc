*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  Collections

Resource    resources.robot
Resource    login-page.robot
Resource    catalog-page.robot

Suite Setup    Login To Platform

*** Test Cases ***
Interact with products
    Go To Catalog Page
    ${invoice}=    Get Dummy Invoice    demo
    Navigate To Add Invoice
    Fill Out Invoice Details    ${invoice}
    Submit Invoice Form
    ${invoice_id}=   Get Invoice Id     ${invoice}
    Page Should Contain     ${invoice_id}
    Open Invoice    ${invoice_id}

Interact with filters
    Go To Catalog Page
    ${invoice}=    Get Dummy Invoice    demo
    Navigate To Add Invoice
    Fill Out Invoice Details    ${invoice}
    Submit Invoice Form
    ${invoice_id}=   Get Invoice Id     ${invoice}
    Page Should Contain     ${invoice_id}
    Open Invoice    ${invoice_id}

Search in catalog
    Go To Catalog Page
    ${invoice}=    Get Dummy Invoice    demo
    Navigate To Add Invoice
    Fill Out Invoice Details    ${invoice}
    Submit Invoice Form
    ${invoice_id}=   Get Invoice Id     ${invoice}
    Page Should Contain     ${invoice_id}
    Open Invoice    ${invoice_id}

Export product
    Go To Catalog Page
    ${invoice}=    Get Dummy Invoice    demo
    Navigate To Add Invoice
    Fill Out Invoice Details    ${invoice}
    Submit Invoice Form
    ${invoice_id}=   Get Invoice Id     ${invoice}
    Page Should Contain     ${invoice_id}
    Open Invoice    ${invoice_id}


