# Spark Plugs

On the Fonteva Platform, this feature allows the ability to display custom Lightning components in the various
areas to allow for a custom flow. The platform allows the ability to display multiple components on each extension
point.

Below are the areas were we allow extensions:

1. On Click - Add to Order
<br>Executed after the `Add To Cart` button is clicked.
1. Load - Shopping Cart
<br>Executed when the shopping cart page is loaded.
1. Load - Checkout
<br>Executed when the checkout page is loaded.
1. Load - Invoice Payment
<br>Executed when the invoice payment page is loaded.
1. Load - Payment Confirmation
<br>Executed when the confirmation page is loaded to show receipt.

#### Add to Cart Example
This example will outline how to display a custom lightning component when the `Add To Cart` button is clicked
on the item detail page. The following things are needed:

1. Lightning Component
<br>The component needs to implement a particular interface to make sure all data from the Spark Plug is pushed down 
to the component. The component needs to be global and implement `FDService:SparkPlugComponentInterface`. Once that is done
this component is ready to use. [Spark Plug Example](SparkPlugs/main/default/aura/SparkPlugExample/SparkPlugExample.cmp).
In this component there is a few events that are used. The are explained below:
    * `FDService:SparkPlugLoadedEvent` : This event should be fired when the lightning component has fully loaded to hide the loader.
    * `FDService:SparkPlugCompleteEvent`: This event should be fired when the lightning component has completed its
    work. This will instruct the container to show the next component or hide the container if no components are left to
    display.
1. Custom Metadata Type record
<br>Configuration record that will instruct the container to display the desired Lightning component. 
[Add To Cart CMT](SparkPlugs/main/default/customMetadata/Framework__Spark_Plug_Extension.Add_To_Cart_Example.md-meta.xml)
