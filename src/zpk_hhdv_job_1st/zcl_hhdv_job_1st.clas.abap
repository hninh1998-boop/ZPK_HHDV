CLASS zcl_hhdv_job_1st DEFINITION
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

CLASS zcl_hhdv_job_1st IMPLEMENTATION.

  METHOD if_apj_rt_exec_object~execute.
    "1. Đọc param của job
    LOOP AT it_parameters INTO DATA(ls_param).
      CASE ls_param-selname.
        WHEN 'ID'.
          DATA(lv_id) = ls_param-low.
      ENDCASE.
    ENDLOOP.

    "2. Tính ngày đầu tháng kế tiếp + ngày cuối tháng đang xử lý
    DATA: lv_year             TYPE n LENGTH 4,
          lv_month            TYPE n LENGTH 2,
          lv_next_month_first TYPE d,
          lv_month_end        TYPE d.

    DATA(lv_enddate)   = cl_abap_context_info=>get_system_date( ).
    DATA(lv_startdate) = CONV d( |{ lv_enddate+0(4) }0101| ). "01/01 năm hiện tại

    lv_year  = lv_startdate+0(4).
    lv_month = lv_startdate+4(2).
    IF lv_month = 12.
      lv_year  = lv_year + 1.
      lv_month = 1.
    ELSE.
      lv_month = lv_month + 1.
    ENDIF.
    CONCATENATE lv_year lv_month '01' INTO lv_next_month_first.

    lv_month_end = lv_next_month_first - 1.
    IF lv_month_end > lv_enddate.
      lv_month_end = lv_enddate.
    ENDIF.

    "3. Chạy job cho kỳ hiện tại
    WAIT UP TO 15 SECONDS.

    "4. Ghi log tạm để check đã chạy đúng kỳ nào
    TRY.
        DATA(lo_log) = cl_bali_log=>create( ).
        lo_log->set_header(
          cl_bali_header_setter=>create(
            object      = 'ZJL_HHDV_1ST'
            subobject   = 'ZJL_HHDV_1ST_SUB'
            external_id = CONV cl_bali_header_setter=>ty_external_id( lv_id ) )
        ).
        lo_log->add_item(
          cl_bali_free_text_setter=>create(
            severity = if_bali_constants=>c_severity_status
            text     = |Chạy thành công từ ngày { lv_startdate } đến ngày { lv_month_end }| )
        ).
        cl_bali_log_db=>get_instance( )->save_log(
          log                        = lo_log
          assign_to_current_appl_job = abap_true
        ).
      CATCH cx_bali_runtime.
        "TODO: bỏ qua lỗi log, không làm gãy job chính
    ENDTRY.

    "5. Còn tháng tiếp theo cần xử lý --> tự schedule job kế tiếp, chạy ngay
    IF lv_month_end < lv_enddate.
      DATA: ls_start_info TYPE cl_apj_rt_api=>ty_start_info,
            lt_param      TYPE cl_apj_rt_api=>tt_job_parameter_value,
            lv_jobname    TYPE cl_apj_rt_api=>ty_jobname,
            lv_jobcount   TYPE cl_apj_rt_api=>ty_jobcount.

      ls_start_info-start_immediately = abap_true.

      lt_param = VALUE #(
        ( name = 'ID'    t_value = VALUE #( ( sign = 'I' option = 'EQ' low = lv_id ) ) )
        ( name = 'START' t_value = VALUE #( ( sign = 'I' option = 'EQ' low = lv_next_month_first ) ) )
        ( name = 'END'   t_value = VALUE #( ( sign = 'I' option = 'EQ' low = lv_enddate ) ) )
      ).

      TRY.
          cl_apj_rt_api=>schedule_job(
            EXPORTING
              iv_job_template_name  = 'ZJT_HHDV'
              iv_job_text           = |HHDV { lv_id } - T{ lv_next_month_first+4(2) }/{ lv_next_month_first+0(4) }|
              is_start_info          = ls_start_info
              it_job_parameter_value = lt_param
            IMPORTING
              ev_jobname  = lv_jobname
              ev_jobcount = lv_jobcount
          ).
        CATCH cx_root INTO DATA(lx_error).
          "TODO: log lỗi nếu schedule job kế tiếp thất bại
      ENDTRY.
    ENDIF.
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
    DATA: lv_id(255) VALUE 'ZJOB_HHDV_1ST'.

    TRY.
        NEW zcl_hhdv_job_1st( )->if_apj_rt_exec_object~execute(
            it_parameters = VALUE #(
                ( selname = 'ID'
                  kind = if_apj_dt_exec_object=>select_option
                  sign = 'I'
                  option = 'EQ'
                  low = lv_id )
            )
        ).
      CATCH cx_apj_rt_content.
        "handle exception
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
