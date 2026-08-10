CLASS zcl_ce_hhdv_rp_f01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS requested
      IMPORTING
        io_request TYPE REF TO if_rap_query_request
      EXPORTING
        et_filters TYPE if_rap_query_filter=>tt_name_range_pairs.

    CLASS-METHODS response
      IMPORTING
        io_request  TYPE REF TO if_rap_query_request
        io_response TYPE REF TO if_rap_query_response
      CHANGING
        ct_result   TYPE zcl_ce_hhdv_rp_top=>tt_result.

    CLASS-METHODS main
      IMPORTING
        it_filters TYPE if_rap_query_filter=>tt_name_range_pairs
      EXPORTING
        et_result  TYPE zcl_ce_hhdv_rp_top=>tt_result.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS build_param
      IMPORTING
        it_filters     TYPE if_rap_query_filter=>tt_name_range_pairs
      EXPORTING
        er_kybaocao    TYPE zcl_ce_hhdv_rp_top=>ry_string
        er_companycode TYPE zcl_ce_hhdv_rp_top=>ry_string
        er_sohd        TYPE zcl_ce_hhdv_rp_top=>ry_string
        er_thuesuat    TYPE zcl_ce_hhdv_rp_top=>ry_string
        er_chungtu     TYPE zcl_ce_hhdv_rp_top=>ry_string
        er_customer    TYPE zcl_ce_hhdv_rp_top=>ry_string.

    CLASS-METHODS get_keys
      IMPORTING
        ir_kybaocao    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_companycode TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_sohd        TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_thuesuat    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_chungtu     TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_customer    TYPE zcl_ce_hhdv_rp_top=>ry_string
      EXPORTING
        et_keys        TYPE zcl_ce_hhdv_rp_top=>tt_key
        et_ghichu      TYPE zcl_ce_hhdv_rp_top=>tt_ghichu.

    CLASS-METHODS get_keys_1
      IMPORTING
        ir_kybaocao    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_companycode TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_sohd        TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_thuesuat    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_chungtu     TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_customer    TYPE zcl_ce_hhdv_rp_top=>ry_string
      EXPORTING
        et_keys_1      TYPE zcl_ce_hhdv_rp_top=>tt_key.

    CLASS-METHODS get_keys_2
      IMPORTING
        ir_kybaocao    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_companycode TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_sohd        TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_thuesuat    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_chungtu     TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_customer    TYPE zcl_ce_hhdv_rp_top=>ry_string
      EXPORTING
        et_keys_2      TYPE zcl_ce_hhdv_rp_top=>tt_key.

    CLASS-METHODS get_keys_3
      IMPORTING
        ir_kybaocao    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_companycode TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_sohd        TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_thuesuat    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_chungtu     TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_customer    TYPE zcl_ce_hhdv_rp_top=>ry_string
      EXPORTING
        et_keys_3      TYPE zcl_ce_hhdv_rp_top=>tt_key.

    CLASS-METHODS get_keys_4
      IMPORTING
        ir_kybaocao    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_companycode TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_sohd        TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_thuesuat    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_chungtu     TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_customer    TYPE zcl_ce_hhdv_rp_top=>ry_string
        it_keys_3      TYPE zcl_ce_hhdv_rp_top=>tt_key
      EXPORTING
        et_keys_4      TYPE zcl_ce_hhdv_rp_top=>tt_key.

    CLASS-METHODS get_keys_5
      IMPORTING
        ir_kybaocao    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_companycode TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_sohd        TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_thuesuat    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_chungtu     TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_customer    TYPE zcl_ce_hhdv_rp_top=>ry_string
      EXPORTING
        et_keys_5      TYPE zcl_ce_hhdv_rp_top=>tt_key.


    CLASS-METHODS get_invoice_key
      IMPORTING
        iv_kyhieumauhoadon   TYPE char100
        iv_kyhieuhd          TYPE char100
        iv_sohd              TYPE char100
      RETURNING
        VALUE(rv_invoicekey) TYPE string.

    CLASS-METHODS get_bases
      IMPORTING
        it_keys  TYPE zcl_ce_hhdv_rp_top=>tt_key
      EXPORTING
        et_bases TYPE zcl_ce_hhdv_rp_top=>tt_base.

    CLASS-METHODS get_keys_result
      IMPORTING
        is_key    TYPE zcl_ce_hhdv_rp_top=>ty_key
      CHANGING
        cs_result TYPE zce_hhdv_rp.

    CLASS-METHODS get_normal_base_result
      IMPORTING
        is_base   TYPE zcl_ce_hhdv_rp_top=>ty_base
      CHANGING
        cs_result TYPE zce_hhdv_rp.

    CLASS-METHODS get_decimals_base_result
      IMPORTING
        it_acct_doc TYPE zcl_ce_hhdv_rp_top=>tt_acct_doc
        is_base     TYPE zcl_ce_hhdv_rp_top=>ty_base
      CHANGING
        cs_result   TYPE zce_hhdv_rp.

    CLASS-METHODS get_acct_doc
      IMPORTING
        it_bases    TYPE zcl_ce_hhdv_rp_top=>tt_base
      EXPORTING
        et_acct_doc TYPE zcl_ce_hhdv_rp_top=>tt_acct_doc.

    CLASS-METHODS get_longtext_fields
      IMPORTING
        it_bases          TYPE zcl_ce_hhdv_rp_top=>tt_base
      EXPORTING
        et_billing        TYPE zcl_ce_hhdv_rp_top=>tt_billing
        et_longtext_id    TYPE zcl_ce_hhdv_rp_top=>tt_longtext_id
        et_billingtexts_h TYPE zcl_ce_hhdv_rp_top=>tt_billingtexts_h.

    CLASS-METHODS get_acct_doc_result
      IMPORTING
        it_acct_doc TYPE zcl_ce_hhdv_rp_top=>tt_acct_doc
        is_key      TYPE zcl_ce_hhdv_rp_top=>ty_key
      CHANGING
        cs_result   TYPE zce_hhdv_rp.

    CLASS-METHODS get_longtext_result
      IMPORTING
        it_billing        TYPE zcl_ce_hhdv_rp_top=>tt_billing
        it_longtext_id    TYPE zcl_ce_hhdv_rp_top=>tt_longtext_id
        it_billingtexts_h TYPE zcl_ce_hhdv_rp_top=>tt_billingtexts_h
        is_key            TYPE zcl_ce_hhdv_rp_top=>ty_key
      CHANGING
        cs_result         TYPE zce_hhdv_rp.

    CLASS-METHODS get_exchange_rate
      IMPORTING
        it_bases        TYPE zcl_ce_hhdv_rp_top=>tt_base
      EXPORTING
        et_exchangerate TYPE zcl_ce_hhdv_rp_top=>tt_exchangerate.

    CLASS-METHODS get_tygia_result
      IMPORTING
        it_exchangerate TYPE zcl_ce_hhdv_rp_top=>tt_exchangerate
        is_base         TYPE zcl_ce_hhdv_rp_top=>ty_base
      CHANGING
        cs_result       TYPE zce_hhdv_rp.

    CLASS-METHODS get_ghichu_2
      IMPORTING
        it_keys_2   TYPE zcl_ce_hhdv_rp_top=>tt_key
      EXPORTING
        et_ghichu_2 TYPE zcl_ce_hhdv_rp_top=>tt_ghichu.

    CLASS-METHODS get_ghichu_3
      IMPORTING
        it_keys_3   TYPE zcl_ce_hhdv_rp_top=>tt_key
      EXPORTING
        et_ghichu_3 TYPE zcl_ce_hhdv_rp_top=>tt_ghichu.

    CLASS-METHODS get_ghichu_4
      IMPORTING
        it_keys_4   TYPE zcl_ce_hhdv_rp_top=>tt_key
      EXPORTING
        et_ghichu_4 TYPE zcl_ce_hhdv_rp_top=>tt_ghichu.

    CLASS-METHODS get_ghichu_5
      IMPORTING
        it_keys_5   TYPE zcl_ce_hhdv_rp_top=>tt_key
      EXPORTING
        et_ghichu_5 TYPE zcl_ce_hhdv_rp_top=>tt_ghichu.

    CLASS-METHODS get_ghichu_result
      IMPORTING
        it_ghichu TYPE zcl_ce_hhdv_rp_top=>tt_ghichu
        is_key    TYPE zcl_ce_hhdv_rp_top=>ty_key
      CHANGING
        cs_result TYPE zce_hhdv_rp.

    CLASS-METHODS get_customer
      IMPORTING
        it_bases    TYPE zcl_ce_hhdv_rp_top=>tt_base
      EXPORTING
        et_customer TYPE zcl_ce_hhdv_rp_top=>tt_customer.

    CLASS-METHODS get_customer_result
      IMPORTING
        it_customer      TYPE zcl_ce_hhdv_rp_top=>tt_customer
        it_customer_name TYPE zcl_ce_hhdv_rp_top=>tt_customer_name
        is_key           TYPE zcl_ce_hhdv_rp_top=>ty_key
      CHANGING
        cs_result        TYPE zce_hhdv_rp.

    CLASS-METHODS get_customer_name
      IMPORTING
        it_customer      TYPE zcl_ce_hhdv_rp_top=>tt_customer
      EXPORTING
        et_customer_name TYPE zcl_ce_hhdv_rp_top=>tt_customer_name.

    CLASS-METHODS build_main
      IMPORTING
        ir_kybaocao       TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_companycode    TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_sohd           TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_thuesuat       TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_chungtu        TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_customer       TYPE zcl_ce_hhdv_rp_top=>ry_string
      EXPORTING
        et_keys           TYPE zcl_ce_hhdv_rp_top=>tt_key
        et_ghichu         TYPE zcl_ce_hhdv_rp_top=>tt_ghichu
        et_bases          TYPE zcl_ce_hhdv_rp_top=>tt_base
        et_acct_doc       TYPE zcl_ce_hhdv_rp_top=>tt_acct_doc
        et_billing        TYPE zcl_ce_hhdv_rp_top=>tt_billing
        et_longtext_id    TYPE zcl_ce_hhdv_rp_top=>tt_longtext_id
        et_billingtexts_h TYPE zcl_ce_hhdv_rp_top=>tt_billingtexts_h
        et_exchangerate   TYPE zcl_ce_hhdv_rp_top=>tt_exchangerate
        et_customer       TYPE zcl_ce_hhdv_rp_top=>tt_customer
        et_customer_name  TYPE zcl_ce_hhdv_rp_top=>tt_customer_name.

    CLASS-METHODS build_result
      IMPORTING
        it_keys           TYPE zcl_ce_hhdv_rp_top=>tt_key
        it_ghichu         TYPE zcl_ce_hhdv_rp_top=>tt_ghichu
        it_bases          TYPE zcl_ce_hhdv_rp_top=>tt_base
        it_acct_doc       TYPE zcl_ce_hhdv_rp_top=>tt_acct_doc
        it_billing        TYPE zcl_ce_hhdv_rp_top=>tt_billing
        it_longtext_id    TYPE zcl_ce_hhdv_rp_top=>tt_longtext_id
        it_billingtexts_h TYPE zcl_ce_hhdv_rp_top=>tt_billingtexts_h
        it_exchangerate   TYPE zcl_ce_hhdv_rp_top=>tt_exchangerate
        it_customer       TYPE zcl_ce_hhdv_rp_top=>tt_customer
        it_customer_name  TYPE zcl_ce_hhdv_rp_top=>tt_customer_name
        ir_chungtu        TYPE zcl_ce_hhdv_rp_top=>ry_string
        ir_customer       TYPE zcl_ce_hhdv_rp_top=>ry_string
      EXPORTING
        et_result         TYPE zcl_ce_hhdv_rp_top=>tt_result.
