*&---------------------------------------------------------------------*
*& Report ZBC_TEST
*&---------------------------------------------------------------------*
REPORT zbc_test.

SELECT *
  FROM zsd_upd_qty
  INTO TABLE @DATA(lt_test)
  UP TO 10 ROWS.

DATA: lt_test1 TYPE STANDARD TABLE OF zsd_upd_qty.

LOOP AT lt_test INTO DATA(ls_test).

  APPEND VALUE #( vbeln = ls_test-vbeln posnr = ls_test-posnr ) TO lt_test1.

ENDLOOP.

SELECT  COUNT( vbeln ) AS vbeln ,
       erdat,
       kunnr
  FROM vbak
  GROUP BY erdat ,kunnr
    INTO TABLE @DATA(lt_vbak).


SELECT lgnum,
       lqnum,
       matnr,
       werks,
       lgtyp,
      COUNT( verme ) AS verme
  FROM lqua
  GROUP BY lgnum ,lqnum, matnr, werks, lgtyp
    INTO TABLE @DATA(lt_lqua).

*INSERT ZSD_UPD_QTY FROM ( SELECT
*k~VBELN,
*POSNR,
*kwmeng,
*MEINS FROM vbap as p INNER JOIN vbak as k on p~vbeln = k~vbeln WHERE k~vbeln = '0000000024'   ).
*
*IF sy-subrc eq 0.
*COMMIT WORK.
*ENDIF.


*WRITE: /'TEST' , 10 'TEST1',20 'TEST2',30 'TEST3' , 40 'TEST4'.
*TYPES: BEGIN OF ty_vbap,
*      vbeln TYPE vbeln_va,
*     posnr TYPE posnr,
*     item TYPE c LENGTH 70,
*  END OF ty_vbap.
*
*DATA: lt_data TYPE STANDARD TABLE OF ty_vbap.
*
*SELECT vbeln,
*       posnr,
*  concat( vbeln , posnr ) AS item
*  FROM vbap INTO TABLE @lt_data
*  UP TO 10 ROWS.
*
*IF lt_data IS NOT INITIAL.
*SELECT *
*  FROM stxh
*  INTO TABLE @DATA(lt_stxh)
*  FOR ALL ENTRIES IN @lt_data
*  WHERE tdname = @lt_data-item.
*ENDIF.


*IF lt_stxh IS NOT INITIAL.
*
*ENDIF.


*CLASS lcl_main DEFINITION.
*  PUBLIC SECTION.
*    TYPES: BEGIN OF ty_mat,
*             matnr TYPE matnr,
*             werks TYPE werks_d,
*           END OF ty_mat.
*    DATA: li_find TYPE STANDARD TABLE OF ty_mat.
*    TYPES: tt_mat TYPE STANDARD TABLE OF ty_mat.
*    METHODS: test_matnr_werks CHANGING li_test TYPE tt_mat.
*ENDCLASS. "lcl_main
*
*CLASS lcl_main IMPLEMENTATION.
*  METHOD test_matnr_werks.
*    SELECT matnr
*           werks
*      FROM marc
*      INTO TABLE li_test.
*  ENDMETHOD."test_matnr_werks
*ENDCLASS."lcl_main.
*
*CLASS lcl_test DEFINITION FOR TESTING "#AU Risk_Level Harmless
*                               "#AU Duration Short
*  .
*  PUBLIC SECTION.
*    METHODS: test_matnr_werks FOR TESTING.
*ENDCLASS. "lcl_test
*
*CLASS lcl_test IMPLEMENTATION
*  .
*  METHOD TEST_MATNR_WERKS.
*    DATA(o_main) = new lcl_main( ).
*        TYPES: BEGIN OF ty_mat,
*             matnr TYPE matnr,
*             werks TYPE werks_d,
*           END OF ty_mat.
*    DATA: li_find TYPE STANDARD TABLE OF ty_mat.
*    data: li_mat TYPE STANDARD TABLE OF ty_mat.
*o_main->test_matnr_werks(
*  CHANGING
*    li_test = li_find ).
*
*DATA: ls_mat TYPE ty_mat.
*
*ls_mat-matnr = 'TEST1'.
*ls_mat-werks = '0001'.
*APPEND ls_mat to li_mat.
*
*cl_aunit_assert=>assert_equals(
*  EXPORTING
*    exp                  = li_find
*    act                  = li_find
*    msg                  = 'Incorrect Data' ).
*    ENDMETHOD. "TEST_MATNR_WERKS
*ENDCLASS. "lcl_test
*
*
*CLASS lcl_a DEFINITION.
*  PRIVATE SECTION.
*
*    METHODS abc.
*ENDCLASS.
*
*CLASS lcl_a IMPLEMENTATION.
*method abc.
*ENDMETHOD.
*ENDCLASS.
*
*INTERFACE if_test.
*METHODs:test1,
*        test2,
*      test3.
*ENDINTERFACE.
*
*
*
*CLASS lcl_main1 DEFINITION.
*PUBLIC SECTION.
*INTERFACES if_test.
*ENDCLASS.
*
*CLASS lcl_main1 IMPLEMENTATION.
*
*  METHOD if_test~test1.
*    DATA: gd_i TYPE string.
* gd_i = 'test'.
*  ENDMETHOD.
*
*  METHOD if_test~test2.
*
*  ENDMETHOD.
*    METHOD if_test~test3.
*
*  ENDMETHOD.
*
*ENDCLASS.

*DATA: ls_vbap TYPE vbap.
*PARAMETERS: p_i TYPE vbap-vbeln.
*IF ls_vbap IS INITIAL.
*  MESSAGE 'Error in report' TYPE 'E'.
*ENDIF.
