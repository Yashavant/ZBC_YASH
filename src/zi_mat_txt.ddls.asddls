@AbapCatalog.sqlViewName: 'ZMARA_TXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Text View'
define root view ZI_MAT_TXT
  as select from mara
{
  key matnr           as Matnr,
      ersda           as Ersda,
      created_at_time as CreatedAtTime,
      ernam           as Ernam,
      mtart           as Mtart,
      mbrsh           as Mbrsh,
      matkl           as Matkl,
      meins           as Meins,
      brgew           as Brgew,
      ntgew           as Ntgew,
      gewei           as Gewei,
      volum           as Volum,
      voleh           as Voleh

}
