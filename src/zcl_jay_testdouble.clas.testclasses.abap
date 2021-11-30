*"* use this source file for your ABAP unit test classes
*CLASS lcl_test_double DEFINITION DEFERRED.
*CLASS zcl_jay_testdouble DEFINITION LOCAL FRIENDS lcl_test_double.

CLASS lcl_test_double DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_cut            TYPE REF TO zcl_jay_testdouble,  "class under test
      ob_interface_upd TYPE REF TO zif_jay_update_status.
    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: test_double_code FOR TESTING.
ENDCLASS.       "lcl_Test_Double

CLASS lcl_test_double IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.
  METHOD class_teardown.
  ENDMETHOD.
  METHOD setup.
    ob_interface_upd ?= cl_abap_testdouble=>create(
                          object_name = 'ZIF_JAY_UPDATE_STATUS'  ).

    f_cut = NEW zcl_jay_testdouble( ob_interface_upd ).
  ENDMETHOD.

  METHOD teardown.
    FREE:ob_interface_upd,f_cut.
  ENDMETHOD.

  METHOD test_double_code.
    DATA: lv_vbeln   TYPE vbeln_va,
          ls_upd_qty TYPE zsd_upd_qty.
*Given
    ls_upd_qty = VALUE #(  vbeln = '11111'
                            posnr = '1111'
                            menge = '5'
                            meins = 'ST'  ).
    cl_abap_testdouble=>configure_call( ob_interface_upd )->set_parameter(
      EXPORTING
        name          = 'EX_UPD_QTY'
        value         = ls_upd_qty ).

    ob_interface_upd->get_data(
      EXPORTING
        im_vbeln   =  space ).

    cl_abap_testdouble=>configure_call( ob_interface_upd )->ignore_parameter( 'IM_UPD_DATA' )->returning( value = 'X' ).
*
    ob_interface_upd->set_data(
      EXPORTING
        im_upd_data = VALUE #( ) ).

*    cl_abap_testdouble=>configure_call( ob_interface_upd )->returning( value = 'X' ).
*
    ob_interface_upd->set_data(
      EXPORTING
        im_upd_data = VALUE #( ) ).

    "When
    f_cut->test_double_code(
      EXPORTING
        im_vbeln  =  lv_vbeln                " Update Quantity
      IMPORTING
        ex_result = DATA(lv_act_res)
    ).
*    "Then
    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act              = lv_act_res                                       " Actual value
        msg              = 'status Updated'                         " Description
    ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_mock DEFINITION INHERITING FROM zcl_jay_testdouble.
  PUBLIC SECTION.
    DATA: ls_upd_qty TYPE zsd_upd_qty,
          lv_result  TYPE c.
  PROTECTED SECTION.
    METHODS:get_data_da REDEFINITION,
      update_data_da REDEFINITION.

ENDCLASS.

CLASS lcl_mock IMPLEMENTATION.
  METHOD get_data_da.
    ex_upd_qty = ls_upd_qty.
  ENDMETHOD.
  METHOD update_data_da.
    ex_result = lv_result.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_mock_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PUBLIC SECTION.
  PRIVATE SECTION.
    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup,
      teardown,
      test_mock FOR TESTING.
    DATA: cut TYPE REF TO lcl_mock.

ENDCLASS.
CLASS lcl_mock_test IMPLEMENTATION.
  METHOD class_setup.
  ENDMETHOD.
  METHOD setup.
    CREATE OBJECT cut.
  ENDMETHOD.
  METHOD test_mock.
    DATA: lv_vbeln TYPE vbeln_va.
    cut->lv_result = 'X'.
    cut->ls_upd_qty = VALUE #( vbeln = '11111'
                            posnr = '1111'
                            menge = '5'
                            meins = 'ST' ).
    DATA(result) = cut->mock_call( im_vbeln = lv_vbeln ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  =  result
        exp                  =  'X'
        msg                  =  'Error'
    ).
  ENDMETHOD.
  METHOD teardown.
    FREE:cut.
  ENDMETHOD.
  METHOD class_teardown.
  ENDMETHOD.
ENDCLASS.
