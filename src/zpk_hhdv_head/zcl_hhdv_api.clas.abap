CLASS zcl_hhdv_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS main
      IMPORTING
        iv_username        TYPE string
        iv_password        TYPE string
        iv_suppliertaxcode TYPE string
        iv_companycode     TYPE string
        iv_startdate       TYPE d
        iv_enddate         TYPE d
        iv_is_job          TYPE abap_boolean OPTIONAL
      EXPORTING
        ev_rc              TYPE i
        ev_response        TYPE string
        ev_count_success   TYPE i
        ev_total_rows      TYPE i
      CHANGING
        co_log             TYPE REF TO if_bali_log OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS api_first_line
      IMPORTING
        iv_username        TYPE string
        iv_password        TYPE string
        iv_suppliertaxcode TYPE string
        iv_companycode     TYPE string
        iv_startdate       TYPE d
        iv_enddate         TYPE d
        iv_is_job          TYPE abap_boolean
      EXPORTING
        ev_rc              TYPE i
        ev_response        TYPE string
        ev_total_rows      TYPE i
      CHANGING
        cv_count_success   TYPE i
        co_log             TYPE REF TO if_bali_log.

    CLASS-METHODS api_all_lines
      IMPORTING
        iv_username        TYPE string
        iv_password        TYPE string
        iv_suppliertaxcode TYPE string
        iv_companycode     TYPE string
        iv_startdate       TYPE d
        iv_enddate         TYPE d
        iv_pagenum         TYPE i
        iv_is_job          TYPE abap_boolean
      EXPORTING
        ev_rc              TYPE i
        ev_response        TYPE string
      CHANGING
        cv_count_success   TYPE i
        co_log             TYPE REF TO if_bali_log.

    CLASS-METHODS api_auth
      IMPORTING
        iv_username     TYPE string
        iv_password     TYPE string
        iv_companycode  TYPE string
        iv_is_job       TYPE abap_boolean
      EXPORTING
        ev_rc           TYPE i
        ev_response     TYPE string
        ev_access_token TYPE string
      CHANGING
        co_log          TYPE REF TO if_bali_log.

    CLASS-METHODS api_invoice
      IMPORTING
        iv_suppliertaxcode TYPE string
        iv_startdate       TYPE d
        iv_enddate         TYPE d
        iv_access_token    TYPE string
        iv_rowperpage      TYPE i
        iv_pagenum         TYPE i
      EXPORTING
        ev_rc              TYPE i
        ev_response        TYPE string
      CHANGING
        co_log             TYPE REF TO if_bali_log.

    CLASS-METHODS get_destination
      IMPORTING
        iv_comm_scenario          TYPE if_com_management=>ty_cscn_id
        iv_service_id             TYPE if_com_management=>ty_cscn_outb_srv_id OPTIONAL
      EXPORTING
        ev_response               TYPE string
      RETURNING
        VALUE(ro_web_http_client) TYPE REF TO if_web_http_client.

    CLASS-METHODS get_access_token
      IMPORTING
        iv_rc           TYPE i
        iv_is_job       TYPE abap_boolean
        iv_response     TYPE string
        iv_companycode  TYPE string
      EXPORTING
        ev_access_token TYPE string
      CHANGING
        co_log          TYPE REF TO if_bali_log.

ENDCLASS.



