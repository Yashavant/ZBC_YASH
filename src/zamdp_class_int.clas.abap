CLASS zamdp_class_int DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:BEGIN OF ty_order,
            mandt          TYPE mandt,
            reference      TYPE referenz,
            effective_date TYPE dats,
          END OF ty_order.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS: get_interest_rate FOR TABLE FUNCTION zamdp_int.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zamdp_class_int IMPLEMENTATION.
  METHOD get_interest_rate BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING t056p.
    et_conv_date = select mandt,
                     referenz as reference,
                     to_nvarchar( 99999999 - datab ) as effective_date
                     FROM t056p
                     WHERE mandt = :p_clnt;
   RETURN SELECT  mandt, reference, MAX ( effective_date) as effective_date
   FROM :et_conv_date
   WHERE mandt = :p_clnt
     AND effective_date <= :p_keydate
     GROUP BY mandt, reference;
  ENDMETHOD.

ENDCLASS.
