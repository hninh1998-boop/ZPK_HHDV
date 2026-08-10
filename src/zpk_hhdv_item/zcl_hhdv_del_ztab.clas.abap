CLASS zcl_hhdv_del_ztab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hhdv_del_ztab IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DELETE FROM ztb_hhdv_head.
    DELETE FROM ztb_hhdv_head_d.
    DELETE FROM ztb_hhdv_item.
    DELETE FROM ztb_hhdv_item_d.
  ENDMETHOD.
ENDCLASS.
