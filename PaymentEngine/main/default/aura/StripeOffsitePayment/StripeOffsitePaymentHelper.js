({
    generateEPayment : function (component) {
        var self = this;
        ActionUtils.executeAction(this, component, 'c.createEPayment',
            {recordId : component.get('v.customPaymentTypeObj.paymentObj.paymentObjId')
            })
            .then(function (result) {
                self.createSource(component,result,self);
            })
            .catch(function (result) {
                self.toggleButtonEvent('paymentButtons');
            });
    },
    createSource : function (component,epayId,self) {
        ActionUtils.executeAction(this, component, 'c.createSource',
            {
                epaymentId : epayId,
                currencyISOCode: component.get('v.customPaymentTypeObj.paymentObj.currencyISOCode'),
                total: component.get('v.customPaymentTypeObj.paymentObj.total')*100
            })
            .then(function (result) {
                window.location = result;
            })
            .catch(function (result) {
                self.toggleButtonEvent('paymentButtons');
            });
    }
});
