@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cons.View - HHDV Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_hhdv_item
  as projection on zi_hhdv_ITEM
{
  key InvoiceId,
  key LineNumber,
      Selection,
      ItemType,
      ItemCode,
      ItemName,
      UnitCode,
      UnitName,
      Currency,
      UnitPrice,
      Quantity,
      ItemTotalAmtWithoutVat,
      ItemTotalAmtWithVat,
      ItemTotalAmtAfterDiscount,
      ItemServiceChargePercentage,
      ItemServiceChargeAmount,
      ItemExciseTaxPercentage,
      ItemExciseTaxAmount,
      VatPercentage,
      VatAmount,
      Discount,
      Discount2,
      ItemDiscount,
      ItemNote,
      BatchNo,
      ExpDate,
      IsIncreaseItem,
      AdjustRatio,
      AdjustIndex,
      AdjustFactors,
      DiscountAmount,
      DiscountAmount2,
      SpecialInfo,
      DiscountValue,
      DiscountValue2,

      Createdbyuser,
      Createddate,
      Changedbyuser,
      Changeddate,
      /* Associations */
      _Head : redirected to parent zc_hhdv_head
}
