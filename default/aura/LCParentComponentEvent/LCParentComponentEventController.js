({
	handleComponentEvent : function(component, event, helper) {
		var name=event.getParam("message");
        var label=event.getParam("label");  
        component.set("v.ParentFirstName",name);
        component.set("v.label",label);
        var count = parseInt(component.get("v.eventCount")+1);
         component.set("v.eventCount",count);
        var action = component.get("c.createContact"); 
         action.setParams
        ({
             Name: name            
        }); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') { 
                alert("Contact Created Successfully");
            }
        });
        $A.enqueueAction(action);
	}
})