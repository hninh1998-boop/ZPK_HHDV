@EndUserText.label: 'Custom Entity - HHDV RP'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_CE_HHDV_RP'
@Metadata.allowExtensions: true
define root custom entity zce_hhdv_rp
{
  key InvoiceId        : abap.char(50);  // zi_hhdv_head-TemplateCode

  key CompanyCode      : bukrs;          // zi_auth_hhdv-CompanyCode
  key KyHieuMauHoaDon  : abap.char(100); // zi_hhdv_head-TemplateCode
  key KyHieuHD         : abap.char(100); // zi_hhdv_head-InvoiceSeri
  key SoHD             : abap.char(100); // zi_hhdv_head-InvoiceNumber
  key EINVLineItem     : abap.char(50);  // zi_hhdv_item-LineNumber

      // zi_hhdv_head
      Ngay             : abap.dats(8);   // IssueDateStr
      TenDVKHang       : abap.char(100); // BuyerUnitName
      MaSoThue         : abap.char(100); // BuyerTaxCode
      TyGia            : abap.dec(23,0); // ExchangeRate

      // zi_hhdv_item
      TenHang          : abap.string; // ItemName
      DoanhSoTransCur  : abap.dec(23,2); // ItemTotalAmtWithoutVat
      ThueSuat         : abap.dec(23,2); // VatPercentage
      ThueGTGTTransCur : abap.dec(23,2); // VatAmount
      TongCongTransCur : abap.dec(23,2); // ItemTotalAmtWithVat
      NgoaiTe          : abap.dec(23,2); // ItemTotalAmtWithoutVat (check zi_hhdv_head-ExchangeRate <> 1)
      Currency         : waers; // Currency

      // I_JournalEntry
      ChungTu          : belnr_d; // AccountingDocument

      // I_AccountingDocumentJournal
      TK               : belnr_d; // OffsettingAccount
      TKDU             : saknr; // GLAccount
      Customer         : kunnr; // Customer

      // I_BusinessUserBasic
      UserHachToan     : abap.char(80); // PersonFullName

      // Get by logic
      InvoiceKey       : abap.string;
      DoanhSo          : abap.dec(23,0); // zi_hhdv_item-ItemTotalAmtWithoutVat * zi_hhdv_head-ExchangeRate
      ThueGTGT         : abap.dec(23,0); // zi_hhdv_item-VatAmount * zi_hhdv_head-ExchangeRate
      TongCong         : abap.dec(23,0);
      SoToKhai         : abap.string; // Long text I_BillingDocumentTextTP --> LongtextID = Z020
      GhiChu           : abap.string;
      CustomerName     : abap.string; // I_BusinessPartner 

      // Params only
      KyBaoCao         : abap.dats(8);


}
