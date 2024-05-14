CLASS zcl_products_maintain_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_products_maintain_job IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA lv_job_text TYPE cl_apj_rt_api=>ty_job_text VALUE 'Products JOB TEMPLATE V3'.

    DATA lv_template_name TYPE cl_apj_rt_api=>ty_template_name.

    DATA ls_start_info TYPE cl_apj_rt_api=>ty_start_info.
    DATA ls_scheduling_info TYPE cl_apj_rt_api=>ty_scheduling_info.
    DATA ls_end_info TYPE cl_apj_rt_api=>ty_end_info.

    DATA lt_job_parameters TYPE cl_apj_rt_api=>tt_job_parameter_value.
    DATA ls_job_parameters TYPE cl_apj_rt_api=>ty_job_parameter_value.
    DATA ls_value TYPE cl_apj_rt_api=>ty_value_range.

    DATA lv_jobname TYPE cl_apj_rt_api=>ty_jobname.
    DATA lv_jobcount TYPE cl_apj_rt_api=>ty_jobcount.

    DATA lv_status TYPE cl_apj_rt_api=>ty_job_status.
    DATA lv_statustext TYPE cl_apj_rt_api=>ty_job_status_text.

    DATA lv_txt TYPE string.
    DATA ls_ret TYPE bapiret2.

* choose the name of the existing job template !
    lv_template_name = 'ZPRODUCTS_TEMPLATE_V3'.

* the immediate start can't be used when being called from within a RAP business object
* because the underlying API performs an implicit COMMIT WORK.
*ls_start_info-start_immediately = 'X'.

* Start the job using a timestamp instead. This will start the job immediately but can have a delay depending on the current workload.
    GET TIME STAMP FIELD DATA(ls_ts1).
* add 1 hour
    DATA(ls_ts2) = cl_abap_tstmp=>add( tstmp = ls_ts1
                                     secs = 60 ).

    ls_start_info-timestamp = ls_ts2.

********** periodicity ******************************

    ls_scheduling_info-periodic_granularity = 'MI'.
    ls_scheduling_info-periodic_value = 1.
    ls_scheduling_info-test_mode = abap_false.
    ls_scheduling_info-timezone = 'CET'.

    ls_end_info-type = 'NUM'.
    ls_end_info-max_iterations = 3.

* fill parameter table ******************************
* fill the table only if you want to overrule the parameter values
* which are stored in the template
* the field names in this program must match the field names of the template

    ls_job_parameters-name = 'P_INCREMENT'.

    ls_value-sign = 'I'.
    ls_value-option = 'EQ'.
    ls_value-low = '3'.
    APPEND ls_value TO ls_job_parameters-t_value.

    APPEND ls_job_parameters TO lt_job_parameters.
    CLEAR ls_job_parameters.

*****************************************************

    TRY.

        cl_apj_rt_api=>schedule_job(
        EXPORTING
        iv_job_template_name = lv_template_name
        iv_job_text = lv_job_text
        is_start_info = ls_start_info
        is_scheduling_info = ls_scheduling_info
        is_end_info = ls_end_info
        it_job_parameter_value = lt_job_parameters
* the following two parameters are optional. If you pass them, they must have been generated
* with the call of generate_jobkey above
*        iv_jobname  = lv_jobname
*        iv_jobcount = lv_jobcount
        IMPORTING
        ev_jobname  = lv_jobname
        ev_jobcount = lv_jobcount
        ).

        out->write( lv_jobname ).
        out->write( lv_jobcount ).

        cl_apj_rt_api=>get_job_status(
        EXPORTING
        iv_jobname  = lv_jobname
        iv_jobcount = lv_jobcount
        IMPORTING
        ev_job_status = lv_status
        ev_job_status_text = lv_statustext
        ).

        out->write( lv_status ).
        out->write( lv_statustext ).


    ENDTRY.

  ENDMETHOD.
ENDCLASS.
