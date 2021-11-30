class ZCL_JAY_UPDATE_STATUS definition
  public
  create public .

public section.

  interfaces ZIF_JAY_UPDATE_STATUS .
protected section.
private section.
ENDCLASS.



CLASS ZCL_JAY_UPDATE_STATUS IMPLEMENTATION.


  METHOD zif_jay_update_status~get_data.
    SELECT SINGLE vbeln
  FROM vbak
  INTO @DATA(lv_vbeln)
  WHERE vbeln = @im_vbeln.
    IF lv_vbeln IS NOT INITIAL.
      SELECT SINGLE *
        FROM zsd_upd_qty
        INTO @DATA(ls_upd_qty)
        WHERE vbeln = @lv_vbeln.
    ENDIF.
  ENDMETHOD.


  METHOD zif_jay_update_status~set_data.
    MODIFY zsd_upd_qty FROM im_upd_data.
    IF sy-subrc EQ 0.
      ex_result = 'X'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
