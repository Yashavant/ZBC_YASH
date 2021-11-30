*"* use this source file for your ABAP unit test classes

CLASS lcl_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>lcl_Test
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>ZCL_JAY_UTEST
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE>X
*?</GENERATE_FIXTURE>
*?<GENERATE_CLASS_FIXTURE>X
*?</GENERATE_CLASS_FIXTURE>
*?<GENERATE_INVOCATION>X
*?</GENERATE_INVOCATION>
*?<GENERATE_ASSERT_EQUAL>X
*?</GENERATE_ASSERT_EQUAL>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO zcl_jay_utest.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: add FOR TESTING.
    METHODS: add1 FOR TESTING.
ENDCLASS.       "lcl_Test


CLASS lcl_test IMPLEMENTATION.

  METHOD class_setup.



  ENDMETHOD.


  METHOD class_teardown.



  ENDMETHOD.


  METHOD setup.


    CREATE OBJECT f_cut.
  ENDMETHOD.


  METHOD teardown.



  ENDMETHOD.


  METHOD add.

    DATA i_1 TYPE i VALUE 2.
    DATA i_2 TYPE i VALUE 3.
    DATA i_r TYPE i.
    DATA i_exp TYPE i VALUE 5.

    f_cut->add(
      EXPORTING
        i_1 = i_1
        i_2 = i_2
     IMPORTING
       i_r = i_r
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = i_r
      exp   = i_exp          "<--- please adapt expected value
      msg   = 'Invalid Add'
*     level =
    ).
  ENDMETHOD.

  METHOD add1.

    DATA i_1 TYPE i VALUE 3.
    DATA i_2 TYPE i VALUE 2.
    DATA i_r TYPE i.
    DATA i_exp TYPE i VALUE 5.

    f_cut->add(
      EXPORTING
        i_1 = i_1
        i_2 = i_2
     IMPORTING
       i_r = i_r
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = i_r
      exp   = i_exp          "<--- please adapt expected value
      msg   = 'Invalid Add'
*     level =
    ).
  ENDMETHOD.



ENDCLASS.
