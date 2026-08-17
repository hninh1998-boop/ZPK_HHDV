CLASS zcl_hhdv_f01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS append_ztab
      IMPORTING
        iv_response      TYPE string
      CHANGING
        cv_count_success TYPE i.


  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS deserialized_all
      IMPORTING
        iv_response    TYPE string
      EXPORTING
        es_invoice_all TYPE zcl_hhdv_top=>ty_response.

    CLASS-METHODS append_head
      IMPORTING
        is_invoice TYPE zcl_hhdv_top=>ty_invoice
      EXPORTING
        ev_true    TYPE abap_boolean.

    CLASS-METHODS deserialized_item
      IMPORTING
        iv_item         TYPE string
      EXPORTING
        es_list_product TYPE zcl_hhdv_top=>ty_list_product.

    CLASS-METHODS append_item
      IMPORTING
        it_item_info  TYPE zcl_hhdv_top=>tt_item_info
        iv_invoice_id TYPE string
        iv_currrency  TYPE string
      EXPORTING
        ev_true       TYPE abap_boolean.
ENDCLASS.



CLASS ZCL_HHDV_F01 IMPLEMENTATION.


  METHOD deserialized_all.
    /ui2/cl_json=>deserialize(
      EXPORTING
        json        = iv_response
        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
      CHANGING
        data        = es_invoice_all
    ).
  ENDMETHOD.


  METHOD append_head.
    DATA: lt_hhdv_head TYPE STANDARD TABLE OF ztb_hhdv_head.

    APPEND VALUE #(
      client               = sy-mandt
      invoice_id           = is_invoice-invoice_id
      invoice_type         = is_invoice-invoice_type
      adjustment_type      = is_invoice-adjustment_type
      template_code        = is_invoice-template_code
      invoice_seri         = is_invoice-invoice_seri
      invoice_number       = is_invoice-invoice_number
      invoice_no           = is_invoice-invoice_no
      currency             = is_invoice-currency
      total                = COND #( WHEN is_invoice-total IS NOT INITIAL
                                     THEN CONV decfloat34( is_invoice-total ) ELSE 0 )
      issue_date           = is_invoice-issue_date
      issue_date_str       = is_invoice-issue_date_str
      state                = is_invoice-state
      request_date         = is_invoice-request_date
      description          = is_invoice-description
      buyer_id_no          = is_invoice-buyer_id_no
      state_code           = is_invoice-state_code
      subscriber_number    = is_invoice-subscriber_number
      payment_status       = is_invoice-payment_status
      view_status          = is_invoice-view_status
      download_status      = is_invoice-download_status
      exchange_status      = is_invoice-exchange_status
      num_of_exchange      = is_invoice-num_of_exchange
      create_time          = is_invoice-create_time
      contract_id          = is_invoice-contract_id
      contract_no          = is_invoice-contract_no
      supplier_tax_code    = is_invoice-supplier_tax_code
      buyer_tax_code       = is_invoice-buyer_tax_code
      total_before_tax     = COND #( WHEN is_invoice-total_before_tax IS NOT INITIAL
                                     THEN CONV decfloat34( is_invoice-total_before_tax ) ELSE 0 )
      tax_amount           = COND #( WHEN is_invoice-tax_amount IS NOT INITIAL
                                     THEN CONV decfloat34( is_invoice-tax_amount ) ELSE 0 )
      tax_rate             = is_invoice-tax_rate
      payment_method       = is_invoice-payment_method
      payment_time         = is_invoice-payment_time
      customer_id          = is_invoice-customer_id
      no_field             = is_invoice-no
      payment_status_name  = is_invoice-payment_status_name
      buyer_name           = is_invoice-buyer_name
      transaction_uuid     = is_invoice-transaction_uuid
      original_invoice_id  = is_invoice-original_invoice_id
      list_product         = is_invoice-list_product
      file_name            = is_invoice-file_name
      buyer_unit_name      = is_invoice-buyer_unit_name
      buyer_code           = is_invoice-buyer_code
      buyer_address        = is_invoice-buyer_address
      exchange_rate        = is_invoice-exchange_rate
    list_info_update     = is_invoice-list_info_update
    error_code           = is_invoice-error_code
    error_description    = is_invoice-error_description
    createdbyuser        = sy-uname
    createddate          = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
    changedbyuser        = sy-uname
    changeddate          = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
  ) TO lt_hhdv_head.

    IF lt_hhdv_head IS NOT INITIAL.
      DO 10 TIMES.
        MODIFY ztb_hhdv_head FROM TABLE @lt_hhdv_head.
        IF sy-subrc = 0.
          ev_true = 'X'.
          EXIT.
        ELSE.
          WAIT UP TO 2 SECONDS.
        ENDIF.
      ENDDO.
    ENDIF.
  ENDMETHOD.


  METHOD deserialized_item.
    DATA(lt_mapping) = VALUE /ui2/cl_json=>name_mappings(
      ( abap = 'ITEM_TOTAL_AMT_WITHOUT_VAT'     json = 'itemTotalAmountWithoutVat' )
      ( abap = 'ITEM_TOTAL_AMT_WITH_VAT'        json = 'itemTotalAmountWithVat' )
      ( abap = 'ITEM_TOTAL_AMT_AFTER_DISCOUNT'  json = 'itemTotalAmountAfterDiscount' )
      ( abap = 'ITEM_SERVICE_CHARGE_PERCENTAGE' json = 'itemServiceChargePercentage' )
      ( abap = 'ITEM_SERVICE_CHARGE_AMOUNT'     json = 'itemServiceChargeAmount' )
      ( abap = 'ITEM_EXCISE_TAX_PERCENTAGE'     json = 'itemExciseTaxPercentage' )
      ( abap = 'ITEM_EXCISE_TAX_AMOUNT'         json = 'itemExciseTaxAmount' )
    ).

    /ui2/cl_json=>deserialize(
      EXPORTING
        json          = iv_item
        pretty_name   = /ui2/cl_json=>pretty_mode-camel_case
        name_mappings = lt_mapping
      CHANGING
        data          = es_list_product
    ).
  ENDMETHOD.


  METHOD append_item.
    DATA: lt_hhdv_item TYPE STANDARD TABLE OF ztb_hhdv_item.

    LOOP AT it_item_info INTO DATA(ls_item).
      APPEND VALUE #(
        client                          = sy-mandt
        invoice_id                      = iv_invoice_id
        line_number                     = ls_item-line_number
        selection                       = ls_item-selection
        item_type                       = ls_item-item_type
        item_code                       = ls_item-item_code
        item_name                       = ls_item-item_name
        unit_code                       = ls_item-unit_code
        unit_name                       = ls_item-unit_name
        currency                        = iv_currrency
        unit_price                      = COND #( WHEN ls_item-unit_price IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-unit_price ) ELSE 0 )
        quantity                        = COND #( WHEN ls_item-quantity IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-quantity ) ELSE 0 )
        item_total_amt_without_vat      = COND #( WHEN ls_item-item_total_amt_without_vat IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-item_total_amt_without_vat ) ELSE 0 )
        item_total_amt_with_vat         = COND #( WHEN ls_item-item_total_amt_with_vat IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-item_total_amt_with_vat ) ELSE 0 )
        item_total_amt_after_discount   = COND #( WHEN ls_item-item_total_amt_after_discount IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-item_total_amt_after_discount ) ELSE 0 )
        item_service_charge_percentage  = ls_item-item_service_charge_percentage
        item_service_charge_amount      = COND #( WHEN ls_item-item_service_charge_amount IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-item_service_charge_amount ) ELSE 0 )
        item_excise_tax_percentage      = ls_item-item_excise_tax_percentage
        item_excise_tax_amount          = COND #( WHEN ls_item-item_excise_tax_amount IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-item_excise_tax_amount ) ELSE 0 )
        vat_percentage                  = ls_item-vat_percentage
        vat_amount                      = COND #( WHEN ls_item-vat_amount IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-vat_amount ) ELSE 0 )
        discount                        = ls_item-discount
        discount2                       = ls_item-discount2
        item_discount                   = COND #( WHEN ls_item-item_discount IS NOT INITIAL
                                                  THEN CONV decfloat34( ls_item-item_discount ) ELSE 0 )
        item_note                       = ls_item-item_note
        batch_no                        = ls_item-batch_no
        exp_date                        = ls_item-exp_date
        is_increase_item                = ls_item-is_increase_item
        adjust_ratio                    = ls_item-adjust_ratio
        adjust_index                    = ls_item-adjust_index
        adjust_factors                  = ls_item-adjust_factors
        discount_amount                 = ls_item-discount_amount
        discount_amount2                = ls_item-discount_amount2
        special_info                    = ls_item-special_info
        discount_value                  = ls_item-discount_value
        discount_value2                 = ls_item-discount_value2
        createdbyuser                   = sy-uname
        createddate                     = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        changedbyuser                   = sy-uname
        changeddate                     = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
      ) TO lt_hhdv_item.
    ENDLOOP.


    IF lt_hhdv_item IS NOT INITIAL.
      DO 10 TIMES.
        MODIFY ztb_hhdv_item FROM TABLE @lt_hhdv_item.
        IF sy-subrc = 0.
          ev_true = 'X'.
          EXIT.
        ELSE.
          WAIT UP TO 2 SECONDS.
        ENDIF.
      ENDDO.
    ENDIF.
  ENDMETHOD.


  METHOD append_ztab.
    "Append data và bảng Z Header và ZItem
    "===== Deserialize response chính =====
    zcl_hhdv_f01=>deserialized_all(
      EXPORTING
        iv_response     = iv_response
      IMPORTING
        es_invoice_all  = DATA(ls_invoice_all)
    ).

    LOOP AT ls_invoice_all-invoices INTO DATA(ls_invoice).
      "--- Header ---
      zcl_hhdv_f01=>append_head(
        EXPORTING
          is_invoice = ls_invoice
        IMPORTING
          ev_true    = DATA(lv_true_header)
      ).
      IF lv_true_header IS INITIAL.
        EXIT.
      ENDIF.

      "--- Item: parse list_product (JSON lồng) ---
      IF ls_invoice-list_product IS NOT INITIAL.
        zcl_hhdv_f01=>deserialized_item(
          EXPORTING
            iv_item         = ls_invoice-list_product
          IMPORTING
            es_list_product = DATA(ls_list_product)
        ).

        zcl_hhdv_f01=>append_item(
          EXPORTING
            it_item_info  = ls_list_product-item_info
            iv_invoice_id = ls_invoice-invoice_id
            iv_currrency  = ls_invoice-currency
          IMPORTING
            ev_true       = DATA(lv_true_item)
        ).
        IF lv_true_item IS INITIAL.
          EXIT.
        ENDIF.
      ENDIF.
    ENDLOOP.

    IF lv_true_header = 'X' AND lv_true_item = 'X'.
      cv_count_success += 1.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
