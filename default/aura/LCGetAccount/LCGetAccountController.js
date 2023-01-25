({
    doInit : function(component, event, helper) { 
        var ConList = component.get("c.getContact"); 
        ConList.setParams
        ({
            recordId: component.get("v.recordId") 
        }); 
        ConList.setCallback(this, function(data) { 
            component.set("v.ConList", data.getReturnValue());
        });
        $A.enqueueAction(ConList); 
    }, 
    addRow: function(component, event, helper) { 
        var contactList = component.get("v.ConList"); 
        contactList.push({
            'FirstName': '',
            'LastName': '',
            'Phone': '',
            'AccountId':component.get("v.recordId"),
        }); 
        component.set("v.ConList", contactList);
    },
    saveContacts: function(component, event, helper) {  
        if (helper.validateAccountRecords(component, event)) {  
            var action = component.get("c.saveContactList"); 
            action.setParams({
                "conList": component.get("v.ConList") ,recordId: component.get("v.recordId")
            });
            action.setCallback(this, function(response) {  
                var state = response.getState();
                if (state === "SUCCESS") { 
                    component.set("v.ConList", response.getReturnValue());
                    alert('Contacts saved successfully');  
                }
            });  
            $A.enqueueAction(action);
        } 
        $A.get('e.force:refreshView').fire(); 
    },
    removeRecord: function(component, event, helper) { 
        
        var ConList = component.get("v.ConList"); 
        var selectedItem = event.currentTarget; 
        var selectedindex = selectedItem.dataset.record;  
        ConList.splice(selectedindex, 1); 
        component.set("v.ConList", ConList);     
    }
    
})