ENDCLASS.



CLASS zcl_ce_hhdv_rp_f01 IMPLEMENTATION.
  METHOD main.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "1. Build Param
    build_param(
      EXPORTING
        it_filters     = it_filters
      IMPORTING
        er_kybaocao    = DATA(lr_kybaocao)
        er_companycode = DATA(lr_companycode)
        er_sohd        = DATA(lr_sohd)
        er_thuesuat    = DATA(lr_thuesuat)
        er_chungtu     = DATA(lr_chungtu)
        er_customer    = DATA(lr_customer)
    ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "2. Build Main Data
    build_main(
      EXPORTING
        ir_kybaocao       = lr_kybaocao
        ir_companycode    = lr_companycode
        ir_sohd           = lr_sohd
        ir_thuesuat       = lr_thuesuat
        ir_chungtu        = lr_chungtu
        ir_customer       = lr_customer
      IMPORTING
        et_keys           = DATA(lt_keys)
        et_ghichu         = DATA(lt_ghichu)
        et_bases          = DATA(lt_bases)
        et_acct_doc       = DATA(lt_acct_doc)
        et_billing        = DATA(lt_billing)
        et_longtext_id    = DATA(lt_longtext_id)
        et_billingtexts_h = DATA(lt_billingtexts_h)
        et_exchangerate   = DATA(lt_exchangerate)
        et_customer       = DATA(lt_customer)
        et_customer_name  = DATA(lt_customer_name)
    ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "3. Build Result Data
    build_result(
      EXPORTING
        it_keys           = lt_keys
        it_ghichu         = lt_ghichu
        it_bases          = lt_bases
        it_acct_doc       = lt_acct_doc
        it_billing        = lt_billing
        it_longtext_id    = lt_longtext_id
        it_billingtexts_h = lt_billingtexts_h
        it_exchangerate   = lt_exchangerate
        it_customer       = lt_customer
        it_customer_name  = lt_customer_name
        ir_chungtu        = lr_chungtu
        ir_customer       = lr_customer
      IMPORTING
        et_result         = et_result
    ).
  ENDMETHOD.






































  METHOD requested.
    TRY.
        et_filters = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range.
        "handle exception
    ENDTRY.
  ENDMETHOD.



































  METHOD response.
    " ── a. AGGREGATION ──
    TRY.
        DATA(lo_aggregation) = io_request->get_aggregation( ).
        DATA(lt_group_by)    = lo_aggregation->get_grouped_elements( ).    " table of string
        DATA(lt_agg_elems)   = lo_aggregation->get_aggregated_elements( ). " table of ty_aggregation_element
      CATCH cx_rap_query_provider.
    ENDTRY.

    " ── b. RESPONSE ────────────────────────────────
    DATA(lv_total) = lines( ct_result ).

    IF io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( CONV int8( lv_total ) ).
    ENDIF.
    " ── c. HANDLE SORT ─────────────────────────────────────
    DATA(lt_sort) = io_request->get_sort_elements( ).
    IF lt_sort IS NOT INITIAL.
      DATA lt_sort_order TYPE abap_sortorder_tab.
      LOOP AT lt_sort INTO DATA(ls_sort).
        APPEND VALUE #(
            name       = ls_sort-element_name
            descending = ls_sort-descending
        ) TO lt_sort_order.
      ENDLOOP.
      SORT ct_result BY (lt_sort_order).
    ELSE.
      " Default sort: ThueSuat DESC > SoHD ASC > EINVLineItem ASC
      " + day chung tu dieu chinh (GHICHU = 'DC cho HD...') len ngay sau chung tu goc
      " Xu ly theo tung BLOCK chung tu (gom het line item), khong theo tung dong
      SORT ct_result BY thuesuat DESCENDING sohd ASCENDING einvlineitem ASCENDING.

      DATA: lt_source      TYPE zcl_ce_hhdv_rp_top=>tt_result,
            lt_done        TYPE TABLE OF sy-tabix,
            lv_lines       TYPE sy-tabix,
            lv_idx         TYPE sy-tabix,
            lv_block_start TYPE sy-tabix,
            lv_block_end   TYPE sy-tabix,
            lv_scan        TYPE sy-tabix,
            lv_scan2       TYPE sy-tabix,
            lv_child_start TYPE sy-tabix,
            lv_child_end   TYPE sy-tabix,
            lv_cur_idx     TYPE sy-tabix,
            lv_cidx        TYPE sy-tabix,
            lv_parent_sohd TYPE string.

      lt_source = ct_result.
      CLEAR ct_result.
      lv_lines = lines( lt_source ).
      lv_idx = 1.

      WHILE lv_idx <= lv_lines.
        IF line_exists( lt_done[ table_line = lv_idx ] ).
          ADD 1 TO lv_idx.
          CONTINUE.
        ENDIF.

        READ TABLE lt_source INTO DATA(ls_cur) INDEX lv_idx.

        " Xac dinh full block cua chung tu goc (cac dong lien tiep cung SOHD + ThueSuat)
        lv_block_start = lv_idx.
        lv_block_end   = lv_idx.
        lv_scan = lv_idx + 1.
        WHILE lv_scan <= lv_lines.
          READ TABLE lt_source INTO DATA(ls_scan) INDEX lv_scan.
          IF ls_scan-sohd = ls_cur-sohd AND ls_scan-thuesuat = ls_cur-thuesuat.
            lv_block_end = lv_scan.
            ADD 1 TO lv_scan.
          ELSE.
            EXIT.
          ENDIF.
        ENDWHILE.

        " Append toan bo block chung tu goc + danh dau done
        DO lv_block_end - lv_block_start + 1 TIMES.
          lv_cur_idx = lv_block_start + sy-index - 1.
          READ TABLE lt_source INTO DATA(ls_append) INDEX lv_cur_idx.
          APPEND ls_append TO ct_result.
          APPEND lv_cur_idx TO lt_done.
        ENDDO.

        " Tim cac chung tu DIEU CHINH tham chieu den SOHD nay, cung nhom ThueSuat
        lv_scan = lv_block_end + 1.
        WHILE lv_scan <= lv_lines.
          READ TABLE lt_source INTO DATA(ls_child) INDEX lv_scan.

          IF ls_child-thuesuat <> ls_cur-thuesuat.
            EXIT.
          ENDIF.

          IF NOT line_exists( lt_done[ table_line = lv_scan ] )
             AND ls_child-ghichu CS 'ĐC cho HĐ' AND ls_child-sohd <> ls_cur-sohd.

            CLEAR lv_parent_sohd.
            FIND REGEX '(\d+)\s+ngày' IN ls_child-ghichu SUBMATCHES lv_parent_sohd.

            IF sy-subrc = 0 AND lv_parent_sohd = ls_cur-sohd.
              " Xac dinh full block cua chung tu dieu chinh nay
              lv_child_start = lv_scan.
              lv_child_end   = lv_scan.
              lv_scan2 = lv_scan + 1.
              WHILE lv_scan2 <= lv_lines.
                READ TABLE lt_source INTO DATA(ls_scan2) INDEX lv_scan2.
                IF ls_scan2-sohd = ls_child-sohd AND ls_scan2-thuesuat = ls_child-thuesuat.
                  lv_child_end = lv_scan2.
                  ADD 1 TO lv_scan2.
                ELSE.
                  EXIT.
                ENDIF.
              ENDWHILE.

              DO lv_child_end - lv_child_start + 1 TIMES.
                lv_cidx = lv_child_start + sy-index - 1.
                READ TABLE lt_source INTO DATA(ls_cappend) INDEX lv_cidx.
                APPEND ls_cappend TO ct_result.
                APPEND lv_cidx TO lt_done.
              ENDDO.
            ENDIF.
          ENDIF.

          ADD 1 TO lv_scan.
        ENDWHILE.

        ADD 1 TO lv_idx.
      ENDWHILE.
    ENDIF.

    " ── d. PAGING ──────────────────────────────────────────
    DATA(lv_skip) = io_request->get_paging( )->get_offset( ).
    DATA(lv_top)  = io_request->get_paging( )->get_page_size( ).

    IF lv_top = if_rap_query_paging=>page_size_unlimited.
      lv_top = lv_total.
    ENDIF.

    IF lv_skip > 0.
      DELETE ct_result TO lv_skip.
    ENDIF.

    IF lv_top < lines( ct_result ).
      DELETE ct_result FROM lv_top + 1.
    ENDIF.

    io_response->set_data( ct_result ).
  ENDMETHOD.























  METHOD build_param.
    LOOP AT it_filters INTO  DATA(ls_filter).
      CASE ls_filter-name.
        WHEN 'KYBAOCAO'.
          er_kybaocao = CORRESPONDING zcl_ce_hhdv_rp_top=>ry_string( ls_filter-range ).
        WHEN 'COMPANYCODE'.
          er_companycode = CORRESPONDING zcl_ce_hhdv_rp_top=>ry_string( ls_filter-range ).
        WHEN 'SOHD'.
          er_sohd = CORRESPONDING zcl_ce_hhdv_rp_top=>ry_string( ls_filter-range ).
        WHEN 'THUESUAT'.
          er_thuesuat = CORRESPONDING zcl_ce_hhdv_rp_top=>ry_string( ls_filter-range ).
        WHEN 'CHUNGTU'.
          er_chungtu = CORRESPONDING zcl_ce_hhdv_rp_top=>ry_string( ls_filter-range ).
        WHEN 'CUSTOMER'.
          er_customer = CORRESPONDING zcl_ce_hhdv_rp_top=>ry_string( ls_filter-range ).
      ENDCASE.
    ENDLOOP.

    "Modify Kỳ báo cáo --> chuyển đúng định dạng string của IssueDateStr
    IF er_kybaocao IS NOT INITIAL.
      LOOP AT er_kybaocao ASSIGNING FIELD-SYMBOL(<lfs_kybaocao>).
        IF <lfs_kybaocao>-low IS NOT INITIAL.
          <lfs_kybaocao>-low = |{ <lfs_kybaocao>-low+0(4) }-|
                               && |{ <lfs_kybaocao>-low+4(2) }-|
                               && |{ <lfs_kybaocao>-low+6(2) }|
                               && |T00:00:00Z|.
        ENDIF.
        IF <lfs_kybaocao>-low IS NOT INITIAL.
          <lfs_kybaocao>-high = |{ <lfs_kybaocao>-high+0(4) }-|
                               && |{ <lfs_kybaocao>-high+4(2) }-|
                               && |{ <lfs_kybaocao>-high+6(2) }|
                               && |T23:59:59Z|.
        ENDIF.
      ENDLOOP.
    ENDIF.

    "Modify số HĐ
    IF er_sohd IS NOT INITIAL.
      DATA(lr_temp_sohd) = er_sohd.

      LOOP AT lr_temp_sohd INTO DATA(ls_sohd).
        CHECK ls_sohd-low IS NOT INITIAL AND ls_sohd-low CO '0123456789'.

        " Chuẩn bị high đã pad (nếu có), giữ nguyên nếu rỗng hoặc không toàn số
        DATA(lv_high_w7) = ls_sohd-high.
        DATA(lv_high_w8) = ls_sohd-high.

        IF ls_sohd-high IS NOT INITIAL AND ls_sohd-high CO '0123456789'.
          lv_high_w7 = |{ ls_sohd-high ALPHA = IN WIDTH = 7 }|.
          lv_high_w8 = |{ ls_sohd-high ALPHA = IN WIDTH = 8 }|.
        ENDIF.

        " Thêm biến thể pad 3 số 0 (độ dài 7)
        APPEND VALUE #( sign   = ls_sohd-sign
                         option = ls_sohd-option
                         low    = |{ ls_sohd-low ALPHA = IN WIDTH = 7 }|
                         high   = lv_high_w7 ) TO er_sohd.

        " Thêm biến thể pad 4 số 0 (độ dài 8)
        APPEND VALUE #( sign   = ls_sohd-sign
                         option = ls_sohd-option
                         low    = |{ ls_sohd-low ALPHA = IN WIDTH = 8 }|
                         high   = lv_high_w8 ) TO er_sohd.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

























  METHOD get_keys.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Case 1: filter
    "   zi_hhdv_head: AdjustmentType = 1, InvoiceStatus = null, IssueDateStr = lr_kybaocao
    "   zi_hhdv_item: Selection in (1,0), LineNumber <> 0
    get_keys_1(
      EXPORTING
        ir_kybaocao    = ir_kybaocao
        ir_companycode = ir_companycode
        ir_sohd        = ir_sohd
        ir_thuesuat    = ir_thuesuat
        ir_chungtu     = ir_chungtu
        ir_customer    = ir_customer
      IMPORTING
        et_keys_1      = DATA(lt_keys_1)
    ).
    IF lt_keys_1 IS NOT INITIAL.
      APPEND LINES OF lt_keys_1 TO et_keys.
    ENDIF.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Case 2: filter
    "   zi_hhdv_head: AdjustmentType = 1, InvoiceStatus = 0, IssueDateStr = lr_kybaocao
    "   zi_hhdv_item: Selection in (1,0), LineNumber <> 0
    get_keys_2(
      EXPORTING
        ir_kybaocao    = ir_kybaocao
        ir_companycode = ir_companycode
        ir_sohd        = ir_sohd
        ir_thuesuat    = ir_thuesuat
        ir_chungtu     = ir_chungtu
        ir_customer    = ir_customer
      IMPORTING
        et_keys_2      = DATA(lt_keys_2)
    ).
    IF lt_keys_2 IS NOT INITIAL.
      APPEND LINES OF lt_keys_2 TO et_keys.

      "Get ghi chú 2
      get_ghichu_2( EXPORTING it_keys_2   = lt_keys_2
                    IMPORTING et_ghichu_2 = DATA(lt_ghichu_2) ).
      IF lt_ghichu_2 IS NOT INITIAL.
        APPEND LINES OF lt_ghichu_2 TO et_ghichu.
      ENDIF.
    ENDIF.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Case 3: filter
    "   zi_hhdv_head: AdjustmentType = 1, InvoiceStatus = 1, IssueDateStr = lr_kybaocao
    get_keys_3(
      EXPORTING
        ir_kybaocao    = ir_kybaocao
        ir_companycode = ir_companycode
        ir_sohd        = ir_sohd
        ir_thuesuat    = ir_thuesuat
        ir_chungtu     = ir_chungtu
        ir_customer    = ir_customer
      IMPORTING
        et_keys_3      = DATA(lt_keys_3)
    ).
    IF lt_keys_3 IS NOT INITIAL.
      APPEND LINES OF lt_keys_3 TO et_keys.

      "Get ghi chú 3
      get_ghichu_3( EXPORTING it_keys_3   = lt_keys_3
                    IMPORTING et_ghichu_3 = DATA(lt_ghichu_3) ).
      IF lt_ghichu_3 IS NOT INITIAL.
        APPEND LINES OF lt_ghichu_3 TO et_ghichu.
      ENDIF.
    ENDIF.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Case 4:
    "   Từ A3 --> InvoiceNo của A3 = tất cả các originalInvoiceId và Return Inv <> 1 của bảng Header
    "   zi_hhdv_item: selection = (1,0), lineNumber <> 0
    get_keys_4(
      EXPORTING
        ir_kybaocao    = ir_kybaocao
        ir_companycode = ir_companycode
        ir_sohd        = ir_sohd
        ir_thuesuat    = ir_thuesuat
        ir_chungtu     = ir_chungtu
        ir_customer    = ir_customer
        it_keys_3      = lt_keys_3
      IMPORTING
        et_keys_4      = DATA(lt_keys_4)
    ).
    IF lt_keys_4 IS NOT INITIAL.
      APPEND LINES OF lt_keys_4 TO et_keys.

      "Get ghi chú 4
      get_ghichu_4( EXPORTING it_keys_4   = lt_keys_4
                    IMPORTING et_ghichu_4 = DATA(lt_ghichu_4) ).
      IF lt_ghichu_4 IS NOT INITIAL.
        APPEND LINES OF lt_ghichu_4 TO et_ghichu.
      ENDIF.
    ENDIF.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Case 5:
    "   zi_hhdv_head: AdjustmentType in (5,9), ReturnInv = 1, IssueDateStr = lr_kybaocao
    "   zi_hhdv_item: Selection in (1,0), LineNumber <> 0
    get_keys_5(
      EXPORTING
        ir_kybaocao    = ir_kybaocao
        ir_companycode = ir_companycode
        ir_sohd        = ir_sohd
        ir_thuesuat    = ir_thuesuat
        ir_chungtu     = ir_chungtu
        ir_customer    = ir_customer
      IMPORTING
        et_keys_5      = DATA(lt_keys_5)
    ).
    IF lt_keys_5 IS NOT INITIAL.
      APPEND LINES OF lt_keys_5 TO et_keys.

      "Get ghi chú 5
      get_ghichu_5( EXPORTING it_keys_5   = lt_keys_5
                    IMPORTING et_ghichu_5 = DATA(lt_ghichu_5) ).
      IF lt_ghichu_5 IS NOT INITIAL.
        APPEND LINES OF lt_ghichu_5 TO et_ghichu.
      ENDIF.
    ENDIF.
  ENDMETHOD.




























  METHOD get_keys_1.
    "Case 1: filter
    "   zi_hhdv_head: AdjustmentType = 1, InvoiceStatus = null, IssueDateStr = lr_kybaocao
    "   zi_hhdv_item: Selection in (1,0), LineNumber <> 0
    SELECT FROM zi_hhdv_head AS a
    INNER JOIN zi_auth_hhdv AS b
        ON b~SupplierTaxCode = a~SupplierTaxCode
    LEFT JOIN zi_hhdv_item AS c
        ON c~InvoiceId = a~InvoiceId
    FIELDS
        a~InvoiceId,

        b~CompanyCode,
        a~TemplateCode AS KyHieuMauHoaDon,
        a~InvoiceSeri AS KyHieuHD,
        a~InvoiceNumber AS SoHD,
        c~LineNumber AS EINVLineItem
    WHERE
        a~AdjustmentType = '1'
        AND a~InvoiceStatus IS INITIAL
        AND a~IssueDateStr IN @ir_kybaocao
        AND c~Selection IN ( '1','0' )
        AND c~LineNumber <> '0'

        AND b~CompanyCode   IN @ir_companycode
        AND a~InvoiceNumber IN @ir_sohd
        AND c~VatPercentage IN @ir_thuesuat
