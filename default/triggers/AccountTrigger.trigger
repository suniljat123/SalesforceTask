trigger AccountTrigger on Account (before insert ,after insert,before update,after update,before delete,after delete,after undelete) {
    if(trigger.isbefore){
        if(Trigger.isInsert){
           // AccountTriggerHandler.NameChecking(trigger.new);
                AccountTriggerHandler.cpyBillingAddressToShippingAddress(Trigger.new);
                
        }     
        else if(Trigger.isUpdate){
            //AccountTriggerHandler.updatePhoneDescription(Trigger.new,Trigger.oldmap);
           // AccountTriggerHandler.cpyBillingAddressToShippingAddress(Trigger.new);
        }
            
    }
    else{
        if(Trigger.isInsert){
           // AccountTriggerHandler.creatingopp(Trigger.new);
         //  AccountTriggerHandler.callBatchClass(trigger.newmap); //for Batch class
        } 
        else if(Trigger.isUpdate){
           //AccountTriggerHandler.updateOppPhone(Trigger.new,Trigger.oldmap);
        }
        else if(Trigger.isDelete){ 
           // AccountTriggerHandler.deleteRelatedContacts(Trigger.old);
        }
        else if(Trigger.isUndelete){
            //AccountTriggerHandler.creatingOppAfterUndeleteAccount(Trigger.new);
        }
    }
    
}