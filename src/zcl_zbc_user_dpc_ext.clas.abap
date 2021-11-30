class ZCL_ZBC_USER_DPC_EXT definition
  public
  inheriting from ZCL_ZBC_USER_DPC
  create public .

public section.
protected section.

  methods USERSET_GET_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZBC_USER_DPC_EXT IMPLEMENTATION.


  METHOD userset_get_entity.
    DATA: ls_user TYPE rsyst.
    IF line_exists( it_key_tab[ name = 'Bname' ] ) AND
       line_exists( it_key_tab[ name = 'Pass' ] ).
      DATA(lv_user) = it_key_tab[ name = 'Bname' ]-value.
      DATA(lv_pass) = it_key_tab[ name = 'Pass' ]-value.

      SELECT SINGLE bname
               FROM usr02
               INTO @DATA(lv_bname)
              WHERE bname = @lv_user.
      IF sy-subrc EQ 0.
        ls_user-bname = lv_user.
        ls_user-bcode = lv_pass.
*        CALL FUNCTION 'SUSR_LOGIN_CHECK_RFC'
*          EXPORTING
*            bname                     = ls_user-bname
*            password                  = ls_user-bcode
*          EXCEPTIONS
*            wait                      = 1
*            user_locked               = 2
*            user_not_active           = 3
*            password_expired          = 4
*            wrong_password            = 5
*            no_check_for_this_user    = 6
*            password_attempts_limited = 7
*            internal_error            = 8
*            OTHERS                    = 9.
        IF sy-subrc <> 0.
          er_entity-flag = abap_false.
          er_entity-bname = lv_user.
          DATA lv_msg TYPE bapi_msg.

          DATA: ls_return TYPE bapiret1.
          CALL FUNCTION 'BALW_BAPIRETURN_GET1'
            EXPORTING
              type       = sy-msgty
              cl         = sy-msgid
              number     = sy-msgno
              par1       = sy-msgv1
              par2       = sy-msgv2
              par3       = sy-msgv3
              par4       = sy-msgv4
            IMPORTING
              bapireturn = ls_return
            EXCEPTIONS
              OTHERS     = 0.
          lv_msg = ls_return-message.
          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
            EXPORTING
              textid  = /iwbep/cx_mgw_busi_exception=>business_error
              message = lv_msg.
        ELSE.
          er_entity-flag = abap_true.
          er_entity-bname = lv_user.
        ENDIF.
      ELSE.
        er_entity-flag = abap_false.
        er_entity-bname = lv_user.
      ENDIF. "IF sy-subrc eq 0.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
