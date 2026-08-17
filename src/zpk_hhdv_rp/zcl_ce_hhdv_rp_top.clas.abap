CLASS zcl_ce_hhdv_rp_top DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: tt_result TYPE STANDARD TABLE OF zce_hhdv_rp,
           ry_string TYPE RANGE OF string.

    TYPES: BEGIN OF ty_key,

             InvoiceId       TYPE zi_hhdv_head-InvoiceId,

             CompanyCode     TYPE bukrs,
             KyHieuMauHoaDon TYPE zi_hhdv_head-TemplateCode,
             KyHieuHD        TYPE zi_hhdv_head-InvoiceSeri,
             SoHD            TYPE zi_hhdv_head-InvoiceNumber,
             EINVLineItem    TYPE zi_hhdv_item-LineNumber,
           END OF ty_key,
           tt_key TYPE STANDARD TABLE OF ty_key WITH EMPTY KEY.

    TYPES: BEGIN OF ty_base,
             "Key fields
             InvoiceId            TYPE zi_hhdv_head-InvoiceId,
             CompanyCode          TYPE bukrs,
             KyHieuMauHoaDon      TYPE zi_hhdv_head-TemplateCode,
             KyHieuHD             TYPE zi_hhdv_head-InvoiceSeri,
             SoHD                 TYPE zi_hhdv_head-InvoiceNumber,
             EINVLineItem         TYPE zi_hhdv_item-LineNumber,

             "Normal base fields
             InvoiceNo            TYPE zi_hhdv_head-InvoiceNo,
             IssueDateStr         TYPE zi_hhdv_head-IssueDateStr,
             TenDVKHang           TYPE zi_hhdv_head-BuyerUnitName,
             MaSoThue             TYPE zi_hhdv_head-BuyerTaxCode,
             TenHang              TYPE zi_hhdv_item-ItemName,
             Currency             TYPE zi_hhdv_item-Currency,
             DoanhSoTransCur_Raw  TYPE zi_hhdv_item-ItemTotalAmtWithoutVat,
             TyGia                TYPE zi_hhdv_head-ExchangeRate,
             ThueSuat             TYPE zi_hhdv_item-VatPercentage,
             ThueGTGTTransCur_Raw TYPE zi_hhdv_item-VatAmount,
             TongCongTransCur_Raw TYPE zi_hhdv_item-ItemTotalAmtWithVat,

             "Other base fields
             InvoiceKey           TYPE c LENGTH 100,
             ChungTu              TYPE c LENGTH 10,
             Ngay                 TYPE d,
           END OF ty_base,
           tt_base TYPE STANDARD TABLE OF ty_base WITH EMPTY KEY.

    TYPES: BEGIN OF ty_acct_doc,
             "Key fields
             InvoiceId              TYPE zi_hhdv_head-InvoiceId,
             CompanyCode            TYPE bukrs,
             KyHieuMauHoaDon        TYPE zi_hhdv_head-TemplateCode,
             KyHieuHD               TYPE zi_hhdv_head-InvoiceSeri,
             SoHD                   TYPE zi_hhdv_head-InvoiceNumber,
             EINVLineItem           TYPE zi_hhdv_item-LineNumber,

             ChungTu                TYPE I_JournalEntry-AccountingDocument,
             tk                     TYPE I_AccountingDocumentJournal-OffsettingAccount,
             tkdu                   TYPE I_AccountingDocumentJournal-GLAccount,
             UserHachToan           TYPE I_BusinessUserBasic-PersonFullName,
             AccountingDocumentType TYPE I_AccountingDocumentJournal-AccountingDocumentType,
             DebitCreditCode        TYPE I_AccountingDocumentJournal-DebitCreditCode,
           END OF ty_acct_doc,
           tt_acct_doc TYPE STANDARD TABLE OF ty_acct_doc WITH EMPTY KEY.

    TYPES: BEGIN OF ty_customer,
             "Key fields
             InvoiceId       TYPE zi_hhdv_head-InvoiceId,
             CompanyCode     TYPE bukrs,
             KyHieuMauHoaDon TYPE zi_hhdv_head-TemplateCode,
             KyHieuHD        TYPE zi_hhdv_head-InvoiceSeri,
             SoHD            TYPE zi_hhdv_head-InvoiceNumber,
             EINVLineItem    TYPE zi_hhdv_item-LineNumber,

             Customer        TYPE I_AccountingDocumentJournal-Customer,
           END OF ty_customer,
           tt_customer TYPE STANDARD TABLE OF ty_customer WITH EMPTY KEY.

    TYPES: BEGIN OF ty_billing,
             "Key fields
             InvoiceId       TYPE zi_hhdv_head-InvoiceId,
             CompanyCode     TYPE bukrs,
             KyHieuMauHoaDon TYPE zi_hhdv_head-TemplateCode,
             KyHieuHD        TYPE zi_hhdv_head-InvoiceSeri,
             SoHD            TYPE zi_hhdv_head-InvoiceNumber,
             EINVLineItem    TYPE zi_hhdv_item-LineNumber,

             BillingDocument TYPE I_AccountingDocumentJournal-ReferenceDocument,
           END OF ty_billing,
           tt_billing TYPE STANDARD TABLE OF ty_billing WITH EMPTY KEY.

    TYPES: BEGIN OF ty_longtext_id,
             "Key fields header
             InvoiceId       TYPE zi_hhdv_head-InvoiceId,
             CompanyCode     TYPE bukrs,
             KyHieuMauHoaDon TYPE zi_hhdv_head-TemplateCode,
             KyHieuHD        TYPE zi_hhdv_head-InvoiceSeri,
             SoHD            TYPE zi_hhdv_head-InvoiceNumber,
             EINVLineItem    TYPE zi_hhdv_item-LineNumber,

             "Key fields item
             BillingDocument TYPE I_AccountingDocumentJournal-ReferenceDocument,

             "API fields
             Language        TYPE I_BillingDocumentTextTP-Language,
             LongTextID      TYPE I_BillingDocumentTextTP-LongTextID,
           END OF ty_longtext_id,
           tt_longtext_id TYPE STANDARD TABLE OF ty_longtext_id WITH EMPTY KEY.

    TYPES: tt_billingtexts_h TYPE TABLE FOR READ RESULT i_billingdocumenttp\\billingdocumenttext.

    TYPES: BEGIN OF ty_exchangerate,
             "Key fields
             InvoiceId       TYPE zi_hhdv_head-InvoiceId,
             CompanyCode     TYPE bukrs,
             KyHieuMauHoaDon TYPE zi_hhdv_head-TemplateCode,
             KyHieuHD        TYPE zi_hhdv_head-InvoiceSeri,
             SoHD            TYPE zi_hhdv_head-InvoiceNumber,

             IssueDateStr    TYPE zi_hhdv_head-IssueDateStr,
             ExchangeRate    TYPE zi_hhdv_head-ExchangeRate,
           END OF ty_exchangerate,
           tt_exchangerate TYPE STANDARD TABLE OF ty_exchangerate WITH EMPTY KEY.

    TYPES: BEGIN OF ty_ghichu,
             "Key fields header
             InvoiceId        TYPE zi_hhdv_head-InvoiceId,
             CompanyCode      TYPE bukrs,
             KyHieuMauHoaDon  TYPE zi_hhdv_head-TemplateCode,
             KyHieuHD         TYPE zi_hhdv_head-InvoiceSeri,
             SoHD             TYPE zi_hhdv_head-InvoiceNumber,
             EINVLineItem     TYPE zi_hhdv_item-LineNumber,

             ChungTuGoc       TYPE zi_hhdv_head-InvoiceNo,
             ChungTuDieuChinh TYPE zi_hhdv_head-InvoiceNo,
             IssueDateStr     TYPE zi_hhdv_head-IssueDateStr,
             Case             TYPE n LENGTH 1,
           END OF ty_ghichu,
           tt_ghichu TYPE STANDARD TABLE OF ty_ghichu WITH EMPTY KEY.

    TYPES: BEGIN OF ty_customer_name,
             "Key field
             Customer            TYPE I_BusinessPartner-BusinessPartner,

             OrganizationBPName1 TYPE I_BusinessPartner-OrganizationBPName1,
             OrganizationBPName2 TYPE I_BusinessPartner-OrganizationBPName2,
             OrganizationBPName3 TYPE I_BusinessPartner-OrganizationBPName3,
             OrganizationBPName4 TYPE I_BusinessPartner-OrganizationBPName4,
             LastName            TYPE I_BusinessPartner-LastName,
           END OF ty_customer_name,
           tt_customer_name TYPE STANDARD TABLE OF ty_customer_name WITH EMPTY KEY.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CE_HHDV_RP_TOP IMPLEMENTATION.
ENDCLASS.
