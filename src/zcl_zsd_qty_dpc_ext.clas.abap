class ZCL_ZSD_QTY_DPC_EXT definition
  public
  inheriting from ZCL_ZSD_QTY_DPC
  create public .

public section.
protected section.

  methods ORDERSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZSD_QTY_DPC_EXT IMPLEMENTATION.


  METHOD orderset_get_entityset.
    DATA: r_vbeln   TYPE RANGE OF vbeln_va,
          ls_vbeln1 LIKE LINE OF r_vbeln.
    IF line_exists( it_filter_select_options[ property = 'Vbeln' ] ).
      DATA(lt_vbeln) = it_filter_select_options[ property = 'Vbeln' ]-select_options.
      LOOP AT lt_vbeln INTO DATA(ls_vbeln).
        ls_vbeln1-sign = ls_vbeln-sign.
        ls_vbeln1-option = ls_vbeln-option.
        ls_vbeln1-low = ls_vbeln-low.
        ls_vbeln1-high = ls_vbeln-high.
        ls_vbeln1-low = |{ ls_vbeln1-low ALPHA = IN }|.
        ls_vbeln1-high = |{ ls_vbeln1-high ALPHA = IN }|.
        APPEND ls_vbeln1 TO r_vbeln.
      ENDLOOP.

      SELECT *
        FROM zsd_upd_qty
        INTO TABLE et_entityset
        WHERE vbeln IN r_vbeln.
    ELSE.

      SELECT *
        FROM zsd_upd_qty
        INTO TABLE et_entityset.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
