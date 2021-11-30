class ZCL_BC_TEST_SEAMS definition
  public
  final
  create public .

public section.

  methods CHANGE_PRICE
    importing
      !CARRID type SFLIGHT-CARRID
      !CONNID type SFLIGHT-CONNID
      !FLDATE type SFLIGHT-FLDATE
      !FACTOR type I
    exporting
      value(NEW_PRICE) type SFLIGHT-PRICE .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BC_TEST_SEAMS IMPLEMENTATION.


  METHOD CHANGE_PRICE.
    DATA wa TYPE sflight.
    TEST-SEAM selection.
      SELECT SINGLE *
             FROM sflight
             INTO wa
             WHERE carrid = carrid AND
                   connid = connid AND
                   fldate = fldate.
    END-TEST-SEAM.
    IF sy-subrc <> 0.
      new_price = -1.
      RETURN.
    ENDIF.
    wa-price = wa-price * factor / 100.
    TEST-SEAM modification.
      MODIFY sflight FROM wa.
    END-TEST-SEAM.
    IF sy-subrc = 0.
      new_price = wa-price.
    ELSE.
      new_price = -2.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
