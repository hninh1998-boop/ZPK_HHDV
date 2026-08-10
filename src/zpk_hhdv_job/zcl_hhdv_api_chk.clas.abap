CLASS zcl_hhdv_api_chk DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_hhdv_api_chk IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "API Auth/Login
    TRY.
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                  comm_scenario = 'Z_API_VIETTEL_EINVOICE_CSCEN'
                                  service_id    = 'Z_API_VIETTEL_EINVOICE_OB_REST' ).
      CATCH cx_http_dest_provider_error INTO DATA(lx_err_dest).
        out->write( lx_err_dest->get_longtext( ) ).
    ENDTRY.
    TRY.
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination(
                                      i_destination = lo_destination ).
      CATCH cx_web_http_client_error INTO DATA(lx_err_hhtp).
        out->write( lx_err_hhtp->get_longtext( ) ).
    ENDTRY.
    TRY.
        " ==== 2. Set path + header + body ====
        DATA(lo_request) = lo_web_http_client->get_http_request( ).
        lo_request->set_uri_path( 'auth/login' ).

        lo_request->set_header_field(
          i_name  = 'Content-Type'
          i_value = 'application/json' ).
        "Test data auth của 6710
        SELECT SINGLE FROM ztb_auth_hhdv
        FIELDS *
        WHERE company_code = '6710'
        INTO @DATA(ls_auth).
        DATA(lv_body) = |\{"username":"{ ls_auth-username }","password":"{ ls_auth-password }"\}|.
        lo_request->set_text( lv_body ).
        " ==== 3. Gọi API (POST) ====
        DATA(lo_response) = lo_web_http_client->execute( i_method = if_web_http_client=>post ).
        DATA(lv_rc) = lo_response->get_status( )-code.
        DATA(lv_response) = lo_response->get_text( ).

        " ==== 4. Ghi log API ====
        CONSTANTS: c_base_url TYPE string VALUE 'https://api-vinvoice.viettel.vn'.
        DATA(lv_path) = 'auth/login'.
        DATA(lv_full_uri) = |{ c_base_url }/{ lv_path }|.

*        zcl_utility_ninhnh=>write_api_log(
*          iv_api_type    = 'AUTH_LOGIN'
*          iv_method      = 'POST'
*          iv_uri         = lv_full_uri
*          iv_auth_type   = 'NONE'
*          io_request     = lo_request
*          iv_response    = lv_response
*          iv_status_code = lv_rc ).
*
*      CATCH cx_web_http_client_error INTO DATA(lx_client_error).
*        lv_response = lx_client_error->get_longtext( ).
*        zcl_utility_ninhnh=>write_api_log(
*          iv_api_type  = 'AUTH_LOGIN'
*          iv_method    = 'POST'
*          iv_uri       = lv_full_uri
*          iv_auth_type = 'NONE'
*          io_request   = lo_request
*          iv_response  = lv_response ).
*      CATCH cx_web_message_error INTO DATA(lx_message_error).
*        lv_response = lx_message_error->get_longtext( ).
*        zcl_utility_ninhnh=>write_api_log(
*          iv_api_type  = 'AUTH_LOGIN'
*          iv_method    = 'POST'
*          iv_uri       = lv_full_uri
*          iv_auth_type = 'NONE'
*          io_request   = lo_request
*          iv_response  = lv_response ).
    ENDTRY.

    out->write( lv_response ).

  ENDMETHOD.
ENDCLASS.
