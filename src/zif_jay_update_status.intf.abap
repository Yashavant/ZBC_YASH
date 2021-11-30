interface ZIF_JAY_UPDATE_STATUS
  public .


  methods GET_DATA
    importing
      !IM_VBELN type VBELN_VA
    exporting
      !EX_UPD_QTY type ZSD_UPD_QTY .
  methods SET_DATA
    importing
      !IM_UPD_DATA type ZSD_UPD_QTY
    returning
      value(EX_RESULT) type CHAR1 .
endinterface.
