({
	Submit : function(component, event, helper) {
		var componentEvent = component.getEvent("cmpEvent");
        var name=component.get("v.FirstName"); 
        componentEvent.setParams({
            "message" : name,
            "label" :'Your Name'
        });
        componentEvent.fire();
	}
})