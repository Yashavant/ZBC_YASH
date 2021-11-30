class ZCL_ZSD_ORDER_DPC_EXT definition
  public
  inheriting from ZCL_ZSD_ORDER_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
protected section.

  methods VBAPSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZSD_ORDER_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.
    IF iv_action_name = 'OrderFunction'.
      IF line_exists( it_parameter[ name = 'Werks' ] ).
        IF it_parameter[ name = 'Werks' ]-value IS NOT INITIAL.
          DATA(lv_werks) = it_parameter[ name = 'Werks' ]-value.
          SELECT SINGLE werks
                   FROM t001w
                   INTO @DATA(lv_tmp)
                  WHERE werks = @lv_werks.
          IF sy-subrc EQ 0.
            SELECT *
              FROM vbap
              INTO TABLE @DATA(lt_vbap)
              WHERE werks = @lv_werks.
          ELSE.
            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                textid  = /iwbep/cx_mgw_busi_exception=>business_error
                message = 'Input is not valid'.
          ENDIF."IF sy-subrc eq 0.

        ENDIF."IF IT_PARAMETER[ name = 'Werks' ]-value IS NOT INITIAL.
      ENDIF."IF line_exists( IT_PARAMETER[ name = 'Werks' ] ).

      IF lt_vbap IS INITIAL.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = 'No Data found'.
      ENDIF."IF lt_vbap IS INITIAL.

      copy_data_to_ref(
        EXPORTING
          is_data = lt_vbap
        CHANGING
          cr_data = er_data ).
    ENDIF.

  ENDMETHOD.


  METHOD vbapset_get_entityset.
SELECT *
  FROM vbap
  INTO TABLE et_entityset.

  ENDMETHOD.
ENDCLASS.
