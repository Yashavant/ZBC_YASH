FUNCTION zsd_order_qty_check.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_VBELN) TYPE  VBELN_VA
*"  EXPORTING
*"     REFERENCE(EX_QTY) TYPE  I
*"----------------------------------------------------------------------

  TEST-SEAM get_qty.
    SELECT SUM( kwmeng )
      FROM vbap
      INTO @DATA(lv_qty)
     WHERE vbeln = @im_vbeln.
  END-TEST-SEAM.
  IF lv_qty <= 10.
    ex_qty = lv_qty + 1.
  ELSE.
    ex_qty = lv_qty + 10.
  ENDIF.


ENDFUNCTION.
