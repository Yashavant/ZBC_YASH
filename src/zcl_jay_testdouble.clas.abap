class ZCL_JAY_TESTDOUBLE definition
  public
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IM_TEST_DOUBLE type ref to ZIF_JAY_UPDATE_STATUS optional .
  methods TEST_DOUBLE_CODE
    importing
      !IM_VBELN type VBELN_VA
    exporting
      !EX_RESULT type ABAP_BOOL .
  methods SET_UPDATED_QTY
    importing
      !IM_UPD_DATA type ZSD_UPD_QTY
    exporting
      !EX_UPD_QTY type ZSD_UPD_QTY .
  methods MOCK_CALL
    importing
      !IM_VBELN type VBELN_VA
    returning
      value(EX_RESULT) type CHAR1 .
  methods TEST_STEAM_CALL .
protected section.

  methods GET_DATA_DA
    importing
      !IM_VBELN type VBELN_VA
    exporting
      !EX_UPD_QTY type ZSD_UPD_QTY .
  methods UPDATE_DATA_DA
    importing
      !IM_UPD_DATA type ZSD_UPD_QTY
    returning
      value(EX_RESULT) type CHAR1 .
private section.

  data GD_TEST_DOUBLE type ref to ZIF_JAY_UPDATE_STATUS .
ENDCLASS.



CLASS ZCL_JAY_TESTDOUBLE IMPLEMENTATION.


  METHOD constructor.
    IF im_test_double IS BOUND.
      gd_test_double = im_test_double.
    ELSE.
      gd_test_double = NEW zcl_jay_update_status( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_data_da.
    SELECT SINGLE vbeln
      FROM vbak
      INTO @DATA(lv_vbeln)
     WHERE vbeln = @im_vbeln.
    IF lv_vbeln IS NOT INITIAL.
      SELECT SINGLE *
        FROM zsd_upd_qty
        INTO @ex_upd_qty
        WHERE vbeln = @lv_vbeln.
    ENDIF.
  ENDMETHOD.


  METHOD mock_call.
    get_data_da(
      EXPORTING
        im_vbeln   = im_vbeln                 " Sales Document
      IMPORTING
        ex_upd_qty = DATA(ls_upd_qty)                 " Update Quantity
    ).

    set_updated_qty(
      EXPORTING
        im_upd_data =  ls_upd_qty                " Update Quantity
      IMPORTING
        ex_upd_qty  =  ls_upd_qty                " Update Quantity
    ).

    ex_result = update_data_da( im_upd_data = ls_upd_qty ).

  ENDMETHOD.


  METHOD set_updated_qty.
    ex_upd_qty = im_upd_data.
    IF im_upd_data-menge < 10.
      ex_upd_qty-status = abap_true.
    ELSE.
      ex_upd_qty-status = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD test_double_code.

    IF gd_test_double IS BOUND.
      gd_test_double->get_data(
        EXPORTING
          im_vbeln   = im_vbeln
        IMPORTING
          ex_upd_qty =  DATA(ls_upd_data) ).

      set_updated_qty(
        EXPORTING
          im_upd_data = ls_upd_data
        IMPORTING
          ex_upd_qty  = ls_upd_data  ).

      ex_result = gd_test_double->set_data( im_upd_data = ls_upd_data  ).
    ENDIF.
  ENDMETHOD.


  method TEST_STEAM_CALL.
  endmethod.


  METHOD update_data_da.
    MODIFY zsd_upd_qty FROM im_upd_data.
    IF sy-subrc EQ 0.
      ex_result = 'X'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
