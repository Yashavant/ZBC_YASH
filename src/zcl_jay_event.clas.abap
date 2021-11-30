class ZCL_JAY_EVENT definition
  public
  final
  create public .

public section.

  data OB_MAT type ref to ZCL_JAY_EVENT .

  events NO_MATNR .

  methods CONSTRUCTOR .
  methods GET_MATERIAL
    importing
      !IM_MATNR type MATNR .
  methods CALL_EVENT
    for event NO_MATNR of ZCL_JAY_EVENT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_JAY_EVENT IMPLEMENTATION.


  method CALL_EVENT.
    WRITE:'No Material entered'.
  endmethod.


  METHOD constructor.
    CREATE OBJECT ob_mat.
*    SET HANDLER call_event FOR ob_mat.
  ENDMETHOD.


  METHOD get_material.
    IF im_matnr IS INITIAL.
      RAISE EVENT no_matnr.
    ELSE.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
