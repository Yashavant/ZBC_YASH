class ZCL_BC_JAY_ASIST definition
  public
  inheriting from CL_WD_COMPONENT_ASSISTANCE
  create public .

public section.

  types:
    tr_matnr TYPE RANGE OF matnr .
  types:
    tr_werks TYPE RANGE OF werks_d .

  class-data R_MATNR type TR_MATNR .
  class-data R_WERKS type TR_WERKS .
protected section.
private section.
ENDCLASS.



CLASS ZCL_BC_JAY_ASIST IMPLEMENTATION.
ENDCLASS.