*        and ... filter field chứng từ
*        and ... filter field customer
    GROUP BY
        a~InvoiceId,
        b~CompanyCode,
        a~TemplateCode,
        a~InvoiceSeri,
        a~InvoiceNumber,
        c~LineNumber
    INTO TABLE @et_keys_1.
  ENDMETHOD.




























  METHOD get_keys_2.
    "Case 2: filter
    "   1. zi_hhdv_head: AdjustmentType = 1, InvoiceStatus = 0, IssueDateStr = lr_kybaocao
    SELECT FROM zi_hhdv_head AS a
    INNER JOIN zi_auth_hhdv AS b
        ON b~SupplierTaxCode = a~SupplierTaxCode
    FIELDS
        b~CompanyCode,
        a~InvoiceId,
        a~InvoiceNo
    WHERE
        a~AdjustmentType = '1'
        AND a~InvoiceStatus = '0'
        AND a~IssueDateStr IN @ir_kybaocao
    INTO TABLE @DATA(lt_a).
    CHECK lt_a IS NOT INITIAL.

    "   2. Từ lt_a --> lọc
    "   zi_hhdv_head: InvoiceNo của A = tất cả các originalInvoiceId của bảng Header
    "   zi_hhdv_item: Selection in (1,0), LineNumber <> 0
    SELECT FROM @lt_a AS a
    INNER JOIN zi_hhdv_head AS b
        ON b~OriginalInvoiceId = a~InvoiceNo
    LEFT JOIN zi_hhdv_item AS c
        ON c~InvoiceId = a~InvoiceId
    FIELDS
        b~InvoiceId,

        a~CompanyCode,
        b~TemplateCode AS KyHieuMauHoaDon,
        b~InvoiceSeri AS KyHieuHD,
        b~InvoiceNumber AS SoHD,
        c~LineNumber AS EINVLineItem
    WHERE
        c~Selection IN ( '1','0' )
        AND c~LineNumber <> '0'

        AND a~CompanyCode   IN @ir_companycode
        AND b~InvoiceNumber IN @ir_sohd
        AND c~VatPercentage IN @ir_thuesuat
