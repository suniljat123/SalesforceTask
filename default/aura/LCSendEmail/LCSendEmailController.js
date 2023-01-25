({
    doInit : function(component, event, helper) { 
        var action = component.get("c.getcontactNames"); 
        action.setParams
        ({
            recordId: component.get("v.recordId"),
            flag:false    
        }); 
        action.setCallback(this, function(data) {  
            component.set("v.ConList", data.getReturnValue());  
        });
        $A.enqueueAction(action); 
    }, 
    Next: function(component, event, helper) {  
        component.set("v.modal1", false); 
        component.set("v.modal2", true );
        component.set("v.modal3", false ); 
        
    },
    Next1: function(component, event, helper) { 
        component.set("v.modal1", false );
        component.set("v.modal2", false); 
        component.set("v.modal3", true ); 
        var conList=component.get("v.ConList");
        var action = component.get("c.getSelectedContact"); 
        action.setParams
        ({
            wrapList: component.get("v.ConList")   
        }); 
        action.setCallback(this, function(data) {  
            component.set("v.selectedContact", data.getReturnValue() );
            var action1 = component.get("c.setRecipitentType");
            action1.setParams
            ({
                conList: component.get("v.selectedContact")   
            }); 
            action1.setCallback(this, function(data) { 
                component.set("v.selectedContactWithRecipitentType", data.getReturnValue() ); 
            });
            $A.enqueueAction(action1); 
        });
        $A.enqueueAction(action); 
    },
    Previous: function(component, event, helper) { 
        component.set("v.modal1", true );  
        component.set("v.modal2", false ); 
        component.set("v.modal3", false ); 
    },
    Previous2: function(component, event, helper) { 
        component.set("v.modal1", false );
        component.set("v.modal2", true );  
        component.set("v.modal3", false );   
    },
    checkSingleCheckBox: function(component, event, helper) { 
        var mainCheckBox = component.find("checkResult").get("v.value"); 
        if(mainCheckBox){ 
            var unCheck=component.find("checkResult");
            unCheck.set("v.value",false);
        }
        else{
            var action = component.get("c.checkCheckBox"); 
            action.setParams
            ({
                wrapList:component.get("v.ConList")   
            }); 
            action.setCallback(this, function(data) {  
                var flag=data.getReturnValue()
                var unCheck=component.find("checkResult");
                unCheck.set("v.value",flag);
            });
            $A.enqueueAction(action); 
        }
        
    },
    checkAll: function(component, event, helper) {  
        var flag = event.getSource().get("v.value");  
        var action = component.get("c.getcontactNames"); 
        action.setParams
        ({
            recordId: component.get("v.recordId"),
            flag:flag    
        }); 
        action.setCallback(this, function(data) {  
            component.set("v.ConList", data.getReturnValue());  
        });
        $A.enqueueAction(action); 
    }, 
    handleFilesChange : function (cmp, event,helper) {
        
        var files = event.getSource().get("v.files"); 
        for(var i = 0;i<files.length;i++){            
            var file = files[i];        
            helper.fileToBase64(cmp,file);
        }
        document.getElementById("mainDiv").style.display = "block";
    },
    sendEmail: function(component, event, helper) { 
        var nList = [];
        var bList = [];  
        var tempList=component.get("v.tempList") 
        for(var i = 0;i<tempList.length;i++){  
            nList.push(tempList[i].fileName);
            bList.push(tempList[i].fileContent);
        }  
        var contacts=component.get("v.selectedContactWithRecipitentType");
        var flag=false;
        var checkTo=false;
        for(var i = 0;i< contacts.length;i++){
            if(contacts[i].recipitentType==''){
                
                alert('Select Recipitent Type on Row '+(i+1));
                flag=true;
                break;
            }
            if(contacts[i].recipitentType=='To'){
                checkTo=true;
                break;
            }
        }
        if(checkTo==false && flag==false ){
            alert('Select atleast one Recipitent Type as "To"');
        }
        if(flag==true || checkTo==false){
            // alert('Select atleast one Recipitent Type as "To"')
        }
        else{
            var action = component.get("c.sendEmails");  
            action.setParams
            ({
                conList:  component.get("v.selectedContactWithRecipitentType"),
                bodyText: component.get("v.bodytext"), 
                nameList: nList,
                bodyList :bList
            }); 
            action.setCallback(this, function(data) {  
                $A.get("e.force:closeQuickAction").fire() 
            });
            $A.enqueueAction(action); 
        }
        
    },    
    handleClose : function(component, event, helper) {
        $A.get("e.force:closeQuickActin").fire()  
    } 
})