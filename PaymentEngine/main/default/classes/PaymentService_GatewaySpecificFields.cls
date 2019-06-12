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
 * Class: PaymentService
 */
global inherited sharing class PaymentService_GatewaySpecificFields extends FDService.PaymentService {

    public override FDService.EPayResponse purchase(FDService.EPayRequest request) {
        FDService.EPayRequest.RequestObject requestObject = new FDService.EPayRequest.RequestObject();
        requestObject.name = 'gateway_specific_fields';
        requestObject.reqObject = new FDService.EPayRequest.RequestObject();
        requestObject.reqObject.name = 'bpoint';
        requestObject.reqObject.elements.add(new FDService.EPayRequest.Element('CRN1','Airport Shuttle'));
        requestObject.reqObject.elements.add(new FDService.EPayRequest.Element('CRN2','Another Comment'));
        requestObject.reqObject.elements.add(new FDService.EPayRequest.Element('CRN3','Order Description'));
        request.objects.add(requestObject);
        FDService.EPayResponse response = getSuper().purchase(request);
        return response;
    }
}