class ZCL_JAY_UTEST definition
  public
  final
  create public .

public section.

  methods ADD
    importing
      !I_1 type I
      !I_2 type I
    exporting
      !I_R type I .
protected section.
private section.
ENDCLASS.



CLASS ZCL_JAY_UTEST IMPLEMENTATION.


  METHOD add.
    IF i_1 > i_2.
      i_r = i_1 + i_2.
    ELSE.
      i_r = i_1 + i_2.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
