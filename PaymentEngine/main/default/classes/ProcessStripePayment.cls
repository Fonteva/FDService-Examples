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
 * Class: ProcessStripePayment
 */
public inherited sharing class ProcessStripePayment {

    public ProcessStripePayment() {

    }

    public PageReference processPayment() {
        try{
            Id recordId = Framework.PageUtils.getIdParam('recordId');
            String clientSecret = Framework.PageUtils.getParam('client_secret');
            String source = Framework.PageUtils.getParam('source');
            Map<String,Object> sourceMap = PaymentService_CustomGateway.getSourceObj(source);
            String status = (String)sourceMap.get('status');
            if (status.equalsIgnoreCase('chargeable')) {
                FDService.PaymentResponse response = (FDService.PaymentResponse)processStrPayment(recordId,source,'USD');
                PageReference ref = new PageReference('/'+response.receiptId);
                return ref;
            }
        }
        catch (Exception e) {
            Framework.SyslogError.log(e);
            return null;
        }

        return null;
    }

    @AuraEnabled
    public static Object processStrPayment(String record,String paymentMethodToken, String currencyISOCode) {
        FDService.ImplementationOverride.overrideContextImplementation('PaymentEngine', 'Payment_Service', PaymentService_CustomGateway.class.getName());
        FDService.PaymentResponse response = FDService.PaymentResponse.getInstance();
        try{
            FDService.PaymentRequest paymentDetailsObj = FDService.PaymentRequest.getInstance();
            paymentDetailsObj.record = record;
            paymentDetailsObj.paymentMethodToken = paymentMethodToken;
            paymentDetailsObj.savePaymentMethod = false;
            paymentDetailsObj.currencyISOCode = currencyISOCode;
            response = FDService.OrderPaymentService.getInstance().pay(paymentDetailsObj);
        }
        catch (Exception e) {
            return Framework.SyslogError.log(e);
        }

        return response;
    }

    @AuraEnabled
    public static Object createEPayment(String recordId) {
        Id epaymentId;
        try {
            FDService.SalesOrder so = FDService.SalesOrder.getInstance();
            so.id = recordId;
            FDService.EPayment epayObj = FDService.EPaymentMapService.getInstance().createEPayment(so);
            epaymentId = epayObj.id;
        }
        catch (Exception e) {
            return Framework.SyslogError.log(e);
        }

        return epaymentId;
    }

    @AuraEnabled
    public static Object createSource(String epaymentId,Decimal total,String currencyISOCode) {
        try {
            String baseUrl =  Url.getOrgDomainUrl().toExternalForm()+ Page.PaymentProcessing.getUrl()+'?recordId='+epaymentId;
            HttpRequest req = new HttpRequest();
            req.setTimeout(120000);
            req.setEndpoint(PaymentService_CustomGateway.BASE_URL+'/sources');
            req.setMethod('POST');
            req.setHeader('Authorization','Bearer sk_test_OXQGnQNQhjnQaJbWBUAYfmeB00HDmZLJGH');
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            String payload = 'type=alipay&flow=redirect&redirect[return_url]='+baseUrl+'&amount='+String.valueOf(total)+'&currency='+currencyISOCode;
            req.setBody(payload);
            Http http = new Http();
            HttpResponse resp = http.send(req);
            Map<String, Object> responseBody = ( Map<String, Object> ) JSON.deserializeUntyped(resp.getBody());

            FDService.ImplementationOverride.overrideContextImplementation('Finance', 'EPayment', EPayment.class.getName());
            EPayment epSObj = (EPayment)FDService.EPayment.getInstance();
            epSObj.id = epaymentId;
            epSObj.stripeClientSecret = (String)responseBody.get('client_secret');
            epSObj.stripeSourceId = (String)responseBody.get('id');
            FDService.EPaymentService.getInstance().mutate(new List<FDService.EPayment>{epSObj});

            Map<String,Object> redirectObj = (Map<String,Object>)responseBody.get('redirect');
            return redirectObj.get('url');
        }
        catch (Exception e) {
            return Framework.SyslogError.log(e);
        }
    }
}