*        and ... filter field chứng từ
*        and ... filter field customer
    GROUP BY
        b~InvoiceId,
        a~CompanyCode,
        b~TemplateCode,
        b~InvoiceSeri,
        b~InvoiceNumber,
        c~LineNumber
    INTO TABLE @et_keys_2.
  ENDMETHOD.











































  METHOD get_keys_3.
    "Case 3: filter
    "   zi_hhdv_head: AdjustmentType = 1, InvoiceStatus = 1, IssueDateStr = lr_kybaocao
    SELECT FROM zi_hhdv_head AS a
    INNER JOIN zi_auth_hhdv AS b
        ON b~SupplierTaxCode = a~SupplierTaxCode
    LEFT JOIN zi_hhdv_item AS c
        ON c~InvoiceId = a~InvoiceId
    FIELDS
        a~InvoiceId,
        b~CompanyCode,
        a~TemplateCode AS KyHieuMauHoaDon,
        a~InvoiceSeri AS KyHieuHD,
        a~InvoiceNumber AS SoHD,
        c~LineNumber AS EINVLineItem
    WHERE
        a~AdjustmentType = '1'
        AND a~InvoiceStatus = '1'
        AND a~IssueDateStr IN @ir_kybaocao

        AND b~CompanyCode   IN @ir_companycode
        AND a~InvoiceNumber IN @ir_sohd
        AND c~VatPercentage IN @ir_thuesuat
