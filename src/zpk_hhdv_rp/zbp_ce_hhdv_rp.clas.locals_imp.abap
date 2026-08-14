CLASS lhc_HHDVRP DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR hhdvrp RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ hhdvrp RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK hhdvrp.

    METHODS UdtInvoiceStatus FOR MODIFY
      IMPORTING keys FOR ACTION hhdvrp~UdtInvoiceStatus.

ENDCLASS.

CLASS lhc_HHDVRP IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD UdtInvoiceStatus.
    "Data test:
    "a. Lấy invoice a
    "   adjustment_type = 9
    "   original_invoice_id = C26MGT25
    "b. Lấy invoice b
    "   filter invoice_no = C26MGT25 --> lấy được invoice b

    "1. Get Invoice A có adjustment_type = 3, 5, 9 + nằm trong khoảng thời gian field issue_date_str
    DATA(lv_date_from) = keys[ 1 ]-%param-StartDate.
    DATA(lv_date_to)   = keys[ 1 ]-%param-EndDate.

    " Build boundary string 'yyyy-mm-dd' để so sánh trực tiếp với issue_date_str (ISO string)
    DATA(lv_from_str) = |{ lv_date_from+0(4) }-{ lv_date_from+4(2) }-{ lv_date_from+6(2) }T00:00:00Z|.
    DATA(lv_to_str)   = |{ lv_date_to+0(4) }-{ lv_date_to+4(2) }-{ lv_date_to+6(2) }T23:59:59Z|.

    " (A) - lấy hóa đơn điều chỉnh/thay thế trong khoảng ngày, chỉ quan tâm adjustment_type 3/5/9
    SELECT FROM ztb_hhdv_head
    FIELDS
        invoice_id,
        adjustment_type,
        original_invoice_id
      WHERE issue_date_str    >= @lv_from_str
        AND issue_date_str    <= @lv_to_str
        AND adjustment_type   IN ( '3', '5', '9' )
        AND original_invoice_id <> @space
        AND error_code IN ('INVOICE_HAS_CODE_APPROVED','INVOICE_NO_CODE_APPROVED')
      INTO TABLE @DATA(lt_invoice_a).
    CHECK lt_invoice_a IS NOT INITIAL.

    "2. Get Invoice B với đk B-invoice_no = A-original_invoice_id
    SELECT FROM ztb_hhdv_head
    FIELDS
        invoice_id,
        invoice_no
    FOR ALL ENTRIES IN @lt_invoice_a
    WHERE invoice_no = @lt_invoice_a-original_invoice_id
    INTO TABLE @DATA(lt_invoice_b).
    CHECK lt_invoice_b IS NOT INITIAL.

    "3. Tạo itab mapping invoice_status của A với B
    TYPES: BEGIN OF ty_mapping,
             original_invoice_id TYPE ztb_hhdv_head-original_invoice_id,
             invoice_status_udt  TYPE ztb_hhdv_head-invoice_status,
           END OF ty_mapping,
           tt_mapping TYPE STANDARD TABLE OF ty_mapping.

    DATA: lt_mapping TYPE tt_mapping.

    LOOP AT lt_invoice_a INTO DATA(ls_invoice_a).
      APPEND INITIAL LINE TO lt_mapping ASSIGNING FIELD-SYMBOL(<lfs_mapping>).
      <lfs_mapping>-original_invoice_id = ls_invoice_a-original_invoice_id.
      <lfs_mapping>-invoice_status_udt = COND #( WHEN ls_invoice_a-adjustment_type = '3' THEN '0'
                                                 WHEN ls_invoice_a-adjustment_type = '5' OR ls_invoice_a-adjustment_type = '9' THEN '1'
                                                 ELSE '' ).
    ENDLOOP.
    CHECK lt_mapping IS NOT INITIAL.

    "4. Update invoice_status thông qua B và lt_mapping
    DATA: lt_invoice_status_udt TYPE TABLE FOR UPDATE zi_hhdv_head\\HHDVHead.

    LOOP AT lt_invoice_b INTO DATA(ls_invoice_b).
      READ TABLE lt_mapping INTO DATA(ls_mapping) WITH KEY original_invoice_id = ls_invoice_b-invoice_no.
      IF sy-subrc = 0.
        APPEND INITIAL LINE TO lt_invoice_status_udt ASSIGNING FIELD-SYMBOL(<lfs_invoice_status_udt>).
        <lfs_invoice_status_udt>-%tky                   = VALUE #( InvoiceId = ls_invoice_b-invoice_id ).
        <lfs_invoice_status_udt>-%data-InvoiceStatus    = ls_mapping-invoice_status_udt.
        <lfs_invoice_status_udt>-%control-InvoiceStatus = if_abap_behv=>mk-on.
      ENDIF.
    ENDLOOP.

    CHECK lt_invoice_status_udt IS NOT INITIAL.
    MODIFY ENTITIES OF zi_hhdv_head
    ENTITY HHDVHead
    UPDATE FIELDS ( InvoiceStatus )
    WITH lt_invoice_status_udt
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZCE_HHDV_RP DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCE_HHDV_RP IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
