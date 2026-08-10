@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Int. View - Auth HHDV'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_auth_hhdv
  as select from ztb_auth_hhdv
{
  key company_code      as CompanyCode,
      username          as Username,
      password          as Password,
      supplier_tax_code as SupplierTaxCode
}
