*******************************************************************
*   System-defined Include-files.                                 *
*******************************************************************
  INCLUDE lzomm_purchasetop.                 " Global Declarations
  INCLUDE lzomm_purchaseuxx.                 " Function Modules

*******************************************************************
*   User-defined Include-files (if necessary).                    *
*******************************************************************
* INCLUDE LZOMM_PURCHASEF...                 " Subroutines
* INCLUDE LZOMM_PURCHASEO...                 " PBO-Modules
* INCLUDE LZOMM_PURCHASEI...                 " PAI-Modules
* INCLUDE LZOMM_PURCHASEE...                 " Events
* INCLUDE LZOMM_PURCHASEP...                 " Local class implement.
* INCLUDE LZOMM_PURCHASET99.                 " ABAP Unit tests

  CLASS lcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
    PRIVATE SECTION.
      METHODS: call_fm FOR TESTING.
  ENDCLASS.
  CLASS lcl_test IMPLEMENTATION.

    METHOD call_fm.
      DATA: lv_string TYPE char20.
      CALL FUNCTION 'ZSD_SO'
        EXPORTING
          im_vbeln  = ''
        IMPORTING
          ex_string = lv_string.
*
      cl_abap_unit_assert=>assert_equals(
        EXPORTING
          act                  =  lv_string
          exp                  =  'FM Testing '
          msg                  = 'Incorrect Data'
      ).
    ENDMETHOD.
  ENDCLASS.
