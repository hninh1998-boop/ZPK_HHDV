CLASS zcl_hhdv_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
    INTERFACES if_oo_adt_classrun .

    TYPES: tt_bukrs TYPE STANDARD TABLE OF bukrs.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS get_params
      IMPORTING
        it_parameters  TYPE if_apj_rt_exec_object=>tt_templ_val
      EXPORTING
        ev_id          TYPE string
        ev_startdate   TYPE d
        ev_enddate     TYPE d
        et_companycode TYPE tt_bukrs.

    CLASS-METHODS get_log
      IMPORTING
        iv_id         TYPE string
      RETURNING
        VALUE(ro_log) TYPE REF TO if_bali_log.

    CLASS-METHODS get_date_next
      IMPORTING
        iv_startdate      TYPE d
        iv_enddate        TYPE d
      EXPORTING
        ev_startdate_next TYPE d
        ev_enddate_next   TYPE d.

    CLASS-METHODS schedule_next_job
      IMPORTING
        iv_id             TYPE string
        iv_startdate_next TYPE d
        iv_enddate_next   TYPE d
        iv_enddate        TYPE d
        it_companycode    TYPE tt_bukrs.

    CLASS-METHODS save_job_log
      IMPORTING
        iv_startdate    TYPE d
        iv_enddate_next TYPE d
      CHANGING
        co_log          TYPE REF TO if_bali_log.

    CLASS-METHODS save_compcode_log
      IMPORTING
        iv_total_rows    TYPE i
        iv_companycode   TYPE bukrs
        iv_count_success TYPE i
      CHANGING
        co_log           TYPE REF TO if_bali_log.

ENDCLASS.

