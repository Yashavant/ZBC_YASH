class ZCL_ZMM_METERIAL_DPC_EXT definition
  public
  inheriting from ZCL_ZMM_METERIAL_DPC
  create public .

public section.
protected section.

  methods MATERIALSET_GET_ENTITY
    redefinition .
  methods MATERIALSET_GET_ENTITYSET
    redefinition .
  methods PLANTSET_GET_ENTITY
    redefinition .
  methods PLANTSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZMM_METERIAL_DPC_EXT IMPLEMENTATION.


  method MATERIALSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->MATERIALSET_GET_ENTITY
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
  endmethod.


  METHOD materialset_get_entityset.
    DATA: lv_matnr TYPE matnr.
    IF line_exists( it_key_tab[ name = 'Matnr' ] ).
      lv_matnr = it_key_tab[ name = 'Matnr' ]-value.
      lv_matnr = |{ lv_matnr ALPHA = IN }|.
      SELECT *
        FROM mara
        INTO TABLE et_entityset
        WHERE matnr = lv_matnr.
      ELSE.
      SELECT *
        FROM mara
        INTO TABLE et_entityset.
      ENDIF.
    ENDMETHOD.


  method PLANTSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->PLANTSET_GET_ENTITY
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
  endmethod.


  method PLANTSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->PLANTSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
  endmethod.
ENDCLASS.
