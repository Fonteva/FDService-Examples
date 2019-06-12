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
 * Class: Orders
 */
public inherited sharing class Orders {

    public Orders() {

    }

    public Boolean generateData() {
        OrderApi__Item_Class__c itemClass = new OrderApi__Item_Class__c();
        itemClass.OrderApi__Is_Active__c = true;
        insert itemClass;

        List<OrderApi__Item__c> items = new List<OrderApi__Item__c>();
        OrderApi__Item__c item1 = new OrderApi__Item__c();
        item1.OrderApi__Item_Class__c = itemClass.Id;
        item1.Name = 'First Item';
        item1.OrderApi__Price__c = 100;
        item1.OrderApi__Is_Active__c = true;
        items.add(item1);

        OrderApi__Item__c item2 = new OrderApi__Item__c();
        item2.OrderApi__Item_Class__c = itemClass.Id;
        item2.Name = 'Second Item';
        item2.OrderApi__Price__c = 100;
        item2.OrderApi__Is_Active__c = true;
        items.add(item2);

        OrderApi__Item__c item3 = new OrderApi__Item__c();
        item3.OrderApi__Item_Class__c = itemClass.Id;
        item3.Name = 'Third Item';
        item3.OrderApi__Price__c = 100;
        item3.OrderApi__Is_Active__c = true;
        items.add(item3);
        insert items;

        return true;
    }

    public void createOrder() {
        FDService.SalesOrder so = FDService.SalesOrder.getInstance();
        //Locked to 2019-R1 version of Fonteva Platform. If the version is omitted then we auto default
        //to the latest version of the code. This allows customers to lock customizations against a particular
        //release version.
        FDService.OrderService orderService = FDService.OrderService.getInstance('19R1');
        so = orderService.createOrder(so);

    }

    public void addItemsToOrder(FDService.SalesOrder so) {
        List<FDService.Item> items = FDService.ItemService.getInstance('19R1').get(
                FDService.SearchRequest.getInstance().fields('Name'));
        //Locked to 2019-R1 version of Fonteva Platform. If the version is omitted then we auto default
        //to the latest version of the code. This allows customers to lock customizations against a particular
        //release version.
        FDService.OrderService orderService = FDService.OrderService.getInstance('19R1');
        List<FDService.SalesOrderLine> lines = new List<FDService.SalesOrderLine>();

        FDService.SalesOrderLine line = FDService.SalesOrderLine.getInstance();
        line.salesOrder = so.id;
        line.item = items.get(0).id;
        lines.add(line);

        FDService.SalesOrderLine line2 = FDService.SalesOrderLine.getInstance();
        line2.salesOrder = so.id;
        line2.item = items.get(1).id;
        line2.parentForeignKey = line.foreignKey;
        lines.add(line2);

        FDService.SalesOrderLine line3 = FDService.SalesOrderLine.getInstance();
        line3.salesOrder = so.id;
        line3.item = items.get(2).id;
        line3.parentForeignKey = line2.foreignKey;
        lines.add(line3);

        //This will add all of the items to the order and set the correct parent child relationships. For the above
        //example it will create a tree depth of 3 based on the parent/child relationship. This will occur in a single
        //DML. All taxes/required packaage items will be calculated before anything is pushed to the database. This
        //allows us to reduce the number of times the triggers execute to one time.
        lines = orderService.addItemsToOrder(lines);
    }

}
