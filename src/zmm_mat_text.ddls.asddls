@AbapCatalog.sqlViewName: 'ZMM_TEST1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Text'
define view ZMM_MAT_TEXT as select from mara
association [0..*] to makt as __makt
    on $projection.matnr = __makt.matnr {
     matnr,
    ernam,
    
    __makt // Make association public
}
