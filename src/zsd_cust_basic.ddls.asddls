@AbapCatalog.sqlViewName: 'ZSDCUST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Customer'
define view ZSD_Cust_basic as select from kna1 {
    kunnr,
    name1,
    land1
}
