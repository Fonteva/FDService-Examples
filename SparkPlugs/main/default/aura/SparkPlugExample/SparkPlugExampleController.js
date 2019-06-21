({
    doInit : function(component, event, helper) {
        var compEvent = $A.get('e.FDService:SparkPlugLoadedEvent');
        compEvent.setParams({extensionPoint : component.get('v.extensionPoint')});
        compEvent.fire();
    }
    ,
    handleClick : function(component, event, helper) {
        var compEvent = $A.get('e.FDService:SparkPlugCompleteEvent');
        compEvent.setParams({extensionPoint : component.get('v.extensionPoint')});
        compEvent.fire();
    }
})
