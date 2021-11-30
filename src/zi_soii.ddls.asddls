@AbapCatalog.sqlViewName: 'ZBC_SOIV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SO Item'
define view ZI_SOII
  as select from zbc_soi
 association[0..1] to makt as _makt on $projection.Matnr = _makt.matnr
{
  key vbeln as Vbeln,
  key posnr as Posnr,
      matnr as Matnr,
      @Semantics.quantity.unitOfMeasure: 'Meins'
      menge as Menge,
      meins as Meins,
      @Semantics.amount.currencyCode: 'Waerk'
      netwr as Netwr,
      waerk as Waerk,
      //
      _makt
}
