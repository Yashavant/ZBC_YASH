FUNCTION ZOSD_SALES_ORDER_DEATILS.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_SO) TYPE  VBELN OPTIONAL
*"  EXPORTING
*"     VALUE(E_VBAK) TYPE  VBAK
*"----------------------------------------------------------------------
SELECT SINGLE *
  FROM vbak
  INTO e_vbak
 WHERE vbeln = i_so.

ENDFUNCTION.
