@AbapCatalog.sqlViewName: 'ZSPFLI_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SPFLI'
define view ZSPFLI as select from spfli {
    //SPFLI
    key carrid,
    key connid,
    countryfr,
    cityfrom,
    airpfrom,
    countryto,
    cityto,
    airpto,
    //fltime,
    cast(  fltime as abap.char( 15 ) ) as fltm,
    deptime,
    arrtime,
    distance,
    distid,
    fltype,
    period
}
