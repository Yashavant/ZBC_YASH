*"* use this source file for your ABAP unit test classes
CLASS lcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS: test_po FOR TESTING.
ENDCLASS.

CLASS lcl_test IMPLEMENTATION.

  METHOD test_po.

    TEST-INJECTION  call_fn.

    END-TEST-INJECTION.

    DATA: ls_ekko TYPE zbapi_po_header.
    DATA(ob_po) = NEW zbc_utest_fm( ).
    ob_po->get_po(
      EXPORTING
        i_po   =  '4500000000'
      IMPORTING
        e_ekko = ls_ekko
    ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  =  ls_ekko-ebeln
        exp                  =  '4500000000'
        msg                  =  'Invalid PO'    ).
  ENDMETHOD.

ENDCLASS.
