({
    doInit : function (component,event,helper) {
        function receiveMessage(event) {
            if (event.data.eventType === 'tokenizedStr') {
                helper.processServerPayment(component,event.data.token.id);
            }
        }

        window.addEventListener("message", receiveMessage, false);
    },
    processPayment : function (component,event,helper) {
        if (component.find('full_name').validate()) {
            document.getElementById('stripeFrame').contentWindow.postMessage({eventType : 'tokenizeStr'},'*');
        }
        else {
            helper.toggleButtonEvent('paymentButtons');
        }
    }
})
