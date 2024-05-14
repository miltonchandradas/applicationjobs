CLASS zcl_products_initial_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_products_initial_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DELETE FROM zrap_products.
    DATA: it_products_data TYPE TABLE OF zrap_products.

    it_products_data = VALUE #( ( id =  NEW cl_system_uuid( )->if_system_uuid~create_uuid_x16( )
    name = 'Laptop'
    description = 'IBM Thinkpad'
    cost = 200 ) ).

    INSERT zrap_products FROM TABLE @it_products_data.

*    Commit.
    COMMIT WORK.


  ENDMETHOD.
ENDCLASS.
