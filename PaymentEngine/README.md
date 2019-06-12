# Payment Engine

In the Fonteva Services platform developers can extend/overwrite the callouts to the payment processor.  
This section will outline different ways to to use the Payment Engine. 

1. ##### Gateway Specific Fields (Level 2 or Level 3 Processing)
    With Spreedly to send extra information to the gateway you have to use Gateway Specific Fields. These
    fields can differ from gateway to gateway. [Spreedly Gateways](https://www.spreedly.com/all-gateways]) will 
    outline what those fields are. This is also how Level 2/Level 3 processing is supported. To do this look at 
    the class [PaymentService_GatewaySpecificFields](classes/PaymentService_GatewaySpecificFields.cls).<br/>
    This class should extend the FDService.PaymentService and overwrite all methods that need these specific fields.
