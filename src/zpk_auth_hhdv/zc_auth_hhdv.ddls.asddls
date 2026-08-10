@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cons.View - Auth HHDV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AUTH_HHDV
  provider contract transactional_query
  as projection on zi_auth_hhdv
{
  key CompanyCode,
      Username,
      Password,
      SupplierTaxCode
}
