@AbapCatalog.sqlViewName: 'ZTRAVEL2V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data model for travel'
define root view ZI_TRAVEL_M_002
  as select from ztravel_002 as Travel
  association [0..1] to kna1  as _Customer on $projection.customer_id = _Customer.kunnr
  association [0..1] to tcurc as _Currency on $projection.currency_code = _Currency.waers
{
  key mykey           as Mykey,
      travel_id       as TravelId,
      customer_id     as CustomerId,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee     as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price     as TotalPrice,
      currency_code   as CurrencyCode,
      description     as Description,
      overall_status  as OverallStatus,
      
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      
      _Customer,
      _Currency
}
