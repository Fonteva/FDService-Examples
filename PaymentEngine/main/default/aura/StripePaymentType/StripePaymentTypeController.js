({
    doInit : function (component,event,helper) {
        helper.buildMonthOptions(component);
        helper.buildYearOptions(component);
    },
    processPayment : function (component,event,helper) {

        var postData = 'card[number]='+component.get('v.creditCardObj.cc')+'&card[exp_month]='+component.get('v.creditCardObj.month');
        postData += '&card[exp_year]='+component.get('v.creditCardObj.year')+'&card[cvc]=343&key=pk_test_NCuV8goKtHrOhfspBo61LU6e00bIsJQkWG';
        fetch('https://api.stripe.com/v1/tokens', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: postData
        }).then($A.getCallback(function(res){
            res.json().then(function(result){
                var paymentObj = {
                    record : component.get('v.customPaymentTypeObj.paymentObj.paymentObjId'),
                    paymentMethodToken : result.id,
                    currencyISOCode : component.get('v.customPaymentTypeObj.paymentObj.currencyISOCode'),
                }
                ActionUtils.executeAction(helper,component,'c.processStrPayment',paymentObj)
                    .then(function(result){
                        window.location = '/'+result.receiptId;
                    })
                    .catch(function(result){
                        helper.toggleButtonEvent('paymentButtons');
                    });
            });
        }));
    }
})
