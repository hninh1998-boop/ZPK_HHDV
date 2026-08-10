CLASS zcl_hhdv_job_chk DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hhdv_job_chk IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lv_float  TYPE string VALUE '0E-9',
          lv_packed TYPE p DECIMALS 9.

    lv_packed = CONV decfloat34( lv_float ). " Converts 0e-9 to standard decimal 0.000000000

    out->write( |Converted value: { lv_packed }| ).
  ENDMETHOD.
ENDCLASS.
