CLASS zcl_wrapper_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_wrapper_test IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    call function 'BAPI_FLIGHT_GETLIST'.
    DATA lv_email TYPE i_addressemailaddress_2-emailaddress.
    DATA lv_currency TYPE i_currency-currency.
  ENDMETHOD.
ENDCLASS.
