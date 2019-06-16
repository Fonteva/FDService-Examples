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
 * Class: StripeHTTPExecutor
 */
public inherited sharing class StripeHTTPExecutor {

    public final static String BASE_URL = 'https://api.stripe.com/v1';

    public static HttpResponse executeRequest(String method,String uri) {
        return executeRequest(method,uri,null);
    }

    public static HttpResponse executeRequest(String method,String uri,String body) {
        HttpRequest req = new HttpRequest();
        req.setTimeout(120000);
        req.setEndpoint(BASE_URL+uri);
        req.setMethod(method);
        if (method.equalsIgnoreCase('post')) {
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        }
        req.setHeader('Authorization','Bearer sk_test_OXQGnQNQhjnQaJbWBUAYfmeB00HDmZLJGH');
        Http http = new Http();
        if (String.isNotEmpty(body)) {
            req.setBody(body);
        }
        HttpResponse resp = http.send(req);
        return resp;
    }
}