*        and ... filter field chứng từ
*        and ... filter field customer
    GROUP BY
        a~InvoiceId,
        b~CompanyCode,
        a~TemplateCode,
        a~InvoiceSeri,
        a~InvoiceNumber,
        c~LineNumber
    INTO TABLE @et_keys_3.
  ENDMETHOD.






























  METHOD get_invoice_key.
    " KyHieuMauHoaDon : 1 tý tự đầu
    " KyHieuHD:
    " #
    " SoHD: (Không lấy ký tự 0 ở đầu + không lấy dấu -) (chỉ lấy từ số đầu tiên khác 0 và không lấy ký tự khác số)
    DATA(lv_KyHieuMauHoaDon_clean) = COND string( WHEN iv_kyhieumauhoadon IS NOT INITIAL
                                                  THEN iv_kyhieumauhoadon+0(1)
                                                  ELSE '' ).
    DATA(lv_sohd_clean) = CONV string( iv_sohd ).
    "Bỏ toàn bộ ký tự không phải số (bao gồm dấu "-")
    REPLACE ALL OCCURRENCES OF REGEX '[^0-9]' IN lv_sohd_clean WITH ''.
    "Bỏ các số 0 ở đầu, chỉ giữ lại từ số khác 0 đầu tiên
    REPLACE ALL OCCURRENCES OF REGEX '^0+' IN lv_sohd_clean WITH ''.
    rv_invoicekey = |{ lv_KyHieuMauHoaDon_clean }{ iv_kyhieuhd }#{ lv_sohd_clean }|.
  ENDMETHOD.



























  METHOD get_bases.
    SELECT FROM @it_keys AS a
    LEFT JOIN zi_hhdv_head AS b
        ON b~InvoiceId  = a~invoiceid
    LEFT JOIN zi_hhdv_item AS c
        ON c~InvoiceId   = a~invoiceid
        AND c~LineNumber = a~einvlineitem
    FIELDS
        "key fields
        a~invoiceid,
        a~companycode,
        a~kyhieumauhoadon,
        a~kyhieuhd,
        a~sohd,
        a~einvlineitem,

        "Base normal fields
        b~InvoiceNo,
        b~IssueDateStr,
        b~BuyerUnitName AS TenDVKHang,
        b~BuyerTaxCode AS MaSoThue,
        c~ItemName AS TenHang,
        c~Currency,
        c~ItemTotalAmtWithoutVat AS DoanhSoTransCur_Raw,
        b~ExchangeRate AS TyGia,
        c~VatPercentage AS ThueSuat,
        c~VatAmount AS ThueGTGTTransCur_Raw,
        c~ItemTotalAmtWithVat AS TongCongTransCur_Raw,

        "Invoice Key
        CAST( ' ' AS CHAR( 100 ) ) AS InvoiceKey,

        "Chứng từ
        CAST( ' ' AS CHAR( 10 ) ) AS ChungTu,

        "Ngày
        CAST(
            concat(
                substring( b~IssueDateStr, 1, 4 ),
                concat(
                    substring( b~IssueDateStr, 6, 2 ),
                    substring( b~IssueDateStr, 9, 2 )
                )
            ) AS DATS
        ) AS Ngay

    INTO TABLE @et_bases.

    "Get các data cần thiết của lt_bases
    LOOP AT et_bases ASSIGNING FIELD-SYMBOL(<lfs_bases>).
      <lfs_bases>-InvoiceKey = get_invoice_key(
                                 iv_kyhieumauhoadon = <lfs_bases>-kyhieumauhoadon
                                 iv_kyhieuhd        = <lfs_bases>-kyhieuhd
                                 iv_sohd            = <lfs_bases>-sohd
                               ).
    ENDLOOP.
  ENDMETHOD.
































  METHOD get_keys_result.
    cs_result-InvoiceId       = is_key-invoiceid.
    cs_result-CompanyCode     = is_key-companycode.
    cs_result-KyHieuMauHoaDon = is_key-kyhieumauhoadon.
    cs_result-KyHieuHD        = is_key-kyhieuhd.
    cs_result-SoHD            = |{ is_key-sohd ALPHA = OUT }|.
    cs_result-EINVLineItem    = is_key-einvlineitem.
  ENDMETHOD.




































  METHOD get_normal_base_result.
    cs_result-TenDVKHang = is_base-tendvkhang.
    cs_result-MaSoThue   = is_base-masothue.
    cs_result-TenHang    = is_base-tenhang.
    cs_result-Currency   = is_base-Currency.
    cs_result-ThueSuat   = is_base-thuesuat.
    cs_result-InvoiceKey = is_base-invoicekey.
    cs_result-Ngay       = is_base-ngay.
  ENDMETHOD.































  METHOD get_decimals_base_result.
    DATA: lv_doanhso_raw  TYPE p LENGTH 12 DECIMALS 5,
          lv_thuegtgt_raw TYPE p LENGTH 12 DECIMALS 5,
          lv_tongcong_raw TYPE p LENGTH 12 DECIMALS 5.

    "Doanh số (Trans Cur)
    READ TABLE it_acct_doc INTO DATA(ls_tkdu) WITH KEY invoiceid       = is_base-invoiceid
                                                       companycode     = is_base-companycode
                                                       kyhieumauhoadon = is_base-kyhieumauhoadon
                                                       kyhieuhd        = is_base-kyhieuhd
                                                       sohd            = is_base-sohd
                                                       einvlineitem    = is_base-einvlineitem.
    IF sy-subrc = 0.
      IF ls_tkdu-tkdu CP '6*'.
      ELSE.
        cs_result-DoanhSoTransCur = is_base-doanhsotranscur_raw.
      ENDIF.
    ENDIF.

    "Doanh số
    lv_doanhso_raw = cs_result-DoanhSoTransCur * cs_result-tygia.
    cs_result-DoanhSo = lv_doanhso_raw.

    "Thuế GTGT (Trans Cur)
    cs_result-ThueGTGTTransCur = is_base-thuegtgttranscur_raw.

    "Thuế GTGT
    lv_thuegtgt_raw = is_base-thuegtgttranscur_raw * cs_result-tygia.
    cs_result-ThueGTGT = lv_thuegtgt_raw.

    "Tổng cộng (Trans Cur)
    cs_result-TongCongTransCur = is_base-tongcongtranscur_raw.

    "Tổng cộng
    lv_tongcong_raw = lv_doanhso_raw + lv_thuegtgt_raw.
    cs_result-TongCong = lv_tongcong_raw.

    "Ngoại tê
    IF cs_result-Currency <> 'VND'.
      cs_result-NgoaiTe = cs_result-DoanhSoTransCur.
    ENDIF.
  ENDMETHOD.





























  METHOD get_acct_doc.
    CHECK it_bases IS NOT INITIAL.

    SELECT FROM @it_bases AS a
    LEFT JOIN I_JournalEntry AS b
      ON b~CompanyCode = a~companycode
      AND b~DocumentReferenceID = a~invoicekey
      AND b~FiscalYear = substring( a~Ngay, 1, 4 )
      AND b~PostingDate = a~Ngay
      AND b~IsReversal IS INITIAL
      AND b~IsReversed IS INITIAL
    LEFT JOIN I_AccountingDocumentJournal( p_language = @sy-langu ) AS c
      ON c~CompanyCode = a~companycode
      AND c~AccountingDocument = b~AccountingDocument
      AND c~Ledger = '0L'
      AND c~FiscalYear = substring( a~Ngay, 1, 4 )
    LEFT JOIN I_BusinessUserBasic AS d
        ON d~UserID = b~AccountingDocCreatedByUser
    FIELDS
      "Key fields
      a~invoiceid,
      a~companycode,
      a~kyhieumauhoadon,
      a~kyhieuhd,
      a~sohd,
      a~einvlineitem,

      CASE WHEN c~OffsettingAccount = '3331001000' THEN b~AccountingDocument ELSE ' ' END AS ChungTu,
      CASE WHEN c~OffsettingAccount = '3331001000' THEN c~OffsettingAccount  ELSE ' ' END AS tk,
      CASE WHEN c~OffsettingAccount = '3331001000' THEN c~GLAccount          ELSE ' ' END AS tkdu,
      CASE WHEN c~OffsettingAccount = '3331001000' THEN d~PersonFullName     ELSE ' ' END AS UserHachToan,

      c~AccountingDocumentType
    INTO TABLE @et_acct_doc.
  ENDMETHOD.




























  METHOD get_longtext_fields.
    IF it_bases IS NOT INITIAL.
      "1. Lấy raw data của billing
      SELECT FROM @it_bases AS a
      LEFT JOIN I_JournalEntry AS b
        ON b~CompanyCode = a~companycode
        AND b~DocumentReferenceID = a~invoicekey
        AND b~FiscalYear = substring( a~Ngay, 1, 4 )
        AND b~PostingDate = a~Ngay
        AND b~IsReversal IS INITIAL
        AND b~IsReversed IS INITIAL
      LEFT JOIN I_AccountingDocumentJournal( p_language = @sy-langu ) AS c
        ON c~CompanyCode = a~companycode
        AND c~AccountingDocument = b~AccountingDocument
        AND c~Ledger = '0L'
        AND c~FiscalYear = substring( a~Ngay, 1, 4 )
      FIELDS
        "Key fields
        a~invoiceid,
        a~companycode,
        a~kyhieumauhoadon,
        a~kyhieuhd,
        a~sohd,
        a~einvlineitem,

        c~ReferenceDocument AS BillingDocument
      WHERE
        c~AccountingDocumentType = 'RV'
      INTO TABLE @et_billing.

      "2. Lấy longtext ID của billing
      IF et_billing IS NOT INITIAL.
        SELECT FROM @et_billing AS a
        INNER JOIN I_BillingDocumentTextTP AS b
            ON b~BillingDocument = a~billingdocument
            AND b~LongTextID = 'Z020'   "Số tờ khai
        FIELDS
            "Key fields header
            a~invoiceid,
            a~companycode,
            a~kyhieumauhoadon,
            a~kyhieuhd,
            a~sohd,
            a~einvlineitem,

            "Key fields item
            a~billingdocument,

            "API Fields
            b~Language,
            b~LongTextID
        INTO TABLE @et_longtext_id.

        IF et_longtext_id IS NOT INITIAL.
          READ ENTITIES OF i_billingdocumenttp FORWARDING PRIVILEGED
          ENTITY billingdocumenttext
          FIELDS ( billingdocument
                   language
                   longtextid
                   longtext )
          WITH VALUE #( FOR ls_getbilllong IN et_longtext_id
              ( %key-BillingDocument = ls_getbilllong-BillingDocument
                %key-LongTextID = ls_getbilllong-LongTextID
                %key-Language = ls_getbilllong-Language
              )
          )
          RESULT et_billingtexts_h
          FAILED DATA(lt_failed).
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.



























  METHOD get_acct_doc_result.
    READ TABLE it_acct_doc INTO DATA(ls_acct_doc) WITH KEY  invoiceid       = is_key-invoiceid
                                                            companycode     = is_key-companycode
                                                            kyhieumauhoadon = is_key-kyhieumauhoadon
                                                            kyhieuhd        = is_key-kyhieuhd
                                                            sohd            = is_key-sohd
                                                            einvlineitem    = is_key-einvlineitem.
    IF sy-subrc = 0.
      cs_result-ChungTu      = |{ ls_acct_doc-ChungTu ALPHA = IN }|.
      cs_result-tk           = ls_acct_doc-tk.
      cs_result-tkdu         = ls_acct_doc-tkdu.
      cs_result-UserHachToan = ls_acct_doc-userhachtoan.
    ENDIF.
  ENDMETHOD.

































  METHOD get_longtext_result.
    READ TABLE it_billing INTO DATA(ls_billing) WITH KEY invoiceid       = is_key-invoiceid
                                                         companycode     = is_key-companycode
                                                         kyhieumauhoadon = is_key-kyhieumauhoadon
                                                         kyhieuhd        = is_key-kyhieuhd
                                                         sohd            = is_key-sohd
                                                         einvlineitem    = is_key-einvlineitem.
    IF sy-subrc = 0.
      READ TABLE it_longtext_id INTO DATA(ls_longtext_id) WITH KEY invoiceid       = is_key-invoiceid
                                                                   companycode     = is_key-companycode
                                                                   kyhieumauhoadon = is_key-kyhieumauhoadon
                                                                   kyhieuhd        = is_key-kyhieuhd
                                                                   sohd            = is_key-sohd
                                                                   einvlineitem    = is_key-einvlineitem

                                                                   billingdocument = ls_billing-billingdocument
                                                                   Language        = sy-langu.
      IF sy-subrc = 0.
        READ TABLE it_billingtexts_h INTO DATA(ls_billingtexts_h)
            WITH KEY entity
            COMPONENTS %key-BillingDocument = ls_longtext_id-billingdocument
                       %key-Language        = sy-langu
                       %key-LongTextID      = 'Z020'.
        IF sy-subrc = 0.
          cs_result-SoToKhai = ls_billingtexts_h-LongText.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


























  METHOD get_keys_4.
    DATA: lr_invoiceno TYPE RANGE OF zi_hhdv_head-InvoiceNo,
          lr_sohd      TYPE zcl_ce_hhdv_rp_top=>ry_string,
          lr_thuesuat  TYPE zcl_ce_hhdv_rp_top=>ry_string,
          lr_chungtu   TYPE zcl_ce_hhdv_rp_top=>ry_string,
          lr_customer  TYPE zcl_ce_hhdv_rp_top=>ry_string.

    get_keys_3(
      EXPORTING
        ir_kybaocao    = ir_kybaocao
        ir_companycode = ir_companycode
        ir_sohd        = lr_sohd
        ir_thuesuat    = lr_thuesuat
        ir_chungtu     = lr_chungtu
        ir_customer    = lr_customer
      IMPORTING
        et_keys_3      = DATA(lt_keys_3)
    ).
    CHECK lt_keys_3 IS NOT INITIAL.

    SELECT FROM @lt_keys_3 AS a
    LEFT JOIN zi_hhdv_head AS b
        ON b~InvoiceId = a~invoiceid
    FIELDS
        "key fields
        a~invoiceid,
        a~companycode,
        a~kyhieumauhoadon,
        a~kyhieuhd,
        a~sohd,
        a~einvlineitem,

        "join field
        b~InvoiceNo
    INTO TABLE @DATA(lt_temp_keys_3).

    CHECK lt_temp_keys_3 IS NOT INITIAL.

    SORT lt_temp_keys_3 BY InvoiceNo.
    DELETE ADJACENT DUPLICATES FROM lt_temp_keys_3 COMPARING InvoiceNo.

    LOOP AT lt_temp_keys_3 INTO DATA(ls_temp_keys_3).
      APPEND INITIAL LINE TO lr_invoiceno ASSIGNING FIELD-SYMBOL(<lfs_invoiceno>).
      <lfs_invoiceno>-sign   = 'I'.
      <lfs_invoiceno>-option = 'EQ'.
      <lfs_invoiceno>-low    = ls_temp_keys_3-InvoiceNo.
    ENDLOOP.

    CHECK lr_invoiceno IS NOT INITIAL.

    SELECT FROM zi_hhdv_head AS a
    INNER JOIN zi_auth_hhdv AS b
        ON b~SupplierTaxCode = a~SupplierTaxCode
    LEFT JOIN zi_hhdv_item AS c
        ON c~InvoiceId = a~InvoiceId
    FIELDS
        a~InvoiceId,
        b~CompanyCode,
        a~TemplateCode AS KyHieuMauHoaDon,
        a~InvoiceSeri AS KyHieuHD,
        a~InvoiceNumber AS SoHD,
        c~LineNumber AS EINVLineItem
    WHERE
        a~OriginalInvoiceId IN @lr_invoiceno
        AND a~ReturnInv <> '1'
        AND c~Selection IN ( '1','0' )
        AND c~LineNumber <> '0'

        AND b~CompanyCode   IN @ir_companycode
        AND a~InvoiceNumber IN @ir_sohd
        AND c~VatPercentage IN @ir_thuesuat
