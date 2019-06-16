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

    public static Map<String,Object> getSourceObj(String source) {
        HttpResponse resp = StripeHTTPExecutor.executeRequest('POST','/sources/'+source);
        return ( Map<String, Object> ) JSON.deserializeUntyped(resp.getBody());
    }

    public override FDService.EPayResponse purchase(FDService.EPayRequest request) {
        String payload = 'source='+request.paymentMethod.paymentMethodToken+'&amount='+request.amount+'&currency='+request.currencyISOCode+'&description="'+request.orderId+'"';
        HttpResponse resp  = StripeHTTPExecutor.executeRequest('POST','/charges',payload);
        return mapResponse(resp);
    }

    public override FDService.EPayResponse credit(FDService.EPayRequest request ) {
        String payload = 'charge='+request.transactionToken;
        HttpResponse resp  = StripeHTTPExecutor.executeRequest('POST','/refunds',payload);
        return mapResponse(resp);
    }

    private FDService.EPayResponse mapResponse(HttpResponse resp) {
        Map<String,Object> responseBody = ( Map<String, Object> ) JSON.deserializeUntyped(resp.getBody());
        FDService.EPayResponse responseObj = FDService.EPayResponse.getInstance();
        responseObj.transactions = new List<FDService.EPayTransaction>();
        responseObj.errors = new List<FDService.Error>();
        FDService.EPayTransaction transactionObj = new FDService.EPayTransaction();
        if (resp.getStatusCode() == 200) {
            transactionObj.token = ( String )responseBody.get('id');
            transactionObj.transaction_type = ( String ) responseBody.get('object');
            transactionObj.currency_code = ( String ) responseBody.get('currency');
            transactionObj.amount = ( Integer ) responseBody.get('amount');
            if ( ( String ) responseBody.get('status') == 'succeeded' ) {
                transactionObj.succeeded = true;
            }
            transactionObj.payment_method_token = ( String ) responseBody.get('payment_method');
            transactionObj.description = ( String ) responseBody.get('description');
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
