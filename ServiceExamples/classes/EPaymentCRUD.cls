/*
 * -----------------------------------------------------------------------------
 * COPYRIGHT (C) 2019, FONTEVA, INC.
 * ALL RIGHTS RESERVED.
 *
 * ALL INFORMATION CONTAINED HEREIN IS, AND REMAINS THE PROPERTY OF FONTEVA
 * INCORPORATED AND ITS SUPPLIERS, IF ANY. THE INTELLECTUAL AND TECHNICAL
 * CONCEPTS CONTAINED HEREIN ARE PROPRIETARY TO FONTEVA INCORPORATED AND
 * ITS SUPPLIERS AND MAY BE COVERED BY U.S. AND FOREIGN PATENTS, PATENTS IN
 * PROCESS, AND ARE PROTECTED BY TRADE SECRET OR COPYRIGHT LAW. DISSEMINATION
 * OF THIS INFORMATION OR REPRODUCTION OF THIS MATERIAL IS STRICTLY FORBIDDEN
 * UNLESS PRIOR WRITTEN PERMISSION IS OBTAINED FROM FONTEVA, INC.
 * -----------------------------------------------------------------------------
 */

/* 
 * Project: FDService-Examples
 * Class: EPaymentCRUD
 */
public inherited sharing class EPaymentCRUD {

    public FDService.EPayment createEPayment() {
        FDService.EPayment ePaymentObj = FDService.EPayment.getInstance();
        ePaymentObj.description = 'Test Epayment';
        ePaymentObj.amount = 100;
        return FDService.EPaymentService.getInstance().create(new List<FDService.EPayment>{ePaymentObj})[0];
    }

    public FDService.EPayment getEPayment() {
        FDService.EPayment ePaymentObj = FDService.EPayment.getInstance();
        ePaymentObj.description = 'Test Epayment';
        ePaymentObj.amount = 100;
        FDService.EPaymentService service = FDService.EPaymentService.getInstance();
        service.create(new List<FDService.EPayment>{ePaymentObj});

        List<FDService.EPayment> payments = service.get(
                FDService.SearchRequest.getInstance()
                        .filter('OrderApi__Description__c = {0}',new List<Object>{'Test Epayment'}));
        return payments[0];
    }

    public FDService.EPayment mutateEPayment() {
        FDService.EPaymentService service = FDService.EPaymentService.getInstance();
        FDService.EPayment ePaymentObj = FDService.EPayment.getInstance();
        ePaymentObj.description = 'Test Epayment';
        ePaymentObj.amount = 100;
        ePaymentObj = service.create(new List<FDService.EPayment>{ePaymentObj})[0];

        ePaymentObj.amount = 110 ;
        return service.mutate(new List<FDService.EPayment>{ePaymentObj})[0];
    }

    public void deteEPayment() {
        FDService.EPaymentService service = FDService.EPaymentService.getInstance();
        FDService.EPayment ePaymentObj = FDService.EPayment.getInstance();
        ePaymentObj.description = 'Test Epayment';
        ePaymentObj.amount = 100;
        ePaymentObj = service.create(new List<FDService.EPayment>{ePaymentObj})[0];

        service.destroy(new List<FDService.EPayment>{ePaymentObj});
    }
}
