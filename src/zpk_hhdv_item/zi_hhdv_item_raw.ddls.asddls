@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Int. View - HHDV Item Raw'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zi_hhdv_ITEM_raw
  as select from ztb_hhdv_item
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
      createdbyuser                  as Createdbyuser,
      createddate                    as Createddate,
      changedbyuser                  as Changedbyuser,
      changeddate                    as Changeddate
}
