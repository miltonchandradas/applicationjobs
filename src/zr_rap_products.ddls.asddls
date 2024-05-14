@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZRAP_PRODUCTS'
define root view entity ZR_RAP_PRODUCTS
  as select from zrap_products
{
  key id as ID,
  name as Name,
  description as Description,
  cost as Cost,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
  
}
