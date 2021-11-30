*&---------------------------------------------------------------------*
*& Report zbc_utest
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_utest.
INTERFACE if_div.
  METHODS:div IMPORTING i_1 TYPE i i_2 TYPE i EXPORTING o_r TYPE f.
ENDINTERFACE.

INTERFACE if_sum.
  METHODS:add IMPORTING i_1 TYPE i i_2 TYPE i EXPORTING o_r TYPE f.
ENDINTERFACE.

CLASS lcl_div DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_div.
ENDCLASS.

CLASS lcl_div IMPLEMENTATION.

  METHOD if_div~div.
    o_r = i_1 / i_2.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_add DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_sum.
ENDCLASS.

CLASS lcl_add IMPLEMENTATION.

  METHOD if_sum~add.
    DATA(o_div) =  NEW lcl_div( ).
    o_div->if_div~div(
      EXPORTING
        i_1 = i_1
        i_2 =  i_2
      IMPORTING
        o_r = DATA(res)
    ).
    o_r = res + i_1.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    METHODS: div FOR TESTING.
  PRIVATE SECTION.

    METHODS add FOR TESTING.
ENDCLASS.

CLASS lcl_test IMPLEMENTATION.

  METHOD div.

    DATA(o_div) = NEW lcl_div( ).
    o_div->if_div~div(
      EXPORTING
        i_1 = 10
        i_2 = 5
      IMPORTING
        o_r =  DATA(res)
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = res
        exp                  = 2
        msg                  = 'Invalid Output'
    ).
  ENDMETHOD.
  METHOD add.
    DATA(o_add) = NEW lcl_add( ).
    o_add->if_sum~add(
      EXPORTING
        i_1 = 10
        i_2 = 2
      IMPORTING
        o_r = DATA(res)
    ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = res
        exp                  = 15
        msg                  = 'Invalid Output'
    ).
  ENDMETHOD..
ENDCLASS.
