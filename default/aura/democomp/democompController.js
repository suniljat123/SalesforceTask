({
    initdo : function(component, event, helper) {
        //helper.getObjListHelper(component,event,helper);
        const options =[]
        console.log('Intialize')
        const action= component.get("c.getAllObjects");
        action.setCallback(this,function(response){
            const state =response.getState();
       
            if(state ==="SUCCESS"){
                const allvalues=response.getReturnValue();
                console.log(allvalues);
                    allvalues.forEach((value,i)=>{
                        var Item ={
                            "label": value,
                            "value": value
                        }
                        options.push(Item);
                    })
                    component.set("v.options",options)
               // [{Label:Account,value:Account},{Label:Contact,value:contact}]
            }
            
        });
        $A.enqueueAction(action);
    },
    handelchangeCB : function(component,event,handler){
        debugger;
        const fields =[]
        var selectedOptionValue = event.getParam("value");
        component.set("v.objName",selectedOptionValue);
        console.log('click')
        const action =  component.get("c.getAllFields");
        action.setParams({
            obj:selectedOptionValue

        })
        action.setCallback(this,function(response){
            const state = response.getState();
            console.log(state)
             if(state ==="SUCCESS"){
                const allvalues=response.getReturnValue();
                console.log(allvalues);
                   allvalues.forEach((value,i)=>{
                        var Item ={
                            "label": value,
                            "value": value
                        }
                        fields.push(Item);
                    })
                    component.set("v.fields",fields)
                    var listfield = component.get("v.fields");
                    component.set("v.values",listfield);
                    
               // [{Label:Account,value:Account},{Label:Contact,value:contact}]
            }
        })
        
          $A.enqueueAction(action);

    },
    //Added by Khumed Start
    handleChange :function(component,event,helper){
        debugger;
        var selectedOptionValue = event.getParam("value");
        //alert("Option selected with value: '" + selectedOptionValue.toString() + "'");
        var selectedlist = component.set("v.selectedList",selectedOptionValue.toString() + "");
        var getvalue = component.get("v.selectedList");
    },
    genrateQuery :function(component,event,helper){
        debugger;
        helper.genrateQueryHelper(component,event,helper);
    },
    
    fetchRecord :function(component,event,helper){
         debugger;
         component.set("v.showRecord",true);
        helper.fetchRecordHelper(component,event,helper);
    }
    
//Added by Khumed End
    
})