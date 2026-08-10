CLASS ltc_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS test_udt_invoice_status FOR TESTING.

ENDCLASS.

CLASS ltc_test IMPLEMENTATION.

  METHOD test_udt_invoice_status.

    DATA lt_udt TYPE TABLE FOR ACTION IMPORT zi_hhdv_head\\HHDVHead~UdtInvoiceStatus.

    APPEND VALUE #( %param-StartDate = '20260123'
                     %param-EndDate  = '20260123' ) TO lt_udt.

    MODIFY ENTITIES OF zi_hhdv_head
      ENTITY HHDVHead
        EXECUTE UdtInvoiceStatus
        FROM lt_udt
      FAILED   DATA(lt_failed)
      REPORTED DATA(lt_reported).

    COMMIT ENTITIES
      RESPONSE OF zi_hhdv_head
      FAILED   DATA(lt_failed_commit)
      REPORTED DATA(lt_reported_commit).

    cl_abap_unit_assert=>assert_initial( lt_failed ).
    cl_abap_unit_assert=>assert_initial( lt_failed_commit ).

  ENDMETHOD.

ENDCLASS.
