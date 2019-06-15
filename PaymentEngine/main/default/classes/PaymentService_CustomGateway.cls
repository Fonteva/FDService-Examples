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

    public final static String BASE_URL = 'https://api.stripe.com/v1';

    public static Map<String,Object> getSourceObj(String source) {
        HttpRequest req = new HttpRequest();
        req.setTimeout(120000);
        req.setEndpoint(BASE_URL+'/sources/'+source);
        req.setMethod('POST');
        req.setHeader('Authorization','Bearer sk_test_OXQGnQNQhjnQaJbWBUAYfmeB00HDmZLJGH');
        Http http = new Http();
        HttpResponse resp = http.send(req);
        Map<String, Object> responseBody = ( Map<String, Object> ) JSON.deserializeUntyped(resp.getBody());
        return responseBody;
    }

    public override FDService.EPayResponse purchase(FDService.EPayRequest request) {
        HttpRequest req = new HttpRequest();
        req.setTimeout(120000);
        req.setEndpoint(BASE_URL+'/charges');
        req.setMethod('POST');
        req.setHeader('Authorization','Bearer sk_test_OXQGnQNQhjnQaJbWBUAYfmeB00HDmZLJGH');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String payload = 'source='+request.paymentMethod.paymentMethodToken+'&amount='+request.amount+'&currency='+request.currencyISOCode+'&description="'+request.orderId+'"';
        req.setBody(payload);
        Http http = new Http();
        HttpResponse resp = http.send(req);
        FDService.EPayResponse responseObj = FDService.EPayResponse.getInstance();
        responseObj.transactions = new List<FDService.EPayTransaction>();
        responseObj.errors = new List<FDService.Error>();
        FDService.EPayTransaction transactionObj = new FDService.EPayTransaction();
        Map<String, Object> responseBody = ( Map<String, Object> ) JSON.deserializeUntyped(resp.getBody());
        if (resp.getStatusCode() == 200) {
            transactionObj.token = ( String )responseBody.get('id');
            transactionObj.transaction_type = ( String ) responseBody.get('object');
            transactionObj.currency_code = ( String ) responseBody.get('currency');
            transactionObj.payment_method_token = ( String ) responseBody.get('payment_method');
            transactionObj.description = ( String ) responseBody.get('description');
            transactionObj.amount = ( Integer ) responseBody.get('amount');
            if ( ( String ) responseBody.get('status') == 'succeeded' ) {
                transactionObj.succeeded = true;
            }
        }
        else {
            transactionObj.succeeded = false;
            transactionObj.amount = 0;
            Map<String,Object> errorSubObj = (Map<String,Object>)responseBody.get('error');
            transactionObj.error_code = (String)errorSubObj.get('code');
            transactionObj.error_detail = (String)errorSubObj.get('message');
            responseObj.errors.add(new FDService.Error((String)errorSubObj.get('code'),(String)errorSubObj.get('message')));
            transactionObj.errors = responseObj.errors;
        }
        responseObj.http_status_code = resp.getStatusCode();
        responseObj.transactions.add(transactionObj);
        return responseObj;
    }



    public override FDService.EPayResponse credit(FDService.EPayRequest request ) {
        HttpRequest req = new HttpRequest();
        req.setTimeout(120000);
        req.setEndpoint(BASE_URL+'/refunds');
        req.setMethod('POST');
        req.setHeader('Authorization','Bearer sk_test_OXQGnQNQhjnQaJbWBUAYfmeB00HDmZLJGH');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String payload = 'charge='+request.transactionToken;
        req.setBody(payload);
        Http http = new Http();
        HttpResponse resp = http.send(req);
        FDService.EPayResponse responseObj = FDService.EPayResponse.getInstance();
        responseObj.transactions = new List<FDService.EPayTransaction>();
        responseObj.errors = new List<FDService.Error>();
        FDService.EPayTransaction transactionObj = new FDService.EPayTransaction();
        Map<String, Object> responseBody = ( Map<String, Object> ) JSON.deserializeUntyped(resp.getBody());
        if (resp.getStatusCode() == 200) {
            transactionObj.token = ( String )responseBody.get('id');
            transactionObj.transaction_type = ( String ) responseBody.get('object');
            transactionObj.currency_code = ( String ) responseBody.get('currency');
            transactionObj.amount = ( Integer ) responseBody.get('amount');
            if ( ( String ) responseBody.get('status') == 'succeeded' ) {
                transactionObj.succeeded = true;
            }
        }
        else {
            transactionObj.succeeded = false;
            transactionObj.amount = 0;
            Map<String,Object> errorSubObj = (Map<String,Object>)responseBody.get('error');
            transactionObj.error_code = (String)errorSubObj.get('code');
            transactionObj.error_detail = (String)errorSubObj.get('message');
            responseObj.errors.add(new FDService.Error((String)errorSubObj.get('code'),(String)errorSubObj.get('message')));
            transactionObj.errors = responseObj.errors;
        }
        responseObj.http_status_code = resp.getStatusCode();
        responseObj.transactions.add(transactionObj);
        return responseObj;
    }

}
