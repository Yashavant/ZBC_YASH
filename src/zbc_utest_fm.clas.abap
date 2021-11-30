class ZBC_UTEST_FM definition
  public
  final
  create public .

public section.

  methods GET_PO
    importing
      !I_PO type ZBAPI_PO_HEADER-EBELN
    exporting
      !E_EKKO type ZBAPI_PO_HEADER .
protected section.
private section.
ENDCLASS.



CLASS ZBC_UTEST_FM IMPLEMENTATION.


  METHOD get_po.
    DATA: lt_ekpo TYPE STANDARD TABLE OF zbapi_po_item.
    TEST-SEAM call_fn.
      CALL FUNCTION 'ZBAPI_PO_DETAILS'
        EXPORTING
          i_ebeln = i_po
        IMPORTING
          o_ekko  = e_ekko
*         return  =
        TABLES
          o_ekpo  = lt_ekpo.
    END-TEST-SEAM.
  ENDMETHOD.
ENDCLASS.
