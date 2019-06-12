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
 * Class: PaymentService_CustomGateway
 */
global inherited sharing class PaymentService_CustomGateway extends FDService.PaymentService {

    public override FDService.EPayResponse purchase(FDService.EPayRequest request) {
        return FDService.EPayResponse.getInstance();
    }

    public override FDService.EPayResponse verify(FDService.EPayRequest request) {
        return FDService.EPayResponse.getInstance();
    }

    public override FDService.EPayResponse deletePaymentMethod(FDService.EPayRequest request ) {
        return FDService.EPayResponse.getInstance();
    }

    public override FDService.EPayResponse capture(FDService.EPayRequest request) {
        return FDService.EPayResponse.getInstance();
    }

    public override FDService.EPayResponse authorize(FDService.EPayRequest request ) {
        return FDService.EPayResponse.getInstance();
    }

    public override FDService.EPayResponse credit(FDService.EPayRequest request ) {
        return FDService.EPayResponse.getInstance();
    }

    public override FDService.EPayResponse generalCredit(FDService.EPayRequest request ) {
        return FDService.EPayResponse.getInstance();
    }
}
