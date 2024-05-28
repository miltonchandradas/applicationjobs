CLASS zcl_delete_job_template DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_delete_job_template IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lo_job_template  TYPE REF TO cl_apj_dt_create_content,
          lv_template_name TYPE cl_apj_dt_create_content=>ty_template_name.

    " Initialize the job template ID to be deleted
    lv_template_name = 'ZPRODUCTS_TEMPLATE_V4'.  " Replace with the actual template ID

    CONSTANTS lc_template_name     TYPE cl_apj_dt_create_content=>ty_template_name VALUE 'ZPRODUCTS_TEMPLATE_V4'.
    CONSTANTS lc_transport_request TYPE cl_apj_dt_create_content=>ty_transport_request VALUE 'S4UK900533'.

    " Create an instance of the job template content class
    lo_job_template = NEW cl_apj_dt_create_content( ).

    TRY.
        " Call the method to delete the job template entry
        lo_job_template->delete_job_template_entry(
            EXPORTING
            iv_template_name     = lv_template_name
            iv_transport_request = lc_transport_request ).

        out->write( |Job template deleted successfully| ).

      CATCH cx_apj_dt_content INTO DATA(lx_apj_dt_content).
        out->write( |Deletion of job template failed: { lx_apj_dt_content->get_text( ) }| ).
        RETURN.
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
