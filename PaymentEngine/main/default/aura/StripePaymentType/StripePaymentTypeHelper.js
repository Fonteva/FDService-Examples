({
    toggleButtonEvent : function(buttonGroup) {
        var compEvent = $A.get('e.Framework:ButtonToggleIndicatorEvent');
        compEvent.setParams({
            group : buttonGroup
        });
        compEvent.fire();
    },
    processServerPayment : function(component,tokenId) {
        var paymentObj = {
            record: component.get('v.customPaymentTypeObj.paymentObj.paymentObjId'),
            paymentMethodToken: tokenId,
            currencyISOCode: component.get('v.customPaymentTypeObj.paymentObj.currencyISOCode'),
        }
        var self = this;
        ActionUtils.executeAction(this, component, 'c.processStrPayment', paymentObj)
            .then(function (result) {
                window.location = '/' + result.receiptId;
            })
            .catch(function (result) {
                self.toggleButtonEvent('paymentButtons');
            });
    }
});
