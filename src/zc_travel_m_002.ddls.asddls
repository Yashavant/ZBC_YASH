@EndUserText.label: 'Travel Projection View'
@AccessControl.authorizationCheck: #CHECK

@UI: {
 headerInfo: { typeName: 'Travel', typeNamePlural: 'Travels', title: { type: #STANDARD, value: 'TravelID' } } }

@Search.searchable: true

define root view entity ZC_TRAVEL_M_002
  as projection on ZI_TRAVEL_M_002
{
      @UI.facet: [ { id:              'Travel',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Travel',
                     position:        10 } ]

      @UI.hidden: true
  key Mykey         as TravelUUID,
      @UI: {
        lineItem:       [ { position: 10, importance: #HIGH } ],
        identification: [ { position: 10, label: 'Travel ID [1,...,99999999]' } ] }
      @Search.defaultSearchElement: true
      TravelId      as TravelID,
      @UI: {
      lineItem:       [ { position: 20, importance: #HIGH } ],
      identification: [ { position: 20 } ],
      selectionField: [ { position: 20 } ] }
     // @Consumption.valueHelpDefinition: [{ entity : {name: 'KNA1', element: 'KUNNR'  } }]

     // @ObjectModel.text.element: ['NAME1']
      @Search.defaultSearchElement: true
      CustomerId    as CustomerID,
      @UI: {
      lineItem:       [ { position: 30, importance: #MEDIUM } ],
      identification: [ { position: 30 } ] }
      BeginDate     as BeginDate,
      @UI: {
          lineItem:       [ { position: 31, importance: #MEDIUM } ],
          identification: [ { position: 31 } ] }
      EndDate       as EndDate,
      @UI: {
      lineItem:       [ { position: 40, importance: #MEDIUM } ],
      identification: [ { position: 40, label: 'Total Price' } ] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      // BookingFee,
      TotalPrice    as TotalPrice,
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      CurrencyCode  as CurrencyCode,

      @UI: {
      lineItem:       [ { position: 60, importance: #HIGH },
                       { type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel' } ],
      identification: [ { position: 60, label: 'Status [O(Open)|A(Accepted)|X(Canceled)]' } ]  }
      OverallStatus as TravelStatus,
      @UI.identification: [ { position: 70, label: 'Remarks' } ]
      Description,
      // CreatedBy,
      // CreatedAt,
      // LastChangedBy,
      @UI.hidden: true
      LastChangedAt
}
