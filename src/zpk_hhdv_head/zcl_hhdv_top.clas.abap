CLASS zcl_hhdv_top DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: tt_hhdv_head TYPE STANDARD TABLE OF ztb_hhdv_head,
           tt_hhdv_item TYPE STANDARD TABLE OF ztb_hhdv_item.

    TYPES: BEGIN OF ty_invoice_a,
             invoice_id          TYPE ztb_hhdv_head-invoice_id,
             adjustment_type     TYPE ztb_hhdv_head-adjustment_type,
             original_invoice_id TYPE ztb_hhdv_head-original_invoice_id,
           END OF ty_invoice_a,
           tt_invoice_a TYPE STANDARD TABLE OF ty_invoice_a.

    TYPES:  tt_keys_head TYPE TABLE FOR ACTION IMPORT zi_hhdv_head\\hhdvhead~udtinvoicestatus.

    "===== Local Types để deserialize JSON =====
    TYPES:
      BEGIN OF ty_tax_breakdown,
        vat_percentage     TYPE string,
        vat_taxable_amount TYPE string,
        vat_tax_amount     TYPE string,
        is_increase_item   TYPE string,
      END OF ty_tax_breakdown,
      tt_tax_breakdown TYPE STANDARD TABLE OF ty_tax_breakdown WITH EMPTY KEY.

    TYPES:
      BEGIN OF ty_item_info,
        selection                      TYPE string,
        item_type                      TYPE string,
        line_number                    TYPE string,
        item_code                      TYPE string,
        item_name                      TYPE string,
        unit_code                      TYPE string,
        unit_name                      TYPE string,
        unit_price                     TYPE string,
        quantity                       TYPE string,
        item_total_amt_without_vat     TYPE string,
        item_total_amt_with_vat        TYPE string,
        item_total_amt_after_discount  TYPE string,
        item_service_charge_percentage TYPE string,
        item_service_charge_amount     TYPE string,
        item_excise_tax_percentage     TYPE string,
        item_excise_tax_amount         TYPE string,
        vat_percentage                 TYPE string,
        vat_amount                     TYPE string,
        discount                       TYPE string,
        discount2                      TYPE string,
        item_discount                  TYPE string,
        item_note                      TYPE string,
        batch_no                       TYPE string,
        exp_date                       TYPE string,
        is_increase_item               TYPE string,
        adjust_ratio                   TYPE string,
        adjust_index                   TYPE string,
        adjust_factors                 TYPE string,
        discount_amount                TYPE string,
        discount_amount2               TYPE string,
        special_info                   TYPE string,
        discount_value                 TYPE string,
        discount_value2                TYPE string,
      END OF ty_item_info,
      tt_item_info TYPE STANDARD TABLE OF ty_item_info WITH EMPTY KEY.

    TYPES:
      BEGIN OF ty_list_product,
        item_info              TYPE tt_item_info,
        invoice_tax_breakdowns TYPE tt_tax_breakdown,
      END OF ty_list_product.

    TYPES:
      BEGIN OF ty_invoice,
        invoice_id          TYPE string,
        invoice_type        TYPE string,
        adjustment_type     TYPE string,
        template_code       TYPE string,
        invoice_seri        TYPE string,
        invoice_number      TYPE string,
        invoice_no          TYPE string,
        currency            TYPE string,
        total               TYPE string,
        issue_date          TYPE string,
        issue_date_str      TYPE string,
        state               TYPE string,
        request_date        TYPE string,
        description         TYPE string,
        buyer_id_no         TYPE string,
        state_code          TYPE string,
        subscriber_number   TYPE string,
        payment_status      TYPE string,
        view_status         TYPE string,
        download_status     TYPE string,
        exchange_status     TYPE string,
        num_of_exchange     TYPE string,
        create_time         TYPE string,
        contract_id         TYPE string,
        contract_no         TYPE string,
        supplier_tax_code   TYPE string,
        buyer_tax_code      TYPE string,
        total_before_tax    TYPE string,
        tax_amount          TYPE string,
        tax_rate            TYPE string,
        payment_method      TYPE string,
        payment_time        TYPE string,
        customer_id         TYPE string,
        no                  TYPE string,
        payment_status_name TYPE string,
        buyer_name          TYPE string,
        transaction_uuid    TYPE string,
        original_invoice_id TYPE string,
        list_product        TYPE string,
        file_name           TYPE string,
        buyer_unit_name     TYPE string,
        buyer_code          TYPE string,
        buyer_address       TYPE string,
        exchange_rate       TYPE string,
        list_info_update    TYPE string,
        error_code          TYPE string,
        error_description   TYPE string,
      END OF ty_invoice,
      tt_invoice TYPE STANDARD TABLE OF ty_invoice WITH EMPTY KEY.

    TYPES:
      BEGIN OF ty_response,
        error_code  TYPE string,
        description TYPE string,
        total_rows  TYPE string,
        invoices    TYPE tt_invoice,
      END OF ty_response.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hhdv_top IMPLEMENTATION.
ENDCLASS.
