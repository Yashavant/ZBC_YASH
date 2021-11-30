class ZCL_ZSD_SALES_ORDER_DPC_EXT definition
  public
  inheriting from ZCL_ZSD_SALES_ORDER_DPC
  create public .

public section.
protected section.

  methods HEADERSET_GET_ENTITY
    redefinition .
  methods HEADERSET_GET_ENTITYSET
    redefinition .
  methods ITEMSET_GET_ENTITYSET
    redefinition .
  methods ITEMSET_GET_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZSD_SALES_ORDER_DPC_EXT IMPLEMENTATION.


  METHOD headerset_get_entity.
    DATA: lv_vbeln TYPE vbeln_va.
    IF line_exists( it_key_tab[ name = 'Vbeln' ] ).
      lv_vbeln = it_key_tab[ name = 'Vbeln' ]-value.
      lv_vbeln = |{ lv_vbeln ALPHA = IN }|.
      SELECT SINGLE *
        FROM vbak
        INTO er_entity
        WHERE vbeln = lv_vbeln.
      IF sy-subrc NE 0.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = 'Data not Found'.
      ENDIF."IF sy-subrc eq 0.
    ENDIF.
  ENDMETHOD.


  method HEADERSET_GET_ENTITYSET.
*DATA: lv_vbeln TYPE vbeln_va.
*    IF line_exists( it_key_tab[ name = 'Vbeln' ] ).
*      lv_vbeln = it_key_tab[ name = 'Vbeln' ]-value.
*      lv_vbeln = |{ lv_vbeln ALPHA = IN }|.
*      SELECT *
*        FROM vbak
*        INTO TABLE et_entityset
*       WHERE vbeln = lv_vbeln.
*      IF sy-subrc NE 0.
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = 'Data not found'.
*      ENDIF. "IF sy-subrc ne 0.
*    ELSE.
*      SELECT *
*        FROM vbak
*        INTO TABLE et_entityset.
*    ENDIF." IF line_exists( IT_KEY_TAB[ name = 'Vbeln' ] ).

  endmethod.


  METHOD itemset_get_entity.
**TRY.
*CALL METHOD SUPER->ITEMSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

  ENDMETHOD.


  METHOD itemset_get_entityset.
    DATA: lv_vbeln TYPE vbeln_va.
    IF line_exists( it_key_tab[ name = 'Vbeln' ] ).
      lv_vbeln = it_key_tab[ name = 'Vbeln' ]-value.
      lv_vbeln = |{ lv_vbeln ALPHA = IN }|.
      SELECT *
        FROM vbap
        INTO TABLE et_entityset
       WHERE vbeln = lv_vbeln.
      IF sy-subrc NE 0.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = 'Data not found'.
      ENDIF. "IF sy-subrc ne 0.
    ELSE.
      SELECT *
        FROM vbap
        INTO TABLE et_entityset.
    ENDIF." IF line_exists( IT_KEY_TAB[ name = 'Vbeln' ] ).

  ENDMETHOD.
ENDCLASS.