*              and ... filter field chứng từ
*              and ... filter field customer
    GROUP BY
        a~InvoiceId,
        b~CompanyCode,
        a~TemplateCode,
        a~InvoiceSeri,
        a~InvoiceNumber,
        c~LineNumber
    INTO TABLE @et_keys_4.
  ENDMETHOD.









































  METHOD get_exchange_rate.
    CHECK it_bases IS NOT INITIAL.

    SELECT FROM @it_bases AS a
    INNER JOIN zi_hhdv_head AS b
        ON b~InvoiceId = a~invoiceid
        AND b~AdjustmentType = '1'
        AND b~InvoiceStatus = '1'
    FIELDS
        "key fields
        a~invoiceid,
        a~companycode,
        a~kyhieumauhoadon,
        a~kyhieuhd,
        a~sohd,
        a~einvlineitem,

        "join field
        b~InvoiceNo,

        "Others
        b~ExchangeRate
    INTO TABLE @DATA(lt_temp_bases).

    DATA: lr_invoiceno       TYPE RANGE OF zi_hhdv_head-InvoiceNo.

    SORT lt_temp_bases BY InvoiceNo.
    DELETE ADJACENT DUPLICATES FROM lt_temp_bases COMPARING InvoiceNo.

    CHECK lt_temp_bases IS NOT INITIAL.
    LOOP AT lt_temp_bases INTO DATA(ls_temp_bases).
      APPEND INITIAL LINE TO lr_invoiceno ASSIGNING FIELD-SYMBOL(<lfs_invoiceno>).
      <lfs_invoiceno>-sign = 'I'.
      <lfs_invoiceno>-option = 'EQ'.
      <lfs_invoiceno>-low = ls_temp_bases-invoiceno.
    ENDLOOP.

    SELECT FROM zi_hhdv_head AS a
    INNER JOIN zi_auth_hhdv AS b
        ON b~SupplierTaxCode = a~SupplierTaxCode
    LEFT JOIN @lt_temp_bases AS c
        ON c~InvoiceNo = a~OriginalInvoiceId
    FIELDS
        "Key fields
        c~InvoiceId,
        c~CompanyCode,
        c~KyHieuMauHoaDon,
        c~KyHieuHD,
        c~SoHD,

        a~IssueDateStr,
        a~ExchangeRate
    WHERE
       a~OriginalInvoiceId IN @lr_invoiceno
       AND a~AdjustmentType IN ( '5','9' )
       AND a~ReturnInv <> '1'
    INTO TABLE @et_exchangerate.

    CHECK et_exchangerate IS NOT INITIAL.

    SORT et_exchangerate BY InvoiceId
                            IssueDateStr DESCENDING.
    DELETE ADJACENT DUPLICATES FROM et_exchangerate COMPARING InvoiceId.
  ENDMETHOD.

































  METHOD get_tygia_result.
    READ TABLE it_exchangerate INTO DATA(ls_exchangerate) WITH KEY invoiceid       = is_base-invoiceid
                                                                   companycode     = is_base-companycode
                                                                   kyhieumauhoadon = is_base-kyhieumauhoadon
                                                                   kyhieuhd        = is_base-kyhieuhd
                                                                   sohd            = is_base-sohd.
    IF sy-subrc = 0.
      cs_result-TyGia = ls_exchangerate-exchangerate.
    ELSE.
      cs_result-TyGia = is_base-tygia.
    ENDIF.
  ENDMETHOD.


























  METHOD get_ghichu_2.
    CHECK it_keys_2 IS NOT INITIAL.

    SELECT FROM @it_keys_2 AS a
    LEFT JOIN zi_hhdv_head AS b
      ON b~InvoiceId = a~invoiceid
    FIELDS
      "Key fields
      b~invoiceid,
      a~companycode,
      a~kyhieumauhoadon,
      a~kyhieuhd,
      a~sohd,
      a~einvlineitem,

      b~OriginalInvoiceId,
      b~invoiceno AS chungtugoc
    INTO TABLE @DATA(lt_temp_keys_2).

