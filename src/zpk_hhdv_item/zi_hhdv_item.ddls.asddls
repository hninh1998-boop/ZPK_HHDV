@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Int. View - HHDV Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_hhdv_ITEM
  as select from ztb_hhdv_item
  association to parent zi_hhdv_head as _Head on $projection.InvoiceId = _Head.InvoiceId
{
  key invoice_id                     as InvoiceId,
  key line_number                    as LineNumber,
      selection                      as Selection,
      item_type                      as ItemType,
      item_code                      as ItemCode,
      item_name                      as ItemName,
      unit_code                      as UnitCode,
      unit_name                      as UnitName,
      currency                       as Currency,
      unit_price                     as UnitPrice,
      quantity                       as Quantity,
      item_total_amt_without_vat     as ItemTotalAmtWithoutVat,
      item_total_amt_with_vat        as ItemTotalAmtWithVat,
      item_total_amt_after_discount  as ItemTotalAmtAfterDiscount,
      item_service_charge_percentage as ItemServiceChargePercentage,
      item_service_charge_amount     as ItemServiceChargeAmount,
      item_excise_tax_percentage     as ItemExciseTaxPercentage,
      item_excise_tax_amount         as ItemExciseTaxAmount,
      vat_percentage                 as VatPercentage,
      vat_amount                     as VatAmount,
      discount                       as Discount,
      discount2                      as Discount2,
      item_discount                  as ItemDiscount,
      item_note                      as ItemNote,
      batch_no                       as BatchNo,
      exp_date                       as ExpDate,
      is_increase_item               as IsIncreaseItem,
      adjust_ratio                   as AdjustRatio,
      adjust_index                   as AdjustIndex,
      adjust_factors                 as AdjustFactors,
      discount_amount                as DiscountAmount,
      discount_amount2               as DiscountAmount2,
      special_info                   as SpecialInfo,
      discount_value                 as DiscountValue,
      discount_value2                as DiscountValue2,

      @Semantics.user.createdBy: true
      createdbyuser                  as Createdbyuser,
      @Semantics.systemDateTime.createdAt: true
      createddate                    as Createddate,
      @Semantics.user.lastChangedBy: true
      changedbyuser                  as Changedbyuser,
      @Semantics.systemDateTime.lastChangedAt: true
      changeddate                    as Changeddate,
      _Head
}