CLASS zcl_hhdv_job IMPLEMENTATION.

  METHOD if_apj_rt_exec_object~execute.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Prepare
    "1. Đọc param của job
    get_params(
      EXPORTING
        it_parameters  = it_parameters
      IMPORTING
        ev_id          = DATA(lv_id)
        ev_startdate   = DATA(lv_startdate)
        ev_enddate     = DATA(lv_enddate)
        et_companycode = DATA(lt_companycode)
    ).

    "2. Tính ngày đầu tháng kế tiếp + ngày cuối tháng đang xử lý
    get_date_next(
      EXPORTING
        iv_startdate      = lv_startdate
        iv_enddate        = lv_enddate
      IMPORTING
        ev_startdate_next = DATA(lv_startdate_next)
        ev_enddate_next   = DATA(lv_enddate_next)
    ).

    "3. Khai báo log để check đã chạy đúng kỳ nào
    DATA(lo_log) = get_log( lv_id ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Main
    "1. Get data config
    SELECT FROM ztb_auth_hhdv
    FIELDS *
    FOR ALL ENTRIES IN @lt_companycode
    WHERE company_code = @lt_companycode-table_line
    INTO TABLE @DATA(lt_config).

    LOOP AT lt_config INTO DATA(ls_config).
      "2. Chạy API append data vào bảng Z
      zcl_hhdv_api=>main(
        EXPORTING
          iv_username        = CONV string( ls_config-username )
          iv_password        = CONV string( ls_config-password )
          iv_suppliertaxcode = CONV string( ls_config-supplier_tax_code )
          iv_companycode     = CONV string( ls_config-company_code )
          iv_startdate       = lv_startdate
          iv_enddate         = lv_enddate_next
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
      save_compcode_log(
        EXPORTING
          iv_total_rows    = lv_total_rows
          iv_companycode   = ls_config-company_code
          iv_count_success = lv_count_success
        CHANGING
          co_log           = lo_log
      ).

      CLEAR: lv_total_rows,
             lv_count_success.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Result
    "1. Lưu log sau khi chạy xong
    save_job_log(
      EXPORTING
        iv_startdate     = lv_startdate
        iv_enddate_next  = lv_enddate_next
      CHANGING
        co_log           = lo_log
    ).

    "2. Còn tháng tiếp theo cần xử lý --> tự schedule job kế tiếp, chạy ngay
    schedule_next_job(
      iv_id             = lv_id
      iv_startdate_next = lv_startdate_next
      iv_enddate_next   = lv_enddate_next
      iv_enddate        = lv_enddate
      it_companycode    = lt_companycode
    ).
  ENDMETHOD.






























  METHOD if_apj_dt_exec_object~get_parameters.
    et_parameter_def = VALUE #(
      ( selname = 'ID'
        kind = if_apj_dt_exec_object=>select_option
        datatype = 'C'
        length = 50
        param_text = 'ID'
        changeable_ind = abap_true )
      ( selname = 'START'
        kind = if_apj_dt_exec_object=>select_option
        datatype = 'D'
        length = 8
        param_text = 'Start Date'
        changeable_ind = abap_true )
      ( selname = 'END'
        kind = if_apj_dt_exec_object=>select_option
        datatype = 'D'
        length = 8
        param_text = 'End Date'
        changeable_ind = abap_true )
      ( selname = 'COMPCODE'
        kind = if_apj_dt_exec_object=>select_option
        datatype = 'C'
        length = 4
        param_text = 'Company Code'
        changeable_ind = abap_true )
    ).
  ENDMETHOD.






























  METHOD if_oo_adt_classrun~main.
    "Test
    DATA: lv_id(255) VALUE 'FA163EF80C7E1FD192F2F2093EFE6B60'.
    "Date
    DATA: lv_start TYPE d VALUE '20260201',
          lv_end   TYPE d VALUE '20260228'.

    "Company Code - danh sách nhiều giá trị để test
    DATA: lv_6710(4) VALUE '6710'.
*    DATA: lv_6720(4) VALUE '6720'.

    DATA: lt_compcode TYPE TABLE OF bukrs.
    APPEND lv_6710 TO lt_compcode.
*    APPEND lv_6720 TO lt_compcode.

    "Build it_parameters, append từng company code thành 1 dòng riêng
    DATA(lt_parameters) = VALUE if_apj_rt_exec_object=>tt_templ_val(
        ( selname = 'ID'    kind = if_apj_dt_exec_object=>select_option sign = 'I' option = 'EQ' low = lv_id )
        ( selname = 'START' kind = if_apj_dt_exec_object=>select_option sign = 'I' option = 'EQ' low = lv_start )
        ( selname = 'END'   kind = if_apj_dt_exec_object=>select_option sign = 'I' option = 'EQ' low = lv_end )
    ).

    LOOP AT lt_compcode INTO DATA(lv_compcode).
      APPEND VALUE #(  selname = 'COMPCODE'
                       kind = if_apj_dt_exec_object=>select_option
                       sign = 'I'
                       option = 'EQ'
                       low = lv_compcode ) TO lt_parameters.
    ENDLOOP.

    TRY.
        NEW zcl_hhdv_job( )->if_apj_rt_exec_object~execute(
            it_parameters = lt_parameters
        ).
      CATCH cx_apj_rt_content.
        "handle exception
    ENDTRY.
  ENDMETHOD.

























  METHOD get_params.
    LOOP AT it_parameters INTO DATA(ls_param).
      CASE ls_param-selname.
        WHEN 'ID'.
          ev_id = ls_param-low.
        WHEN 'START'.
          ev_startdate = ls_param-low.
        WHEN 'END'.
          ev_enddate = ls_param-low.
        WHEN 'COMPCODE'.
          APPEND INITIAL LINE TO et_companycode ASSIGNING FIELD-SYMBOL(<lfs_companycode>).
          <lfs_companycode> = ls_param-low.
      ENDCASE.
    ENDLOOP.

    IF et_companycode IS INITIAL.
      SELECT FROM ztb_auth_hhdv WITH PRIVILEGED ACCESS
      FIELDS company_code
      INTO TABLE @et_companycode.
    ENDIF.
  ENDMETHOD.



























  METHOD get_log.
    TRY.
        ro_log = cl_bali_log=>create( ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.

    TRY.
        ro_log->set_header(
          cl_bali_header_setter=>create(
            object      = 'ZJL_HHDV'
            subobject   = 'ZJL_HHDV_SUB'
            external_id = CONV cl_bali_header_setter=>ty_external_id( iv_id ) )
        ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.
  ENDMETHOD.



























  METHOD get_date_next.
    DATA: lv_year  TYPE n LENGTH 4,
          lv_month TYPE n LENGTH 2.

    lv_year  = iv_startdate+0(4).
    lv_month = iv_startdate+4(2).

    IF lv_month = 12.
      lv_year += 1.
      lv_month = 1.
    ELSE.
      lv_month += 1.
    ENDIF.

    ev_startdate_next = |{ lv_year }{ lv_month }01|.

    ev_enddate_next = ev_startdate_next - 1.
    IF ev_enddate_next > iv_enddate.
      ev_enddate_next = iv_enddate.
    ENDIF.
  ENDMETHOD.


























  METHOD schedule_next_job.
    CHECK iv_enddate_next < iv_enddate.
    DATA: ls_start_info TYPE cl_apj_rt_api=>ty_start_info.

    ls_start_info-start_immediately = abap_true.

    DATA(lt_param) = VALUE cl_apj_rt_api=>tt_job_parameter_value(
      ( name = 'ID'       t_value = VALUE #( ( sign = 'I' option = 'EQ' low = iv_id ) ) )
      ( name = 'START'    t_value = VALUE #( ( sign = 'I' option = 'EQ' low = iv_startdate_next ) ) )
      ( name = 'END'      t_value = VALUE #( ( sign = 'I' option = 'EQ' low = iv_enddate ) ) )
    ).

    LOOP AT it_companycode INTO DATA(iv_companycode).
      lt_param = VALUE #( BASE lt_param
          ( name = 'COMPCODE' t_value = VALUE #( ( sign = 'I' option = 'EQ' low = iv_companycode ) ) )
      ).
    ENDLOOP.
    TRY.
        cl_apj_rt_api=>schedule_job(
          EXPORTING
            iv_job_template_name  = 'ZJT_HHDV'
            iv_job_text           = |HHDV { iv_id } - T{ iv_startdate_next+4(2) }/{ iv_startdate_next+0(4) }|
            is_start_info          = ls_start_info
            it_job_parameter_value = lt_param
          IMPORTING
            ev_jobname  = DATA(lv_jobname)
            ev_jobcount = DATA(lv_jobcount)
        ).
      CATCH cx_root INTO DATA(lx_error).
        "TODO: log lỗi nếu schedule job kế tiếp thất bại
    ENDTRY.
  ENDMETHOD.


































  METHOD save_job_log.
    TRY.
        co_log->add_item(
          cl_bali_free_text_setter=>create(
            severity = if_bali_constants=>c_severity_information
            text     = |Chạy job từ ngày { iv_startdate } đến ngày { iv_enddate_next }| )
        ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.

    TRY.
        cl_bali_log_db=>get_instance( )->save_log(
          log                        = co_log
          assign_to_current_appl_job = abap_true
        ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.
  ENDMETHOD.





























  METHOD save_compcode_log.
    CHECK iv_total_rows <> 0.
    TRY.
        co_log->add_item(
          cl_bali_free_text_setter=>create(
            severity = if_bali_constants=>c_severity_information
            text     = |CC { iv_companycode }: Chạy thành công { iv_count_success }/{ iv_total_rows } data| )
        ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.
  ENDMETHOD.
























ENDCLASS.
