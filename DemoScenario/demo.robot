*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  Collections

Resource    resources.robot
Resource    login-page.robot
Resource    catalog-page.robot

Suite Setup    Login To Platform

Test Setup    Run Keywords    Go To Catalog Page    Wait For All Rows Displayed    Get Original Number Of Products

*** Test Cases ***
Interact with products
    Click Select All    checked
    Check All Rows Selected
    Check number of products    ${OriginTotal}
    Click Select All    blank
    Check No Rows Selected
    Click First Catalog Item

Interact with filters
    Click Filter Value    class:SourceProductStatusFilter--DRAFT
    Check number of products    ${OriginTotal}    ${False}
    Get Filtered Number Of Products
    Open Filter    \#list-filter-packshot
    Click Filter Value    css:#list-filter-packshot .ListSimpleFilterItem:first-of-type
    Check number of products    ${OriginTotal}    ${False}
    Check number of products    ${FilteredTotal}    ${False}
    Remove Filters
    Check number of products    ${OriginTotal}

Search in catalog
    Search For GTIN
    Check Catalog Filtered    GTIN    ${gtin}
    Search For Name
    Check Catalog Filtered    NAME    ${text}
    Check number of products    ${OriginTotal}    ${False}

Export product
   Select first product
   Click Export Action
   Check Export Modale Opened
   Close Export Modale
