# Service Examples

In the Fonteva Services platform, developers can extend and overwrite the service and wrapper classes. This section outlines both
overwriting and extending, as well as generally using our services platform.

1. ##### Atomic Action Services
    When you use Services, you are able to create an Order record and insert multiple levels of order lines in one DML. The class
    [Orders](ServiceExamples/main/default/classes/Orders.cls) outlines how to create an order and add order lines. 
    The example creates order lines that are parent -> child -> grandchild depth in one DML. When they are added,
    it will also pre-calculate tax lines and any required package items to add. All of the above will be done in a single
    DML. In previous iterations of the platform, this would be completed by executing the Order Line triggers up to 8 times 
    if each item was taxable and had package items.
    
    In the method [addItemsToOrder](https://github.com/Fonteva/FDService-Examples/blob/master/ServiceExamples/main/default/classes/Orders.cls#L67)
    multiple lines are added, and each are connected via a `parentForeignKey` entry. For each child to relate to the parent, provide the 
    parent's `foreignKey`. This will allow the platform to parent the records correctly.
2. ##### CRUD Services
    There are two types of services. The one above is the Atomic Action Service that is beyond basic CRUD. The other type
    is CRUD services. The CRUD services are there to allow basic operations on custom objects in the Fonteva Platform.
    We use the following standard across all CRUD services:
    ```apex
        List<WrapperBase> create(List<WrapperBase> objectsToCreate) {
            return new List<WrapperBase>();
        }
     
        List<WrapperBase> get(FDService.SearchRequest sr) {
            return new List<WrapperBase>();
        }
     
        List<WrapperBase> mutate(List<WrapperBase> objectsToCreate) {
              return new List<WrapperBase>();
        }
     
        void destroy(List<WrapperBase> objectsToDelete) {
        }
    
    ```
    Due to keyword limitations, `update` is changed to `mutate` and `delete` is `destroy`. The `WrapperBase` instance 
    above can be replaced with the SObject wrapper class as they all extend `WrapperBase`. Please refer to [EPayment example](ServiceExamples/main/default/classes/EPaymentCRUD.cls)
    for usage information.
3. ##### Search Request Examples
    As part of the new services platform, we have introduced a new way to query records from the database. The goal is to make
    this easier and more readable. In this example class, you will be able see many different ways to use the `FDService.SearchRequest`
    object. [SearchRequest Examples](ServiceExamples/main/default/classes/SearchRequestExamples.cls)
