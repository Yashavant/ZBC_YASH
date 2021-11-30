*&---------------------------------------------------------------------*
*& Report ZBC_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_upload.

TYPES: BEGIN OF ty_t,
         a TYPE makt-maktx,
         b TYPE makt-maktx,
       END OF ty_t.
DATA: it_t TYPE STANDARD TABLE OF ty_t.
DATA: str TYPE  string.
str = 'H:\Book1.xls'.

*CALL FUNCTION 'GUI_UPLOAD'
*  EXPORTING
*    filename = str
**   FILETYPE = 'ASC'
*   HAS_FIELD_SEPARATOR           = 'X'
**   HEADER_LENGTH                 = 0
**   READ_BY_LINE                  = 'X'
**   DAT_MODE = ' '
**   CODEPAGE = ' '
**   IGNORE_CERR                   = ABAP_TRUE
**   REPLACEMENT                   = '#'
**   CHECK_BOM                     = ' '
**   VIRUS_SCAN_PROFILE            =
**   NO_AUTH_CHECK                 = ' '
** IMPORTING
**   FILELENGTH                    =
**   HEADER   =
*  TABLES
*    data_tab = it_t
** CHANGING
**   ISSCANPERFORMED               = ' '
** EXCEPTIONS
**   FILE_OPEN_ERROR               = 1
**   FILE_READ_ERROR               = 2
**   NO_BATCH = 3
**   GUI_REFUSE_FILETRANSFER       = 4
**   INVALID_TYPE                  = 5
**   NO_AUTHORITY                  = 6
**   UNKNOWN_ERROR                 = 7
**   BAD_DATA_FORMAT               = 8
**   HEADER_NOT_ALLOWED            = 9
**   SEPARATOR_NOT_ALLOWED         = 10
**   HEADER_TOO_LONG               = 11
**   UNKNOWN_DP_ERROR              = 12
**   ACCESS_DENIED                 = 13
**   DP_OUT_OF_MEMORY              = 14
**   DISK_FULL                     = 15
**   DP_TIMEOUT                    = 16
**   OTHERS   = 17
*  .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.

*START-OF-SELECTION.
*DATA: v_str  TYPE rlgrap-filename,
*      l_test TYPE truxs_t_text_data.
*v_str = 'H:\YY.XLS'.
*CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
*  EXPORTING
*   I_FIELD_SEPERATOR    = 'X'
**   I_LINE_HEADER        =
*    i_tab_raw_data       = l_test
*    i_filename           = v_str
*  TABLES
*    i_tab_converted_data = it_t
*  EXCEPTIONS
*    conversion_failed    = 1
*    OTHERS               = 2.
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.

PARAMETERS: p_file TYPE  rlgrap-filename.
PARAMETERS: p_head TYPE char01 DEFAULT 'X'.

TYPES: BEGIN OF t_datatab,
      col1(30)    TYPE c,
      col2(30)    TYPE c,
      col3(30)    TYPE c,
      END OF t_datatab.
DATA: it_datatab TYPE STANDARD TABLE OF t_datatab,
      wa_datatab TYPE t_datatab.

DATA: it_raw TYPE truxs_t_text_data.

* At selection screen
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      field_name = 'P_FILE'
    IMPORTING
      file_name  = p_file.

START-OF-SELECTION.
  " Convert Excel Data to SAP internal Table Data
  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
*     I_FIELD_SEPERATOR        =
      i_line_header            =  p_head
      i_tab_raw_data           =  it_raw       " WORK TABLE
      i_filename               =  p_file
    TABLES
      i_tab_converted_data     = it_datatab[]  "ACTUAL DATA
   EXCEPTIONS
      conversion_failed        = 1
      OTHERS                   = 2.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


***********************************************************************
* END-OF-SELECTION.
END-OF-SELECTION.
  " For sample, Excel Data transfered to internal table is displayed with write
  LOOP AT it_datatab INTO wa_datatab.
    WRITE:/ wa_datatab-col1,
            wa_datatab-col2,
            wa_datatab-col3.
  ENDLOOP.
