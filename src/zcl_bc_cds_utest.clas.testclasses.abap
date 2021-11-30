*"* use this source file for your ABAP unit test classes
CLASS i_asalesorddocflwcustsale
 DEFINITION FINAL FOR TESTING
                    DURATION SHORT
                    RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    CLASS-DATA: environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS: class_setup,
      class_teardown.

    METHODS: setup,
      dis_so_cust_data FOR TESTING RAISING cx_static_check.

    DATA: vbap       TYPE STANDARD TABLE OF vbap WITH EMPTY KEY,
          vbak       TYPE STANDARD TABLE OF vbak WITH EMPTY KEY,
          knvv       TYPE STANDARD TABLE OF knvv WITH EMPTY KEY,
          vbfa       TYPE STANDARD TABLE OF vbfa WITH EMPTY KEY,
          likp       TYPE STANDARD TABLE OF likp WITH EMPTY KEY,
          tvv5t      TYPE STANDARD TABLE OF tvv5t WITH EMPTY KEY.
ENDCLASS.

CLASS i_asalesorddocflwcustsale IMPLEMENTATION.

  METHOD class_setup.
    " Instantiate the CUT and the inject the dependent on components( DOC )
    " This will create the doubles as well for the DOCs
    environment = cl_cds_test_environment=>create( i_for_entity = 'ZBC_TEST_CDS_U'
                            i_dependency_list = VALUE #(
                                                         ( name = 'VBAP'                       type = 'TABLE'    )
                                                         ( name = 'VBAK'                       type = 'TABLE'    )
                                                         ( name = 'KNVV'                       type = 'TABLE'    )
                                                         ( name = 'VBFA'                       type = 'TABLE'    )
                                                         ( name = 'LIKP'                       type = 'TABLE'    )
                                                         ( name = 'TVV5T'                      type = 'TABLE'    )
                                                       ) ).

  ENDMETHOD.

  METHOD class_teardown.
    " Iterate over the double list and remove all
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    "Clean all the data in the doubles (Depenedent on components)
    environment->clear_doubles( ).
  ENDMETHOD.
  METHOD dis_so_cust_data.

    " Populate the data in the double stubs
    vbap = VALUE #( ( vbeln = '1000000258' posnr = '000010' ) ).

    environment->insert_test_data( i_data = vbap ).

    vbak = VALUE #( ( vbeln = '1000000258' kunnr = '0000000104' vkorg = '2010'  vtweg = '10' spart ='10' kvgr5 = 'A15' auart  = 'ZA01' ) ).

    environment->insert_test_data( i_data = vbak ).

    knvv = VALUE #( ( kunnr = '0000000104' vkorg = '2010'  vtweg = '10' spart ='10' kvgr5 = 'A15' kvgr1 = 'Z01' ) ).

    environment->insert_test_data( i_data = knvv ).

    vbfa = VALUE #( ( vbelv = '1000000258' posnv = '000010'  vbtyp_n = 'J' vbeln = '2000000283' posnn = '000010' ) ).

    environment->insert_test_data( i_data = vbfa ).

    likp = VALUE #( ( vbeln = '2000000283' podat ='00000000' ) ).

    environment->insert_test_data( i_data = likp ).

    tvv5t = VALUE #( ( kvgr5 = 'A15' spras = 'E' bezei = 'TEST Purpose' ) ).

    environment->insert_test_data( i_data = tvv5t ).



    " Execute the CUT which in turn will fetch the data from the doubles and
    " then validate the output
    SELECT * FROM ZBC_TEST_CDS_U
             INTO TABLE @DATA(lt_so_cust_data).

    cl_abap_unit_assert=>assert_equals( act = lines( lt_so_cust_data )
                                        exp = 1 ).

  ENDMETHOD.



ENDCLASS.
