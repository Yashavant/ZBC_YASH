*&---------------------------------------------------------------------*
*& Report zbc_utest_fm
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_utest_fm.

CLASS lcl_cds DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    METHODS: test_cds FOR TESTING.
ENDCLASS.

CLASS lcl_cds IMPLEMENTATION.

  METHOD test_cds.

    DATA: lt_kna1 TYPE STANDARD TABLE OF zsd_cust.
    SELECT kunnr,
          name1
          FROM zsd_cust
          INTO TABLE @DATA(lt_cust).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_cust
        exp                  = lt_cust
        msg                  = 'Invalid Customers'
    ).
  ENDMETHOD.

ENDCLASS.
