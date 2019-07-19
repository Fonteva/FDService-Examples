# Other Examples

Other examples of actions you can perform with the FOnteva Platform are listed below:

1. ##### Disable Triggers Contextually
    Sometimes a trigger needs to be disabled either because it is not needed to run
    or it will cause the system to hit the governor limit. Toggling this functionality only requires a line of code.
    Wrap your DML insert with these statements:
    ```apex
       Framework.Dispatcher.disableTriggerInContext.put(OBJECT_NAME,true);
       update items;
       Framework.Dispatcher.disableTriggerInContext.put(OBJECT_NAME,false);
    ``` 
    Replace `OBJECT_NAME` with the full api name of the SObject. The second parameter is a Boolean to disable/enable the
    triggers. Full working example:
    ```apex
       Framework.Dispatcher.disableTriggerInContext.put('OrderApi__Item__c',true);
       update items;
       Framework.Dispatcher.disableTriggerInContext.put('OrderApi__Item__c',false);
    ```