*    SORT lt_temp_keys_2 BY OriginalInvoiceId.
*    DELETE ADJACENT DUPLICATES FROM lt_temp_keys_2 COMPARING OriginalInvoiceId.

    DATA: lr_invoiceno TYPE RANGE OF zi_hhdv_head-InvoiceNo.
    LOOP AT lt_temp_keys_2 INTO DATA(ls_temp_keys_2).
      APPEND INITIAL LINE TO lr_invoiceno ASSIGNING FIELD-SYMBOL(<lfs_invoiceno>).
      <lfs_invoiceno>-sign = 'I'.
      <lfs_invoiceno>-option = 'EQ'.
      <lfs_invoiceno>-low = ls_temp_keys_2-OriginalInvoiceId.
    ENDLOOP.

    CHECK lr_invoiceno IS NOT INITIAL.

    SELECT FROM @lt_temp_keys_2 AS a
    LEFT JOIN zi_hhdv_head AS b
        ON b~invoiceno = a~OriginalInvoiceId
    FIELDS
        "key fields
        a~invoiceid,
        a~companycode,
        a~kyhieumauhoadon,
        a~kyhieuhd,
        a~sohd,
        a~einvlineitem,

        a~chungtugoc,
        b~invoiceno AS ChungTuDieuChinh,
        b~IssueDateStr,

        CAST( '2' AS NUMC( 1 ) ) AS case
    WHERE
        b~invoiceno IN @lr_invoiceno
    INTO TABLE @et_ghichu_2.

  ENDMETHOD.


































  METHOD get_ghichu_result.
    DATA: lv_dieuchinh_text TYPE string.

    LOOP AT it_ghichu INTO DATA(ls_ghichu) WHERE invoiceid           = is_key-invoiceid
                                                 AND companycode     = is_key-companycode
                                                 AND kyhieumauhoadon = is_key-kyhieumauhoadon
                                                 AND kyhieuhd        = is_key-kyhieuhd
                                                 AND sohd            = is_key-sohd
                                                 AND einvlineitem    = is_key-einvlineitem.


      CASE ls_ghichu-case.
        WHEN '2'.   "Case 2
          cs_result-GhiChu = |TT cho HĐ { ls_ghichu-chungtudieuchinh } |
                             && |ngày { ls_ghichu-issuedatestr+8(2) }/|
                             && |{ ls_ghichu-issuedatestr+5(2) }/|
                             && |{ ls_ghichu-issuedatestr+0(4) }|.
        WHEN '3'. "Case 3
          lv_dieuchinh_text = COND #( WHEN lv_dieuchinh_text IS INITIAL
                                      THEN |Bị ĐC bởi HĐ { ls_ghichu-chungtudieuchinh } |
                                           && |ngày { ls_ghichu-issuedatestr+8(2) }/|
                                           && |{ ls_ghichu-issuedatestr+5(2) }/|
                                           && |{ ls_ghichu-issuedatestr+0(4) }|
                                      ELSE |{ lv_dieuchinh_text }, |
                                           && |HĐ { ls_ghichu-chungtudieuchinh } |
                                           && |ngày { ls_ghichu-issuedatestr+8(2) }/|
                                           && |{ ls_ghichu-issuedatestr+5(2) }/|
                                           && |{ ls_ghichu-issuedatestr+0(4) }|
          ).
          cs_result-GhiChu = lv_dieuchinh_text.
        WHEN '4' OR '5'.   "Case 4 + 5
          cs_result-GhiChu = |ĐC cho HĐ { ls_ghichu-chungtudieuchinh } |
                             && |ngày { ls_ghichu-issuedatestr+8(2) }/|
                             && |{ ls_ghichu-issuedatestr+5(2) }/|
                             && |{ ls_ghichu-issuedatestr+0(4) }|.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.








































  METHOD get_ghichu_3.
    SELECT FROM @it_keys_3 AS a
    LEFT JOIN zi_hhdv_head AS b
      ON b~InvoiceId = a~invoiceid
    FIELDS
      "Key fields
      b~invoiceid,
      a~companycode,
      a~kyhieumauhoadon,
      a~kyhieuhd,
      a~sohd,
      a~einvlineitem,

      b~invoiceno AS chungtugoc
    INTO TABLE @DATA(lt_temp_keys_3).

    DATA: lr_originalinvoiceid TYPE RANGE OF zi_hhdv_head-OriginalInvoiceId.

    CHECK lt_temp_keys_3 IS NOT INITIAL.
    LOOP AT lt_temp_keys_3 INTO DATA(ls_temp_keys_3).
      APPEND INITIAL LINE TO lr_originalinvoiceid ASSIGNING FIELD-SYMBOL(<lfs_originalinvoiceid>).
      <lfs_originalinvoiceid>-sign = 'I'.
      <lfs_originalinvoiceid>-option = 'EQ'.
      <lfs_originalinvoiceid>-low = ls_temp_keys_3-chungtugoc.
    ENDLOOP.

    SELECT FROM @lt_temp_keys_3 AS a
    LEFT JOIN zi_hhdv_head AS b
        ON b~OriginalInvoiceId = a~chungtugoc
    FIELDS
        "key fields
        a~invoiceid,
        a~companycode,
        a~kyhieumauhoadon,
        a~kyhieuhd,
        a~sohd,
        a~einvlineitem,

        a~chungtugoc,
        b~invoiceno AS ChungTuDieuChinh,
        b~IssueDateStr,

        CAST( '3' AS NUMC( 1 ) ) AS case
    WHERE
        b~OriginalInvoiceId IN @lr_originalinvoiceid
        AND b~AdjustmentType IN ( '5','9' )
    INTO TABLE @et_ghichu_3.
  ENDMETHOD.
































  METHOD get_ghichu_4.
    SELECT FROM @it_keys_4 AS a
    LEFT JOIN zi_hhdv_head AS b
      ON b~InvoiceId = a~invoiceid
    FIELDS
      "Key fields
      b~invoiceid,
      a~companycode,
      a~kyhieumauhoadon,
      a~kyhieuhd,
      a~sohd,
      a~einvlineitem,

      b~OriginalInvoiceId,
      b~invoiceno AS chungtugoc
    INTO TABLE @DATA(lt_temp_keys_4).

    DATA: lr_invoiceno TYPE RANGE OF zi_hhdv_head-InvoiceNo.
    LOOP AT lt_temp_keys_4 INTO DATA(ls_temp_keys_4).
      APPEND INITIAL LINE TO lr_invoiceno ASSIGNING FIELD-SYMBOL(<lfs_invoiceno>).
      <lfs_invoiceno>-sign = 'I'.
      <lfs_invoiceno>-option = 'EQ'.
      <lfs_invoiceno>-low = ls_temp_keys_4-OriginalInvoiceId.
    ENDLOOP.

    CHECK lr_invoiceno IS NOT INITIAL.

    SELECT FROM @lt_temp_keys_4 AS a
    LEFT JOIN zi_hhdv_head AS b
        ON b~invoiceno = a~OriginalInvoiceId
    FIELDS
        "key fields
        a~invoiceid,
        a~companycode,
        a~kyhieumauhoadon,
        a~kyhieuhd,
        a~sohd,
        a~einvlineitem,

        a~chungtugoc,
        b~invoiceno AS ChungTuDieuChinh,
        b~IssueDateStr,

        CAST( '4' AS NUMC( 1 ) ) AS case
    WHERE
        b~invoiceno IN @lr_invoiceno
    INTO TABLE @et_ghichu_4.
  ENDMETHOD.





























  METHOD get_keys_5.
    SELECT FROM zi_hhdv_head AS a
    INNER JOIN zi_auth_hhdv AS b
        ON b~SupplierTaxCode = a~SupplierTaxCode
    LEFT JOIN zi_hhdv_item AS c
        ON c~InvoiceId = a~InvoiceId
    FIELDS
        a~InvoiceId,

        b~CompanyCode,
        a~TemplateCode AS KyHieuMauHoaDon,
        a~InvoiceSeri AS KyHieuHD,
        a~InvoiceNumber AS SoHD,
        c~LineNumber AS EINVLineItem
    WHERE
        a~AdjustmentType IN ( '5','9' )
        AND a~ReturnInv = '1'
        AND a~IssueDateStr IN @ir_kybaocao
        AND c~Selection IN ( '1','0' )
        AND c~LineNumber <> '0'

        AND b~CompanyCode   IN @ir_companycode
        AND a~InvoiceNumber IN @ir_sohd
        AND c~VatPercentage IN @ir_thuesuat
