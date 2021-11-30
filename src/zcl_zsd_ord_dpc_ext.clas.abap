class ZCL_ZSD_ORD_DPC_EXT definition
  public
  inheriting from ZCL_ZSD_ORD_DPC
  create public .

public section.
protected section.

  methods HEADERSET_GET_ENTITY
    redefinition .
  methods HEADERSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZSD_ORD_DPC_EXT IMPLEMENTATION.


  METHOD headerset_get_entity.
    DATA: lv_vbeln TYPE vbeln_va.
    IF line_exists( it_key_tab[ name = 'Vbeln' ] ).
      lv_vbeln = it_key_tab[ name = 'Vbeln' ]-value.
      lv_vbeln = |{ lv_vbeln ALPHA = IN }|.
      SELECT SINGLE *
               FROM zsd_soh
               INTO er_entity
              WHERE vbeln = lv_vbeln.
    ENDIF.
  ENDMETHOD.


  METHOD headerset_get_entityset.

    SELECT *
      FROM zsd_soh
     INTO TABLE et_entityset.

  ENDMETHOD.
ENDCLASS.
