*&---------------------------------------------------------------------*
*& Report ZBC_JAY_REFACTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_jay_refacture.

SELECT SINGLE vbeln
  FROM vbak
  INTO @DATA(lv_vbeln)
  WHERE vbeln = '0000000003'.
IF lv_vbeln IS NOT INITIAL.
  SELECT SINGLE *
    FROM zsd_upd_qty
    INTO @DATA(ls_upd_qty)
    WHERE vbeln = @lv_vbeln.
ENDIF.

IF ls_upd_qty-menge < 10.
  ls_upd_qty-status = abap_true.
ELSE.
  ls_upd_qty-status = abap_false.
ENDIF.

MODIFY zsd_upd_qty FROM ls_upd_qty.
