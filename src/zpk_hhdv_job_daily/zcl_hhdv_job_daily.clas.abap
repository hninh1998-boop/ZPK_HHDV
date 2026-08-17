CLASS zcl_hhdv_job_daily DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_HHDV_JOB_DAILY IMPLEMENTATION.


  METHOD if_apj_rt_exec_object~execute.
    DATA: lv_enddate   TYPE d,
          lv_startdate TYPE d,
          lv_id        TYPE c LENGTH 255.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Prepare
    "1. Lấy params
    CLEAR: lv_id,
           lv_enddate,
           lv_startdate.
    READ TABLE it_parameters INTO DATA(ls_param) INDEX 1.
    CHECK sy-subrc = 0.
    lv_id = ls_param-low.
    lv_enddate = cl_abap_context_info=>get_system_date( ).
    lv_startdate = lv_enddate - 2.

    "2. khai báo log
    TRY.
        DATA(lo_log) = cl_bali_log=>create( ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.

    TRY.
        lo_log->set_header( header = cl_bali_header_setter=>create(
                                       object      = 'ZJL_HHDV_DAILY'
                                       subobject   = 'ZJL_HHDV_DAILY_SUB'
                                       external_id = CONV cl_bali_header_setter=>ty_external_id( lv_id )
                                     ) ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Main
    "1. Get data config
    SELECT FROM ztb_auth_hhdv
    FIELDS *
    INTO TABLE @DATA(lt_config).

    "2. Chạy API append data vào bảng Z
    LOOP AT lt_config INTO DATA(ls_config).
      zcl_hhdv_api=>main(
        EXPORTING
          iv_username        = CONV string( ls_config-username )
          iv_password        = CONV string( ls_config-password )
          iv_suppliertaxcode = CONV string( ls_config-supplier_tax_code )
          iv_companycode     = CONV string( ls_config-company_code )
          iv_startdate       = lv_startdate
          iv_enddate         = lv_enddate
          iv_is_job          = 'X'
        IMPORTING
          ev_rc              = DATA(lv_rc)
          ev_response        = DATA(lv_response)
          ev_count_success   = DATA(lv_count_success)
          ev_total_rows       = DATA(lv_total_rows)
        CHANGING
          co_log             = lo_log
      ).

      "3. Ghi log cho từng company code
      IF lv_total_rows <> 0.
        TRY.
            lo_log->add_item(
              cl_bali_free_text_setter=>create(
                severity = if_bali_constants=>c_severity_information
                text     = |CC { ls_config-company_code }: Chạy thành công { lv_count_success }/{ lv_total_rows } data| )
            ).
          CATCH cx_bali_runtime.
            "handle exception
        ENDTRY.
      ENDIF.

      CLEAR: lv_total_rows,
             lv_count_success.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Result
    "1. Lưu log sau khi chạy xong
    TRY.
        lo_log->add_item(
          cl_bali_free_text_setter=>create(
            severity = if_bali_constants=>c_severity_information
            text     = |Chạy job từ ngày { lv_startdate } đến ngày { lv_enddate }| )
        ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.

    TRY.
        cl_bali_log_db=>get_instance( )->save_log(
          log                        = lo_log
          assign_to_current_appl_job = abap_true
        ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.
  ENDMETHOD.


  METHOD if_apj_dt_exec_object~get_parameters.
    et_parameter_def = VALUE #(
      ( selname = 'ID'
        kind = if_apj_dt_exec_object=>select_option
        datatype = 'C'
        length = 50
        param_text = 'ID'
        changeable_ind = abap_true )
    ).
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    "Test
    DATA: lv_id(255) VALUE 'FA163EF80C7E1FD192F2F2093EFE6B60'.

    "Build it_parameters, append từng company code thành 1 dòng riêng
    DATA(lt_parameters) = VALUE if_apj_rt_exec_object=>tt_templ_val(
        ( selname = 'ID'    kind = if_apj_dt_exec_object=>select_option sign = 'I' option = 'EQ' low = lv_id )
    ).
    TRY.
        NEW zcl_hhdv_job_daily( )->if_apj_rt_exec_object~execute(
            it_parameters = lt_parameters
        ).
      CATCH cx_apj_rt_content.
        "handle exception
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
