# Service Examples

In the Fonteva Services platform developers can extend/overwrite the service/wrapper classes. This section will outline both
overwriting/extending and just generally using our services platform.

1. ##### Creating An Order And Adding Order Lines
    Using services you are able to create a Order record and insert multiple levels of order lines in one DML. The class
    [Orders](ServiceExamples/main/default/classes/Orders.cls) will outline how to create an order and add order lines. 
    The example will create order lines that are parent -> child -> grandchild depth in one DML. When they are added
    it will also pre-calculate tax lines and any required package items to add. All of the above will be done in a single
    DML. In previous iterations of the platform this would be completed by executing the Order Line triggers upto 8 times 
    granted each item was taxable and had package items.
