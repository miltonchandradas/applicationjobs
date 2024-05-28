CLASS zcl_products_business_logic DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_apj_dt_exec_object.
    INTERFACES if_apj_rt_exec_object.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_products_business_logic IMPLEMENTATION.

  METHOD if_apj_dt_exec_object~get_parameters.
    " Return the supported selection parameters here
    et_parameter_def = VALUE #( ( selname = 'P_INCREM' kind = if_apj_dt_exec_object=>parameter datatype = 'I' length = 10 param_text = 'My Increment Value' changeable_ind = abap_true ) ).

    " Return the default parameters values here
    et_parameter_val = VALUE #( ( selname = 'P_INCREM' kind = if_apj_dt_exec_object=>parameter sign = 'I' option = 'EQ' low = '1' ) ).
  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.

    DATA p_increment TYPE i.
    DATA it_update_instance TYPE TABLE FOR UPDATE zr_rap_products.

    " Getting the actual parameter values
    LOOP AT it_parameters INTO DATA(ls_parameter).
      CASE ls_parameter-selname .
        WHEN 'P_INCREM'. p_increment = ls_parameter-low.
*        WHEN 'P_INCREMENT'. p_increment = ls_parameter-low.
      ENDCASE.
    ENDLOOP.

    SELECT SINGLE * FROM zrap_products
                        INTO @DATA(product).

    it_update_instance = VALUE #( ( id = product-id cost = product-cost + p_increment %control = VALUE #(  cost = if_abap_behv=>mk-on ) ) ).

    MODIFY ENTITIES OF zr_rap_products
               ENTITY products
                 UPDATE FROM it_update_instance
              REPORTED DATA(update_reported)
              FAILED DATA(update_failed)
              .

    COMMIT ENTITIES.

  ENDMETHOD.


ENDCLASS.
