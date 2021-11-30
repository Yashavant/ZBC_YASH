class ZCL_ZTESTSET_DPC_EXT definition
  public
  inheriting from ZCL_ZTESTSET_DPC
  create public .

public section.
protected section.

  methods SALES_ORDERSET_GET_ENTITY
    redefinition .
  methods SALES_ORDERSET_GET_ENTITYSET
    redefinition .
  methods SALES_ORDER_ITEM_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZTESTSET_DPC_EXT IMPLEMENTATION.


  METHOD sales_orderset_get_entity.
    DATA: lv_vbeln TYPE vbeln_va.
    IF line_exists( it_key_tab[ name = 'Vbeln' ] ).
      lv_vbeln = it_key_tab[ name = 'Vbeln' ]-value.
      lv_vbeln = |{ lv_vbeln ALPHA = IN }|.
      SELECT SINGLE *
               FROM zsd_soh
               INTO er_entity
              WHERE vbeln = lv_vbeln.
    ENDIF.
  ENDMETHOD.


  method SALES_ORDERSET_GET_ENTITYSET.
    SELECT *
      FROM zsd_soh
      INTO TABLE et_entityset.
  endmethod.


  METHOD sales_order_item_get_entityset.
    DATA: lv_vbeln TYPE vbeln_va.
    IF line_exists( it_key_tab[ name = 'Vbeln' ] ).
      lv_vbeln = it_key_tab[ name = 'Vbeln' ]-value.
      lv_vbeln = |{ lv_vbeln ALPHA = IN }|.

      SELECT  *
        FROM vbap
        INTO TABLE et_entityset
       WHERE vbeln = lv_vbeln.

      ELSE.

        SELECT  *
          FROM vbap
          INTO TABLE et_entityset.

      ENDIF.
    ENDMETHOD.
ENDCLASS.
