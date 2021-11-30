@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.sqlViewName: 'ZBC_TEST_CDSU'
@EndUserText.label: 'Sales order, Sales order document flow'
define view ZBC_TEST_CDS_U
  as select from    vbap            as sales_item
    left outer join vbak            as sales_header      on sales_item.vbeln = sales_header.vbeln
    left outer join knvv            as customer_sales    on  customer_sales.kunnr = sales_header.kunnr
                                                         and customer_sales.vkorg = sales_header.vkorg
                                                         and customer_sales.vtweg = sales_header.vtweg
                                                         and customer_sales.spart = sales_header.spart
    left outer join vbfa            as sales_doc_flow    on  sales_item.vbeln       = sales_doc_flow.vbelv
                                                         and sales_item.posnr       = sales_doc_flow.posnv
                                                         and sales_doc_flow.vbtyp_n = 'J'
    left outer join likp            as delivery          on sales_doc_flow.vbeln = delivery.vbeln

    left outer join tvv5t           as sales_office_text on  (
                                                         sales_office_text.kvgr5  = sales_header.kvgr5
                                                         or sales_office_text.kvgr5 = customer_sales.kvgr5
      )
                                                         and sales_office_text.spras = $session.system_language

{
  sales_header.vbeln                       as    SalesDocument,
  sales_item.posnr                         as    SalesDocumentItem,
  sales_header.auart                       as    SalesDocumentType,
  customer_sales.vkorg                     as    SalesOrganization,
  sales_header.kvgr5                       as    SalesordSalesOffice,
  customer_sales.kunnr                     as    Customer,
  customer_sales.vtweg                     as    DistributionChannel,
  customer_sales.spart                     as    Division,
  customer_sales.kvgr1                     as    CustomerType,
  customer_sales.kvgr5                     as    CustSalesOffice,
  sales_doc_flow.vbeln                     as    Delivery,
  sales_doc_flow.posnn                     as    DeliveryItem,
  delivery.podat                           as    ProofOfDelivery,
  sales_office_text.bezei                  as    SalesOfficeText,
  sales_office_text.spras                  as    language_sales_office
}
