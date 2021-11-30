class ZCO_ZMM_PO_DETAILS definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    raising
      CX_AI_SYSTEM_FAULT .
  methods ZOMM_PURCHASE_ORDER_DEATILS
    importing
      !INPUT type ZZOMM_PURCHASE_ORDER_DEATILS
    exporting
      !OUTPUT type ZZOMM_PURCHASE_ORDER_DEATILSRE
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS ZCO_ZMM_PO_DETAILS IMPLEMENTATION.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = 'ZCO_ZMM_PO_DETAILS'
    logical_port_name   = logical_port_name
  ).

  endmethod.


  method ZOMM_PURCHASE_ORDER_DEATILS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ZOMM_PURCHASE_ORDER_DEATILS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
