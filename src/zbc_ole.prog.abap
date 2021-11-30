*&---------------------------------------------------------------------*
*& Report ZBC_OLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ole.

SELECT *
  FROM vbak
  INTO TABLE @DATA(lt_vbak).
**TYPE-POOLS:ole2.
***include ole2incl.
**
**DATA:  lo_application   TYPE  ole2_object,
**lo_workbook      TYPE  ole2_object,
**lo_workbooks     TYPE  ole2_object,
**lo_range         TYPE  ole2_object,
**lo_worksheet     TYPE  ole2_object,
**lo_worksheets    TYPE  ole2_object,
**lo_column        TYPE  ole2_object,
**lo_row           TYPE  ole2_object,
**lo_cell          TYPE  ole2_object,
**lo_font          TYPE ole2_object.
**DATA: lo_cellstart      TYPE ole2_object,
**lo_cellend        TYPE ole2_object,
**lo_selection      TYPE ole2_object,
**lo_validation     TYPE ole2_object.
**
**DATA: lv_selected_folder TYPE string,
**lv_complete_path   TYPE char256,
**lv_titulo          TYPE string.
**
**CALL METHOD cl_gui_frontend_services=>directory_browse
**EXPORTING
**window_title    = lv_titulo
**initial_folder  = 'D:\'
**CHANGING
**selected_folder = lv_selected_folder
**EXCEPTIONS
**cntl_error      = 1
**error_no_gui    = 2
**OTHERS          = 3.
**CHECK NOT lv_selected_folder IS INITIAL.
**
**CREATE OBJECT lo_application 'Excel.Application'.
**CALL METHOD OF lo_application 'Workbooks' = lo_workbooks.
**CALL METHOD OF lo_workbooks 'Add' = lo_workbook.
**SET PROPERTY OF lo_application 'Visible' = 0.
**GET PROPERTY OF lo_application 'ACTIVESHEET' = lo_worksheet.
*** ———-
*** —- PASTE HERE THE CODE
*** ———-
*** Select a cell and set a Value
**CALL METHOD OF lo_worksheet 'Cells' = lo_cell
**EXPORTING
**#1 = 1  "Row
**#2 = 3. "Column
**SET PROPERTY OF lo_cell 'Value' = 'Hello World'.
**
*** * Change Colour, Bold, Underline and Italics Font and Size
**CALL METHOD OF lo_cell 'FONT' = lo_font.
**SET PROPERTY OF lo_font 'Name' = 'Arial'.
**SET PROPERTY OF lo_font 'Size' = 15.
**
**SET PROPERTY OF lo_font 'Color' = -16776961.
**SET PROPERTY OF lo_font 'TintAndShade' = 0.
**
**SET PROPERTY OF lo_font 'Bold' = 1.
**SET PROPERTY OF lo_font 'Italic' = 1.
**SET PROPERTY OF lo_font 'Underline' = 2. "xlUnderlineStyleSingle
**
**DATA: lo_interior TYPE ole2_object.
**CALL METHOD OF lo_cell 'Interior' = lo_interior.
**SET PROPERTY OF lo_interior 'Color' = 15773696.
**
*** Add Borders
**
**  DATA: lo_borders TYPE ole2_object.
**CALL METHOD OF lo_worksheet 'Cells' = lo_cell
**EXPORTING
**#1 = 3  "Row
**#2 = 4. "Column
**
**CALL METHOD OF lo_cell 'Borders' = lo_borders EXPORTING #1 = '7'. "xlEdgeLeft
**SET PROPERTY OF lo_borders 'LineStyle' = '1'. "xlContinuous
**
**  CALL METHOD OF lo_cell 'Borders' = lo_borders EXPORTING #1 = '8'. "xlEdgeTop
**SET PROPERTY OF lo_borders 'LineStyle' = '1'. "xlContinuous
**
**
**  CALL METHOD OF lo_cell 'Borders' = lo_borders EXPORTING #1 = '9'. "xlEdgeBottom
**SET PROPERTY OF lo_borders 'LineStyle' = '1'. "xlContinuous
**
**
**  CALL METHOD OF lo_cell 'Borders' = lo_borders EXPORTING #1 = '10'. "xlEdgeRight
**SET PROPERTY OF lo_borders 'LineStyle' = '1'. "xlContinuous
**
*** Increase the weight of the border if you want, in this case only for EdgeRight:
**SET PROPERTY OF lo_borders 'WEIGHT' = 4. "xlThic
**
*** Change cell format
**
**CALL METHOD OF lo_worksheet 'Cells' = lo_cell
**EXPORTING
**#1 = 1  "Row
**#2 = 6. "Column
**SET PROPERTY OF lo_cell 'Value' = '1.23'.
**SET PROPERTY OF lo_cell 'NumberFormat' = '0.00'.
**CALL METHOD OF lo_worksheet 'Cells' = lo_cell
**EXPORTING
**#1 = 3  "Row
**#2 = 6. "Column
**SET PROPERTY OF lo_cell 'Value' = '02/01/2012'.
**SET PROPERTY OF lo_cell 'NumberFormat' = 'm/d/yyyy'.
**
**CALL METHOD OF lo_worksheet 'Cells' = lo_cell
**EXPORTING
**#1 = 5  "Row
**#2 = 6. "Column
**SET PROPERTY OF lo_cell 'NumberFormat' = '0.00'.
**SET PROPERTY OF lo_cell 'Value' = '1/2'.
**SET PROPERTY OF lo_cell 'NumberFormat' = '# ?/?'.
**
**** Add validation
***CALL METHOD OF lo_worksheet 'Cells' = lo_cell
***EXPORTING
***#1 = 1  "Row
***#2 = 1. "Column
***CALL METHOD OF lo_cell 'select'.
***CALL METHOD OF lo_application 'selection' = lo_selection.
***CALL METHOD OF lo_selection 'Validation' = lo_validation.
***
***CALL METHOD OF lo_validation 'Add'
***EXPORTING
***#1 = 4 "Type       = xlValidateDate
***#2 = 1 "AlertStype = xlValidAlertStop
***#3 = 1 "Operator   = xlBetween
***#4 = '1/1/2000' "Formula1
***#5 = '1/1/2010'."Formula2
***SET PROPERTY OF lo_validation 'ErrorMessage' = 'Enter a valid date'.
**
*** Create a drop down list with value list in other worksheet
**
**
**DATA: lv_range_name TYPE char24 VALUE 'Values'.
**
*** Go to sheet 2
***CALL METHOD OF lo_application 'Worksheets' = lo_worksheet
***EXPORTING #1 = 2.
***CALL METHOD OF lo_worksheet 'Activate'.
**
*** Fill the cells with the values;
**DATA: lv_row TYPE i,
**lv_cont(4) TYPE n VALUE '0040',
**lv_num(4),
**lv_char.
**DO 7 TIMES.
**ADD 1 TO: lv_cont, lv_row.
**CALL METHOD OF lo_worksheet 'Cells' = lo_cell
**EXPORTING
**#1 = lv_row  "Row
**#2 = 1.       "Column
***   Convert num to ascii
**lv_num = lv_cont.
**lv_char = CL_ABAP_CONV_IN_CE=>uccp( lv_num ).
**SET PROPERTY OF lo_cell 'Value' = lv_char.
**ENDDO.
**
*** Select the range and set a name;
*** 1. Select starting cell
**CALL METHOD OF lo_worksheet 'Cells' = lo_cellstart
**EXPORTING
**#1 = 1
**#2 = 1.
*** 2. Select ending cell
**CALL METHOD OF lo_worksheet 'Cells' = lo_cellend
**EXPORTING
**#1 = lv_cont  "Row
**#2 = 1.
*** Select the Range:
**CALL METHOD OF lo_worksheet 'RANGE' = lo_range
**EXPORTING
**#1 = lo_cellstart
**#2 = lo_cellend.
**CALL METHOD OF lo_range 'select'.
*** Set a name to this Range
**SET PROPERTY OF lo_range 'Name' = lv_range_name.
**
*** Return to sheet 1
**CALL METHOD OF lo_application 'Worksheets' = lo_worksheet
**EXPORTING #1 = 1.
**CALL METHOD OF lo_worksheet 'Activate'.
**
*** Select the cell A1
**CALL METHOD OF lo_worksheet 'Cells' = lo_cell
**EXPORTING
**#1 = 1  "Row
**#2 = 1. "Column
**
**CALL METHOD OF lo_cell 'select'.
**CALL METHOD OF lo_application 'selection' = lo_selection.
**CALL METHOD OF lo_selection 'Validation' = lo_validation.
**CONCATENATE '=' lv_range_name INTO lv_range_name.
**CALL METHOD OF lo_validation 'Add'
**EXPORTING
**#1 = 3 "'xlValidateList'
**#2 = 1 "'xlValidAlertStop'
**#3 = 1 "'xlBetween'
**#4 = lv_range_name.
**
**
**
**
**
**
**CONCATENATE lv_selected_folder 'Test.xls' INTO lv_complete_path.
**
**CALL METHOD OF lo_workbook 'SaveAs'
**EXPORTING
**#1 = lv_complete_path.
**IF sy-subrc EQ 0.
**MESSAGE 'File downloaded successfully' TYPE 'S'.
**ELSE.
**MESSAGE 'Error downloading the file' TYPE 'E'.
**ENDIF.
**
**CALL METHOD OF lo_application 'QUIT'.
**FREE OBJECT lo_worksheet.
**FREE OBJECT lo_workbook.
**FREE OBJECT lo_application.
