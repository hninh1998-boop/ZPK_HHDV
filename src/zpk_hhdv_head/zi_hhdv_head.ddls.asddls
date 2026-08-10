@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Int. View - HHDV Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_hhdv_head
  as select from ztb_hhdv_head
  composition [0..*] of zi_hhdv_ITEM as _Item
{
  key invoice_id          as InvoiceId,
      invoice_type        as InvoiceType,
      adjustment_type     as AdjustmentType,
      template_code       as TemplateCode,
      invoice_seri        as InvoiceSeri,
      invoice_number      as InvoiceNumber,
      invoice_no          as InvoiceNo,
      currency            as Currency,
      total               as Total,
      issue_date          as IssueDate,
      issue_date_str      as IssueDateStr,
      state               as State,
      request_date        as RequestDate,
      description         as Description,
      buyer_id_no         as BuyerIdNo,
      state_code          as StateCode,
      subscriber_number   as SubscriberNumber,
      payment_status      as PaymentStatus,
      view_status         as ViewStatus,
      download_status     as DownloadStatus,
      exchange_status     as ExchangeStatus,
      num_of_exchange     as NumOfExchange,
      create_time         as CreateTime,
      contract_id         as ContractId,
      contract_no         as ContractNo,
      supplier_tax_code   as SupplierTaxCode,
      buyer_tax_code      as BuyerTaxCode,
      total_before_tax    as TotalBeforeTax,
      tax_amount          as TaxAmount,
      tax_rate            as TaxRate,
      payment_method      as PaymentMethod,
      payment_time        as PaymentTime,
      customer_id         as CustomerId,
      no_field            as NoField,
      payment_status_name as PaymentStatusName,
      buyer_name          as BuyerName,
      transaction_uuid    as TransactionUuid,
      original_invoice_id as OriginalInvoiceId,
      list_product        as ListProduct,
      file_name           as FileName,
      buyer_unit_name     as BuyerUnitName,
      buyer_code          as BuyerCode,
      buyer_address       as BuyerAddress,
      exchange_rate       as ExchangeRate,
      list_info_update    as ListInfoUpdate,
      error_code          as ErrorCode,
      error_description   as ErrorDescription,
      invoice_status      as InvoiceStatus,
      return_inv          as ReturnInv,

      @Semantics.user.createdBy: true
      createdbyuser       as Createdbyuser,
      @Semantics.systemDateTime.createdAt: true
      createddate         as Createddate,
      @Semantics.user.lastChangedBy: true
      changedbyuser       as Changedbyuser,
      @Semantics.systemDateTime.lastChangedAt: true
      changeddate         as Changeddate,
      _Item
}
