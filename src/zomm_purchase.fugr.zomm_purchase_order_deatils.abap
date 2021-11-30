FUNCTION ZOMM_PURCHASE_ORDER_DEATILS.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_EBELN) TYPE  EBELN
*"  EXPORTING
*"     VALUE(O_EKKO) TYPE  EKKO
*"  TABLES
*"      O_EKPO STRUCTURE  EKPO
*"----------------------------------------------------------------------

IF I_EBELN IS NOT INITIAL.
    SELECT SINGLE *
      FROM EKKO
      INTO O_EKKO
     WHERE EBELN = I_EBELN.
    IF O_EKKO IS NOT INITIAL.
      SELECT *
        FROM EKPO
        INTO TABLE O_EKPO
       WHERE EBELN = O_EKKO-EBELN.
    ENDIF. "IF O_EKKO IS NOT INITIAL.
  ENDIF. "IF I_EBELN IS NOT INITIAL.




ENDFUNCTION.
