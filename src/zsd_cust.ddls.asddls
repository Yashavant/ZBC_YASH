@AbapCatalog.sqlViewName: 'ZSD_CUSTOMERS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Customer'
define view ZSD_CUST as select from kna1 {
    key kunnr,
    name1
}
