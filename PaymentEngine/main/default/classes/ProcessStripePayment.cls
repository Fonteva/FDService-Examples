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
public with sharing class ProcessStripePayment {

    @AuraEnabled
    public static Object processStrPayment(String record,String paymentMethodToken, String currencyISOCode) {
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
}
