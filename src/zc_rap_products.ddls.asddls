@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_RAP_PRODUCTS'
define root view entity ZC_RAP_PRODUCTS
  provider contract transactional_query
  as projection on ZR_RAP_PRODUCTS
{
  key ID,
  Name,
  Description,
  Cost,
  LocalLastChangedAt
  
}
