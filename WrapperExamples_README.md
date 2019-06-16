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
## License
 
The MIT License (MIT)

Copyright (c) 2019 Fonteva Inc

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
