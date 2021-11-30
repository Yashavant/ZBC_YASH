FUNCTION zfi_acc.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(LS_DATA) TYPE  ZFI_ACC
*"  EXPORTING
*"     VALUE(LV_STATUS) TYPE  MAKTX
*"----------------------------------------------------------------------

  IF ls_data IS NOT INITIAL.
    MODIFY zfi_acc FROM ls_data.
  ENDIF.

ENDFUNCTION.