CLASS ZCL_HHDV_API IMPLEMENTATION.


  METHOD api_auth.
    " ==== 1. Tạo HTTP Client qua Communication Arrangement ====
    DATA(lo_web_http_client) = get_destination(
                                 EXPORTING
                                   iv_comm_scenario = 'Z_API_VIETTEL_EINVOICE_CSCEN'
                                   iv_service_id    = 'Z_API_VIETTEL_EINVOICE_OB_REST'
                                 IMPORTING
                                   ev_response      = ev_response
                               ).
    CHECK ev_response IS INITIAL.

    TRY.
        " ==== 2. Set path + header + body ====
        DATA(lo_request) = lo_web_http_client->get_http_request( ).

        lo_request->set_uri_path( 'auth/login' ).
        lo_request->set_header_field(
          i_name  = 'Content-Type'
          i_value = 'application/json' ).

        DATA(lv_body) = |\{"username":"{ iv_username }","password":"{ iv_password }"\}|.

        lo_request->set_text( lv_body ).

        " ==== 3. Gọi API (POST) ====
        DATA(lo_response) = lo_web_http_client->execute( i_method = if_web_http_client=>post ).

        ev_rc = lo_response->get_status( )-code.
        ev_response = lo_response->get_text( ).

        " ==== 3.2 Lưu log nếu API lỗi ====
        IF ev_rc <> 200.
          " ==== Insert log ====
          TRY.
              DATA(lv_uuid) = cl_system_uuid=>create_uuid_x16_static( ).
            CATCH cx_uuid_error.
              "handle exception
          ENDTRY.

          zcl_utility_ninhnh=>write_api_log(
            iv_uuid        = lv_uuid
            iv_api_type    = 'VIETTEL_AUTH'
            iv_method      = 'POST'
            iv_uri         = |https://api-vinvoice.viettel.vn/auth/login|
            iv_auth_type   = 'NONE'
            io_request     = lo_request
            iv_response    = ev_response
            iv_status_code = ev_rc ).

          TRY.
              co_log->add_item(
                cl_bali_free_text_setter=>create(
                  severity = if_bali_constants=>c_severity_error
                  text     = CONV cl_bali_free_text_setter=>ty_text( lv_uuid )
                )
              ).
            CATCH cx_bali_runtime.
              "handle exception
          ENDTRY.
        ENDIF.

        " ==== 4. Lấy access token ====
        get_access_token(
          EXPORTING
            iv_rc           = ev_rc
            iv_is_job       = iv_is_job
            iv_response     = ev_response
            iv_companycode  = iv_companycode
          IMPORTING
            ev_access_token = ev_access_token
          CHANGING
            co_log          = co_log
        ).

      CATCH cx_web_http_client_error INTO DATA(lx_client_error).
        " TODO: xử lý lỗi kết nối
        ev_response = lx_client_error->get_longtext( ).

        " ==== Lưu log API (lỗi kết nối) ====
        TRY.
            DATA(lv_uuid_client) = cl_system_uuid=>create_uuid_x16_static( ).
          CATCH cx_uuid_error.
            "handle exception
        ENDTRY.

        zcl_utility_ninhnh=>write_api_log(
          iv_uuid      = lv_uuid_client
          iv_api_type  = 'VIETTEL_AUTH'
          iv_method    = 'POST'
          iv_uri       = |https://api-vinvoice.viettel.vn/auth/login|
          iv_auth_type = 'NONE'
          io_request   = lo_request
          iv_response  = lx_client_error->get_longtext( ) ).

        TRY.
            co_log->add_item(
              cl_bali_free_text_setter=>create(
                severity = if_bali_constants=>c_severity_error
                text     = CONV cl_bali_free_text_setter=>ty_text( lv_uuid_client )
              )
            ).
          CATCH cx_bali_runtime.
            "handle exception
        ENDTRY.
      CATCH cx_web_message_error INTO DATA(lx_message_error).
        " TODO: xử lý lỗi message
        ev_response = lx_message_error->get_longtext( ).

        " ==== Lưu log API (lỗi message) ====
        TRY.
            DATA(lv_uuid_msg) = cl_system_uuid=>create_uuid_x16_static( ).
          CATCH cx_uuid_error.
            "handle exception
        ENDTRY.

        zcl_utility_ninhnh=>write_api_log(
          iv_uuid      = lv_uuid_msg
          iv_api_type  = 'VIETTEL_AUTH'
          iv_method    = 'POST'
          iv_uri       = |https://api-vinvoice.viettel.vn/auth/login|
          iv_auth_type = 'NONE'
          io_request   = lo_request
          iv_response  = lx_message_error->get_longtext( ) ).

        TRY.
            co_log->add_item(
              cl_bali_free_text_setter=>create(
                severity = if_bali_constants=>c_severity_error
                text     = CONV cl_bali_free_text_setter=>ty_text( lv_uuid_msg )
              )
            ).
          CATCH cx_bali_runtime.
            "handle exception
        ENDTRY.
    ENDTRY.
  ENDMETHOD.


  METHOD api_invoice.
    "1. Tạo HHTP Client qua Communication Arrangement
    DATA(lo_web_http_client) = get_destination(
                                 EXPORTING
                                   iv_comm_scenario = 'Z_API_VIETTEL_EINVOICE_CSCEN'
                                   iv_service_id    = 'Z_API_VIETTEL_EINVOICE_OB_REST'
                                 IMPORTING
                                   ev_response      = ev_response
                               ).
    CHECK ev_response IS INITIAL.

    "2. Set uri path
    DATA(lv_uri) =
        'services/einvoiceapplication/api/InvoiceAPI/InvoiceUtilsWS/getAllInvoices'
        && |/{ iv_suppliertaxcode }|.

    DATA(lv_full_uri) = |https://api-vinvoice.viettel.vn/{ lv_uri }|.

    DATA(lo_request) = lo_web_http_client->get_http_request( ).
    lo_request->set_uri_path( lv_uri ).

    "3. Set header fields
    DATA: lt_fields TYPE if_web_http_request=>name_value_pairs.
    lt_fields = VALUE #(
        ( name = 'Content-Type' value = 'application/json' )
        ( name = 'Authorization' value = |Bearer { iv_access_token }| )
    ).
    lo_request->set_header_fields( lt_fields ).

    "4. Get body
    DATA(lv_startdate) = |{ iv_startdate+0(4) }-|
                         && |{ iv_startdate+4(2) }-|
                         && |{ iv_startdate+6(2) }|.
    DATA(lv_enddate) = |{ iv_enddate+0(4) }-|
                         && |{ iv_enddate+4(2) }-|
                         && |{ iv_enddate+6(2) }|.

    DATA(lv_body) =
        |\{|
        && |"supplierTaxCode": "{ iv_suppliertaxcode }",|
        && |"startDate": "{ lv_startdate }",|
        && |"endDate": "{ lv_enddate }",|
        && |"rowPerPage": { iv_rowperpage },|
        && |"pageNum": { iv_pagenum }|
        && |\}|.
    lo_request->set_text( lv_body ).

    "5. Gọi API Post
    TRY.
        DATA(lo_response) = lo_web_http_client->execute( if_web_http_client=>post ).

        ev_rc = lo_response->get_status( )-code.
        ev_response = lo_response->get_text( ).

        " ==== 5.2 Lưu log nếu API lỗi ====
        IF ev_rc <> 200.

          TRY.
              DATA(lv_uuid) = cl_system_uuid=>create_uuid_x16_static( ).
            CATCH cx_uuid_error.
              "handle exception
          ENDTRY.
          zcl_utility_ninhnh=>write_api_log(
            iv_uuid        = lv_uuid
            iv_api_type    = 'VIETTEL_INVOICE'
            iv_method      = 'POST'
            iv_uri         = lv_full_uri
            iv_auth_type   = 'BEARER'
            io_request     = lo_request
            iv_response    = ev_response
            iv_status_code = ev_rc ).
          TRY.
              co_log->add_item(
                cl_bali_free_text_setter=>create(
                  severity = if_bali_constants=>c_severity_error
                  text     = CONV cl_bali_free_text_setter=>ty_text( lv_uuid )
                )
              ).
            CATCH cx_bali_runtime.
              "handle exception
          ENDTRY.
        ENDIF.

      CATCH cx_web_http_client_error INTO DATA(lx_client_error).
        ev_response = lx_client_error->get_longtext( ).

        " ==== Lưu log API (lỗi kết nối) ====
        TRY.
            DATA(lv_uuid_client) = cl_system_uuid=>create_uuid_x16_static( ).
          CATCH cx_uuid_error.
            "handle exception
        ENDTRY.
        zcl_utility_ninhnh=>write_api_log(
          iv_uuid      = lv_uuid_client
          iv_api_type  = 'VIETTEL_INVOICE'
          iv_method    = 'POST'
          iv_uri       = lv_full_uri
          iv_auth_type = 'BEARER'
          io_request   = lo_request
          iv_response  = lx_client_error->get_longtext( ) ).
        TRY.
            co_log->add_item(
              cl_bali_free_text_setter=>create(
                severity = if_bali_constants=>c_severity_error
                text     = CONV cl_bali_free_text_setter=>ty_text( lv_uuid_client )
              )
            ).
          CATCH cx_bali_runtime.
            "handle exception
        ENDTRY.
    ENDTRY.

  ENDMETHOD.


  METHOD get_destination.
    TRY.
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                  comm_scenario = iv_comm_scenario
                                  service_id    = iv_service_id ).
      CATCH cx_http_dest_provider_error.
        ev_response = 'lỗi kết nối'.
    ENDTRY.

    TRY.
        ro_web_http_client = cl_web_http_client_manager=>create_by_http_destination(
                                      i_destination = lo_destination ).
      CATCH cx_web_http_client_error.
        ev_response = 'lỗi kết nối'.
    ENDTRY.
  ENDMETHOD.


  METHOD api_first_line.
    "1. Chạy API lần 1 để lấy được access_token
    api_auth(
      EXPORTING
        iv_username     = iv_username
        iv_password     = iv_password
        iv_companycode  = iv_companycode
        iv_is_job       = iv_is_job
      IMPORTING
        ev_rc           = DATA(lv_rc_auth)
        ev_response     = DATA(lv_response_auth)
        ev_access_token = DATA(lv_access_token)
      CHANGING
        co_log          = co_log
    ).

    "2. Sau khi lấy được access_token thì chạy API lần 2 để lấy được data
    api_invoice(
      EXPORTING
        iv_suppliertaxcode = iv_suppliertaxcode
        iv_startdate       = iv_startdate
        iv_enddate         = iv_enddate
        iv_access_token    = lv_access_token
        iv_rowperpage      = 1
        iv_pagenum         = 1
      IMPORTING
        ev_rc              = ev_rc
        ev_response        = ev_response
      CHANGING
        co_log             = co_log
    ).

    "3. Lấy total row để chạy cho các page tiếp theo
    CHECK ev_rc = 200.
    FIND REGEX '"totalRows"\s*:\s*(\d+)'
    IN ev_response
    SUBMATCHES DATA(lv_total_rows).

    ev_total_rows = lv_total_rows.

    "4. Append data và bảng Z Header và ZItem
    zcl_hhdv_f01=>append_ztab(
      EXPORTING
        iv_response      = ev_response
      CHANGING
        cv_count_success = cv_count_success
    ).
  ENDMETHOD.


  METHOD api_all_lines.
    "1. Chạy API lần 1 để lấy được access_token
    api_auth(
      EXPORTING
        iv_username     = iv_username
        iv_password     = iv_password
        iv_companycode  = iv_companycode
        iv_is_job       = iv_is_job
      IMPORTING
        ev_rc           = DATA(lv_rc_auth)
        ev_response     = DATA(lv_response_auth)
        ev_access_token = DATA(lv_access_token)
      CHANGING
        co_log          = co_log
    ).

    "2. Sau khi lấy được access_token thì chạy API lần 2 để lấy được data
    CHECK lv_rc_auth = 200.
    api_invoice(
      EXPORTING
        iv_suppliertaxcode = iv_suppliertaxcode
        iv_startdate       = iv_startdate
        iv_enddate         = iv_enddate
        iv_access_token    = lv_access_token
        iv_rowperpage      = 1
        iv_pagenum         = iv_pagenum
      IMPORTING
        ev_rc              = ev_rc
        ev_response        = ev_response
      CHANGING
        co_log             = co_log
    ).

    "3. Append data và bảng Z Header và ZItem
    CHECK ev_rc = 200.
    zcl_hhdv_f01=>append_ztab(
      EXPORTING
        iv_response      = ev_response
      CHANGING
        cv_count_success = cv_count_success
    ).
  ENDMETHOD.


  METHOD main.
    api_first_line(
      EXPORTING
        iv_username        = iv_username
        iv_password        = iv_password
        iv_suppliertaxcode = iv_suppliertaxcode
        iv_companycode     = iv_companycode
        iv_startdate       = iv_startdate
        iv_enddate         = iv_enddate
        iv_is_job          = iv_is_job
      IMPORTING
        ev_rc              = DATA(lv_rc)
        ev_response        = DATA(lv_response)
        ev_total_rows      = ev_total_rows
      CHANGING
        cv_count_success   = ev_count_success
        co_log             = co_log
    ).

    "4. chạy api lấy data cho từng line
    CHECK lv_rc = 200.
    DO ev_total_rows TIMES.
      CHECK sy-index <> 1.

      CLEAR: lv_rc,
             lv_response.

      zcl_hhdv_api=>api_all_lines(
        EXPORTING
          iv_username        = iv_username
          iv_password        = iv_password
          iv_suppliertaxcode = iv_suppliertaxcode
          iv_companycode     = iv_companycode
          iv_startdate       = iv_startdate
          iv_enddate         = iv_enddate
          iv_pagenum         = sy-index
          iv_is_job          = iv_is_job
        IMPORTING
          ev_rc              = lv_rc
          ev_response        = lv_response
        CHANGING
          cv_count_success   = ev_count_success
          co_log             = co_log
      ).

      IF lv_rc <> 200.
        EXIT.
      ENDIF.
    ENDDO.
  ENDMETHOD.


  METHOD get_access_token.
    IF iv_rc = 200.
      FIND REGEX '"access_token"\s*:\s*"([^"]+)"'
      IN iv_response
      SUBMATCHES ev_access_token.
    ELSE.
      CHECK iv_is_job = 'X'.

      "1. Lấy title + status (JSON phẳng, không escape)
      FIND REGEX '"title"\s*:\s*"([^"]*)"'
      IN iv_response
      SUBMATCHES DATA(lv_title).

      "2. Lấy detail (JSON lồng bên trong, có escape \" nên phải match cả \\. )
      FIND REGEX '"detail"\s*:\s*"((?:\\.|[^"\\])*)"'
      IN iv_response
      SUBMATCHES DATA(lv_detail_raw).

      "3. Unescape \" --> " để detail đọc được như JSON bình thường
      REPLACE ALL OCCURRENCES OF '\"' IN lv_detail_raw WITH '"'.

      "4. Lấy error_description từ trong detail đã unescape
      FIND REGEX '"error_description"\s*:\s*"([^"]*)"'
      IN lv_detail_raw
      SUBMATCHES DATA(lv_error_desc).

      "5. Build message text cho log - fallback nếu regex không match
      DATA(lv_log_text) = COND string(
        WHEN lv_error_desc IS NOT INITIAL THEN |{ lv_title } - { lv_error_desc }|
        WHEN lv_title      IS NOT INITIAL THEN lv_title
        ELSE iv_response
      ).

      lv_log_text = |CC { iv_companycode }: { lv_log_text }|.

      CHECK co_log IS BOUND.
      TRY.
          co_log->add_item(
            cl_bali_free_text_setter=>create(
              severity = if_bali_constants=>c_severity_error
              text     = CONV cl_bali_free_text_setter=>ty_text( lv_log_text )
            )
          ).
        CATCH cx_bali_runtime.
      ENDTRY.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
