({
    getObjListHelper : function(component,event,helper){
        debugger;
        var action = component.get('c.getObjectName');
        action.setCallback(this, function(response) {
            var state= response.getState();
            if(state==='SUCCESS'){ 
                var result = response.getReturnValue();
                component.set("v.allInitDetails", result); 
            }
            else{
                
                alert('in else');
            } 
        });
        $A.enqueueAction(action);
    }, 
    genrateQueryHelper : function(component,event,helper) {
        var objtName = component.get("v.objName");  
        var SelectId = component.get("v.options");   
        var makequery = component.get("v.selectedList");
        var querymaker = 'SELECT'+' ' + makequery +' '+'From'+ ' ' + objtName;  
        component.set("v.qeryString",querymaker);  
    },
    fetchRecordHelper : function(component,event,helper){
        debugger;
        var datalist = component.get("v.qeryString");
        var action = component.get('c.queryRecord');
        action.setParams({
            records : datalist
        });
        action.setCallback(this, function(response){
            var state = response.getState();      
            if (state === "SUCCESS") { 
                var result = response.getReturnValue();
                if(result != null){
                    
                    component.set("v.dataList",result);   
                }else{
                    
                    alert('No record to fetch');
                }   
            }
            else{
                alert('ERROR');
            }
        });
        $A.enqueueAction(action); 
    }
})