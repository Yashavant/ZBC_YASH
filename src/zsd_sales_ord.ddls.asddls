@AbapCatalog.sqlViewName: 'ZSD_SALESORD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Order'
@OData.publish: true
@UI.chart: [{
       chartType: #DONUT,
       measures: ['netwr'] ,
      measureAttributes: [{measure: 'netwr',role: #AXIS_1 }],
      dimensions: ['name1'],
      dimensionAttributes: [{dimension: 'name1',role: #CATEGORY }] }]
define view ZSD_SALES_ORD as select from vbak as v inner join ZSD_CUST as k on v.kunnr = k.kunnr {
  @UI.lineItem: [{position: 1 }]
  key vbeln,
  @UI.selectionField: [{position: 1 }]
  @UI.lineItem: [{position: 2 }]
  k.kunnr as kunnr,
  @UI.lineItem: [{position: 3 }]
  @UI.selectionField: [{position: 2 }]
  name1,
  @UI.lineItem: [{position: 4 }]
  vkorg,
  @UI.lineItem: [{position: 5 }]
  @DefaultAggregation: #SUM
  netwr,
  @UI.lineItem: [{position: 6 }]
  waerk  
}
