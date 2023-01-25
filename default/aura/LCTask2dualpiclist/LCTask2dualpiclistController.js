({
    doInit: function (component, event, helper) {         
        var action= component.get("c.getAllObjects");        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') { 
                component.set('v.allObj', response.getReturnValue());  
            }
        });
        $A.enqueueAction(action);         
    }, 
    getfeilds: function (component, event, helper) {  
        component.set("v.hideQueryButton",'true')        
        var button = event.getSource().get("v.value"); 
        component.set('v.selectedobj',button); 
        var action= component.get("c.getAllFeilds");  
        action.setParams
        ({
            objname: event.getSource().get("v.value")             
        }); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {                  
                var values= response.getReturnValue();
                var items=[];
                for (var i = 0; i < values.length; i++) {
                    var item = {
                        "label": values[i] ,
                        "value": values[i],
                    };
                    items.push(item);
                }  
                component.set("v.objFeild", items );                  
            }
        }); 
        $A.enqueueAction(action); 
    },
    makeQuery: function (component, event, helper) { 
        component.set("v.hideSearchButton",'true')
        var action = component.get("c.returnQuery");
        action.setParams
        ({
            selected: component.get("v.values"),
            objName : component.get("v.selectedobj")
        }); 
        action.setCallback(this, function(response){
            var state = response.getState();              
            if(state == 'SUCCESS') {                  
                component.set("v.typeQuery", response.getReturnValue())
            }
        });          	
        $A.enqueueAction(action);        
    },
    showData: function (component, event, helper) { 
        component.set("v.hideDataTable",'true') 
        var action = component.get("c.showAllRecordsvalue");
        action.setParams
        ({
            query: component.get("v.typeQuery") 
        }); 
        action.setCallback(this, function(response){
            var state = response.getState();              
            if(state == 'SUCCESS') {               
                component.set("v.data",response.getReturnValue());
                var action1 = component.get("c.seprateQuery");
                action1.setParams
                ({
                    query : component.get("v.typeQuery")              
                }); 
                action1.setCallback(this, function(response){
                    var state = response.getState();              
                    if(state == 'SUCCESS') {  
                        component.set("v.selectedFeilds",response.getReturnValue())
                        var action2 = component.get("c.getApiLabelType");
                        action2.setParams
                        ({
                            objName : component.get("v.selectedobj"),
                            selected: component.get("v.selectedFeilds")             
                        }); 
                        action2.setCallback(this, function(response){
                            var state = response.getState();              
                            if(state == 'SUCCESS') { 
                                let col = [];
                                response.getReturnValue().forEach(res => {
                                    col.push({label:res , fieldName: res});
                            });
                            component.set('v.columns', col);    
                        }
                                            });          	
                        $A.enqueueAction(action2);   
                    }
                });          	
                $A.enqueueAction(action1);  
            }
        });          	
        $A.enqueueAction(action);   
    },
    addFeild: function (component, event, helper) {   
        component.set("v.feildCondition", event.getParam("value")) ;  
    },
    addSymbol: function (component, event) { 
        var selectedOptionValue = event.getParam("value");
        component.set("v.operatorCondition",event.getParam("value")) ;    
    },
    finalCondition: function (component, event) { 
        var operator=component.get("v.operatorCondition")
        var feild=component.get("v.feildCondition")
        var value=component.get("v.writeValue")
        var finalvalue=' WHERE '+feild+operator+"'"+value+"'"; 
        var action = component.get("c.trimQuery");
        action.setParams
        ({
            query: component.get("v.typeQuery") 
        }); 
        action.setCallback(this, function(response){
            var state = response.getState();              
            if(state == 'SUCCESS') {    
                component.set("v.typeQuery", response.getReturnValue())
            }
        });          	
        $A.enqueueAction(action);  
        var typeQuery=component.get("v.typeQuery");
        typeQuery=typeQuery+finalvalue;
        component.set("v.typeQuery",typeQuery)
        
    },
    enableApplyChangesButton: function (component, event) { 
        component.find('setBtn').set("v.disabled",false);  
        
    }
})