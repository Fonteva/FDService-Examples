# Wrapper Examples

In the Fonteva Services platform developers can extend the wrapper classes.

1. ##### Extending Wrapper Class 
    There are many times that custom fields are added to wrappers that may not exist in the core platform. These
    fields should be mapped in the wrapper class to make sure that they can injected into the platform. No custom 
    mapping is needed to map field to/from wrapper. Any new fields that are added to the object need to be added as camel
    case to the wrapper class. 
    
    For Example if you have the field `Namespace__Stripe_Client_Secret__c` this would translate to 
    ```apex
        @AuraEnabled
        global String stripeClientSecret;
    ```
    
    [Here is an example](WrapperOverrides/main/default/classes/EPayment.cls) that contains new custom fields that will 
    be auto mapped. Wrappers can be overridden using global overrides or contextual overrides. To see this class
    in use with the contextual override see [class](https://github.com/Fonteva/FDService-Examples/blob/464334774dd2d98557d208dde0c6fa088a525ec9/PaymentEngine/main/default/classes/ProcessStripePayment.cls#L91-L96) in Payment Engine example.
    As you can see in this example we are instantiating our custom class and sending that into the core platform.
    Internally the platform uses the correct classes and maps the custom fields back to the Fonteva objects. 