*        and ... filter field chứng từ
*        and ... filter field customer
    GROUP BY
        a~InvoiceId,
        b~CompanyCode,
        a~TemplateCode,
        a~InvoiceSeri,
        a~InvoiceNumber,
        c~LineNumber
    INTO TABLE @et_keys_5.
  ENDMETHOD.




























  METHOD get_ghichu_5.
    SELECT FROM @it_keys_5 AS a
    LEFT JOIN zi_hhdv_head AS b
      ON b~InvoiceId = a~invoiceid
    FIELDS
      "Key fields
      b~invoiceid,
      a~companycode,
      a~kyhieumauhoadon,
      a~kyhieuhd,
      a~sohd,
      a~einvlineitem,

      b~OriginalInvoiceId,
      b~invoiceno AS chungtugoc
    INTO TABLE @DATA(lt_temp_keys_5).

    DATA: lr_invoiceno TYPE RANGE OF zi_hhdv_head-InvoiceNo.
    LOOP AT lt_temp_keys_5 INTO DATA(ls_temp_keys_5).
      APPEND INITIAL LINE TO lr_invoiceno ASSIGNING FIELD-SYMBOL(<lfs_invoiceno>).
      <lfs_invoiceno>-sign = 'I'.
      <lfs_invoiceno>-option = 'EQ'.
      <lfs_invoiceno>-low = ls_temp_keys_5-OriginalInvoiceId.
    ENDLOOP.

    CHECK lr_invoiceno IS NOT INITIAL.

    SELECT FROM @lt_temp_keys_5 AS a
    LEFT JOIN zi_hhdv_head AS b
        ON b~invoiceno = a~OriginalInvoiceId
    FIELDS
        "key fields
        a~invoiceid,
        a~companycode,
        a~kyhieumauhoadon,
        a~kyhieuhd,
        a~sohd,
        a~einvlineitem,

        a~chungtugoc,
        b~invoiceno AS ChungTuDieuChinh,
        b~IssueDateStr,

        CAST( '5' AS NUMC( 1 ) ) AS case
    WHERE
        b~invoiceno IN @lr_invoiceno
    INTO TABLE @et_ghichu_5.
  ENDMETHOD.































  METHOD get_customer.
    CHECK it_bases IS NOT INITIAL.

    SELECT FROM @it_bases AS a
    LEFT JOIN I_JournalEntry AS b
      ON b~CompanyCode = a~companycode
      AND b~DocumentReferenceID = a~invoicekey
      AND b~FiscalYear = substring( a~Ngay, 1, 4 )
      AND b~PostingDate = a~Ngay
      AND b~IsReversal IS INITIAL
      AND b~IsReversed IS INITIAL
    LEFT JOIN I_AccountingDocumentJournal( p_language = @sy-langu ) AS c
      ON c~CompanyCode = a~companycode
      AND c~AccountingDocument = b~AccountingDocument
      AND c~Ledger = '0L'
      AND c~FiscalYear = substring( a~Ngay, 1, 4 )
    FIELDS
      "Key fields
      a~invoiceid,
      a~companycode,
      a~kyhieumauhoadon,
      a~kyhieuhd,
      a~sohd,
      a~einvlineitem,

      MAX( c~Customer ) AS Customer
    GROUP BY
      a~invoiceid,
      a~companycode,
      a~kyhieumauhoadon,
      a~kyhieuhd,
      a~sohd,
      a~einvlineitem
    INTO TABLE @et_customer.
  ENDMETHOD.




























  METHOD get_customer_result.
    DATA: lv_customer_name TYPE string.

    READ TABLE it_customer INTO DATA(ls_customer) WITH KEY invoiceid       = is_key-invoiceid
                                                           companycode     = is_key-companycode
                                                           kyhieumauhoadon = is_key-kyhieumauhoadon
                                                           kyhieuhd        = is_key-kyhieuhd
                                                           sohd            = is_key-sohd
                                                           einvlineitem    = is_key-einvlineitem.
    IF sy-subrc = 0.
      cs_result-Customer = ls_customer-customer.

      READ TABLE it_customer_name INTO DATA(ls_customer_name) WITH KEY customer = ls_customer-customer.
      IF sy-subrc = 0.
        IF ls_customer_name-organizationbpname2 IS INITIAL
           AND ls_customer_name-organizationbpname3 IS INITIAL
           AND ls_customer_name-organizationbpname4 IS INITIAL.
          lv_customer_name = COND #( WHEN ls_customer_name-organizationbpname1 IS NOT INITIAL
                                     THEN ls_customer_name-organizationbpname1
                                     ELSE ls_customer_name-lastname ).
        ELSE.
          lv_customer_name = |{ ls_customer_name-organizationbpname2 }|
                             && |{ ls_customer_name-organizationbpname3 }|
                             && |{ ls_customer_name-organizationbpname4 }|.
          CONDENSE lv_customer_name.
        ENDIF.

        cs_result-CustomerName = lv_customer_name.
      ENDIF.
    ENDIF.
  ENDMETHOD.


























  METHOD get_customer_name.
    DATA: lr_customer TYPE RANGE OF I_AccountingDocumentJournal-Customer.

    CHECK it_customer IS NOT INITIAL.


    LOOP AT it_customer INTO DATA(ls_customer).
      APPEND INITIAL LINE TO lr_customer ASSIGNING FIELD-SYMBOL(<lfs_customer>).
      <lfs_customer>-sign = 'I'.
      <lfs_customer>-option = 'EQ'.
      <lfs_customer>-low = ls_customer-customer.
    ENDLOOP.

    SELECT FROM I_BusinessPartner AS a
    FIELDS
        "key field
        a~BusinessPartner AS Customer,

        a~OrganizationBPName1,
        a~OrganizationBPName2,
        a~OrganizationBPName3,
        a~OrganizationBPName4,
        a~LastName
    WHERE a~BusinessPartner IN @lr_customer
    INTO TABLE @et_customer_name.
  ENDMETHOD.
























  METHOD build_main.
    "1. Get keys --> chia 5 case
    get_keys(
      EXPORTING
        ir_kybaocao    = ir_kybaocao
        ir_companycode = ir_companycode
        ir_sohd        = ir_sohd
        ir_thuesuat    = ir_thuesuat
        ir_chungtu     = ir_chungtu
        ir_customer    = ir_customer
      IMPORTING
        et_keys        = et_keys
        et_ghichu      = et_ghichu
    ).

    "2. Get bases
    get_bases(
      EXPORTING
        it_keys  = et_keys
      IMPORTING
        et_bases = et_bases
    ).

    "3. Get data của I_JournalEntry refer từ lt_bases
    get_acct_doc(
      EXPORTING
        it_bases    = et_bases
      IMPORTING
        et_acct_doc = et_acct_doc
    ).

    "4. Get data Số Tờ khai
    get_longtext_fields(
      EXPORTING
        it_bases          = et_bases
      IMPORTING
        et_billing        = et_billing
        et_longtext_id    = et_longtext_id
        et_billingtexts_h = et_billingtexts_h
    ).

    "5. Lấy exchange rate gần nhất đối với các chứng từ điều chỉnh
    get_exchange_rate(
      EXPORTING
        it_bases        = et_bases
      IMPORTING
        et_exchangerate = et_exchangerate
    ).

    "6. Get Customer
    get_customer(
      EXPORTING
        it_bases    = et_bases
      IMPORTING
        et_customer = et_customer
    ).

    "7. Get Customer Name
    get_customer_name(
      EXPORTING
        it_customer      = et_customer
      IMPORTING
        et_customer_name = et_customer_name
    ).
  ENDMETHOD.



































  METHOD build_result.
    LOOP AT it_keys INTO DATA(ls_key).
      " Không lấy các line item có AccountingDocumentType = 'DK'
      READ TABLE it_acct_doc INTO DATA(ls_dk) WITH KEY invoiceid       = ls_key-invoiceid
                                                       companycode     = ls_key-companycode
                                                       kyhieumauhoadon = ls_key-kyhieumauhoadon
                                                       kyhieuhd        = ls_key-kyhieuhd
                                                       sohd            = ls_key-sohd
                                                       einvlineitem    = ls_key-einvlineitem.
      IF sy-subrc  = 0.
        IF ls_dk-AccountingDocumentType = 'DK'.
          CONTINUE.
        ENDIF.
      ENDIF.

      APPEND INITIAL LINE TO et_result ASSIGNING FIELD-SYMBOL(<lfs_result>).
      "Key fields
      get_keys_result( EXPORTING is_key    = ls_key
                       CHANGING  cs_result = <lfs_result> ).

      "Base fields
      READ TABLE it_bases INTO DATA(ls_base) WITH KEY invoiceid       = ls_key-invoiceid
                                                      companycode     = ls_key-companycode
                                                      kyhieumauhoadon = ls_key-kyhieumauhoadon
                                                      kyhieuhd        = ls_key-kyhieuhd
                                                      sohd            = ls_key-sohd
                                                      einvlineitem    = ls_key-einvlineitem.
      IF sy-subrc = 0.
        "Normal base fields
        get_normal_base_result( EXPORTING is_base   = ls_base
                                CHANGING  cs_result = <lfs_result> ).

        "Get tỷ giá
        get_tygia_result( EXPORTING it_exchangerate = it_exchangerate
                                    is_base         = ls_base
                          CHANGING  cs_result       = <lfs_result> ).

        "format fields tiền + số lượng
        get_decimals_base_result( EXPORTING it_acct_doc = it_acct_doc
                                            is_base     = ls_base
                                  CHANGING  cs_result   = <lfs_result> ).



      ENDIF.

      "Accounting Doc fields
      get_acct_doc_result( EXPORTING it_acct_doc = it_acct_doc
                                     is_key      = ls_key
                           CHANGING  cs_result   = <lfs_result> ).

      "Số tờ khai - Billing Document - LongTextID = Z020
      get_longtext_result( EXPORTING it_billing        = it_billing
                                     it_longtext_id    = it_longtext_id
                                     it_billingtexts_h = it_billingtexts_h
                                     is_key            = ls_key
                           CHANGING  cs_result         = <lfs_result> ).

      "Ghi chú
      get_ghichu_result( EXPORTING it_ghichu = it_ghichu
                                   is_key    = ls_key
                         CHANGING  cs_result = <lfs_result> ).

      "Customer
      get_customer_result( EXPORTING it_customer      = it_customer
                                     it_customer_name = it_customer_name
                                     is_key           = ls_key
                           CHANGING  cs_result        = <lfs_result> ).

    ENDLOOP.

    "Filter result
    IF et_result IS NOT INITIAL.
      "Filter chứng từ
      IF ir_chungtu IS NOT INITIAL.
        DELETE et_result WHERE ChungTu NOT IN ir_chungtu.
      ENDIF.

      "Filter customer
      IF ir_customer IS NOT INITIAL.
        DELETE et_result WHERE Customer NOT IN ir_customer.
      ENDIF.
    ENDIF.
  ENDMETHOD.


































ENDCLASS.
