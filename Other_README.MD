# Other Examples

There are many things you can do on the Fonteva Platform that are documented here.

1. ##### Disable Triggers Contextually
    When triggers are executing sometimes there is a need to disable trigger because either they are not needed to run
    or they will cause the system to hit the governor limit. To toggle this functionality it only requires a line of code.
    Wrap your DML insert with these statements:
    ```apex
       Framework.Dispatcher.disableTriggerInContext.put(OBJECT_NAME,true);
       update items;
       Framework.Dispatcher.disableTriggerInContext.put(OBJECT_NAME,false);
    ``` 
    Replace `OBJECT_NAME` with the full api name of the SObject. The second parameter is a Boolean to disable/enable the
    triggers.
