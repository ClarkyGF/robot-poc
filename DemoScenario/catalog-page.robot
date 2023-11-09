*** Variables ***
${collapsed_class}    ListCollapsibleFilter--collapsed
${gtin}
${text}

*** Keywords ***
Go To Catalog Page
    ${url}=    Set Variable    ${siteUrl}/#/catalog/all
    Go To    ${url}
    Handle Cookie Modale
    Wait For Loader To Disappear

Close Cookie Modale
    Click Element    data:testid:Modal-confirm
    Wait Until Element Is Not Visible    data:testid:Modal-confirm

Handle Cookie Modale
    ${element_is_visible}=    Run Keyword And Return Status    
    ...    Element Should Be Visible    data:testid:Modal-confirm
    Run Keyword If    ${element_is_visible} == ${True}
    ...    Close Cookie Modale

Wait For Loader To Disappear
    ${element_is_visible}=    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    class:Loader
    Run Keyword If    ${element_is_visible} == ${True}
    ...    Wait Until Element Is Not Visible    class:Loader

Get Original Number Of Products
    ${element_text}=    Get Text    class:ListPaginationInfo__total
    Set Suite Variable    $OriginTotal    ${element_text}

Get Filtered Number Of Products
    ${element_text}=    Get Text    class:ListPaginationInfo__total
    Set Test Variable    $FilteredTotal    ${element_text}

Check All Rows Displayed
    ${selected_rows}=    Get WebElements    class:ListTableRow
    ${expected_count}=    Convert To Integer    20
    Should Be Equal As Integers    ${selected_rows.__len__()}    ${expected_count}

Wait For All Rows Displayed
    Wait Until Keyword Succeeds    10s    2s    Check All Rows Displayed

Click Select All
    [Arguments]    ${expected_class}
    Click Element    id:list-actions-select-all
    Wait Until Element Is Enabled    css:#list-actions-select-all .ReactUiCheckbox__${expected_class}

Check number of products
    [Arguments]    ${all_products_text}    ${equals}=${True}
    Run Keyword If    $equals == ${True}
    ...    Element Text Should Be    class:ListPaginationInfo__total    ${all_products_text}
    ...  ELSE
    ...    Element Text Should Not Be   class:ListPaginationInfo__total    ${all_products_text}

Check All Rows Selected
    ${selected_rows}=    Get WebElements    class:ListTableRow--selected
    ${expected_count}=    Convert To Integer    20
    Should Be Equal As Integers    ${selected_rows.__len__()}    ${expected_count}

Check No Rows Selected
    ${selected_rows}=    Get WebElements    class:ListTableRow--selected
    Should Be Empty    ${selected_rows}

Click First Catalog Item
    Click Element    class:CatalogCellActionWrapper--link
    Wait Until Element Is Visible    class:ProductFooter

Open Filter
    [Arguments]    ${locator}
    ${filter_classes}=    Get Element Attribute    css:${locator}    class
    ${collapsed_contained}=    Run Keyword And Return Status    
    ...    Should Contain    ${filter_classes}    ${collapsed_class}
    Run Keyword If    ${collapsed_contained}    
    ...    Click Element    css:${locator} button

Click Filter Value
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}
    Wait For Loader To Disappear
    
Remove Filters
    Click Element    class:ListSelectedFilters_remove
    Wait For Loader To Disappear

Search For GTIN
    ${gtin}=    Get Text    css:[data-testid="ProductReference__copyWrapper"]:first-of-type
    Input Text    css:.Search .Search__input    ${gtin}
    Wait For Loader To Disappear

Search For Name
    ${text}    Set Variable    KAT
    Input Text    css:.Search .Search__input    ${text}
    Wait For Loader To Disappear

Check Catalog Filtered
    [Arguments]    ${data_type}    ${input}
    ${rows}    Get WebElements    data:code:${data_type}
    FOR    ${row}    IN    @{rows}
        Element Should Contain    ${row}    ${input}
    END

Select First Product
    Click Element    css:[id^="catalog-row-checkbox-"]:first-of-type
    Element Should Contain    class:Dropdown__button    Exporter 1

Click Export Action
    Click Element    css:.Dropdown__button:first-of-type
    Wait Until Page Contains Element    xpath://*[contains(text(), 'Export fiche produit')]
    Click Element    xpath://*[contains(text(), 'Export fiche produit')]

Check Export Modale Opened
    Wait Until Element Is Visible    id:SimpleSelect-catalog-export-modal-format-selector

Close Export Modale
    Click Element    class:Modal__footerCloseButton
    Element Should Not Be Visible    class:CatalogExportModal
