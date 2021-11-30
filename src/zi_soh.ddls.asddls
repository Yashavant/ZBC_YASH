@AbapCatalog.sqlViewName: 'ZBC_SOHV'
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SO Header'
define view ZI_SOH
  as select from zbc_soh as soh
  association [0..1] to kna1 as _kna1 on $projection.Kunnr = _kna1.kunnr
  association [0..1] to tvko as _tvko on $projection.Vkorg = _tvko.vkorg
{
  key vbeln      as Vbeln,
      ernam      as Ernam,
      erdat      as Erdat,
      vkorg      as Vkorg,
      vtweg      as Vtweg,
      spart      as Spart,
      kunnr      as Kunnr,
      @Semantics.user.lastChangedBy: true
      changed_by as changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      changed_at as changed_at,
      // Make association public
      _kna1,
      _tvko
}
