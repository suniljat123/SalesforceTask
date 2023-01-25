({  
  handleClick : function(component, event, helper) 
    {  
      component.find('lWCCmp').LWCFunction ();   
    }  
})
/*
({
    sendDataVFPage : function(component, event, helper) {
        console.log('current rec details ===> '+JSON.stringify(component.get('v.recordFields')));
        console.log('Parent Id  ===> '+component.get('v.strParentId'));
        if(component.get('v.strParentId')) {
            var myEvent = $A.get("e.c:SendDataToVFPage");
            myEvent.setParams({
                currentRecId: component.get('v.strParentId'),
                CurrentRecDetails: component.get('v.recordFields')
            });
            myEvent.fire();
        }
    }
})*/