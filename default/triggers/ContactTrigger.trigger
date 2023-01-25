trigger ContactTrigger on Contact (after insert,before insert,after update,after delete,after Undelete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            
             //ContactTriggerHandler.checkPhone(Trigger.new);
        }
    }
    else{
        if((Trigger.isInsert || trigger.isupdate || Trigger.isDelete || Trigger.isUndelete) && ContactTriggerHandler.isFirst){
            ContactTriggerHandler.isFirst = false;
            ContactTriggerHandler.countContact(Trigger.new,Trigger.old,Trigger.oldmap);
        }         
        if(Trigger.isInsert){
             //ContactTriggerHandler.sendEmail(Trigger.new);
            // set<ID> Ids = new Set()
            for(Id setId :trigger.newmap.keyset()){
                System.debug('Id==>'+setId);
                ContactTriggerHandler.sendWhatsappMessage(setId);
            }
            // ContactTriggerHandler.sendWhatsappMessage()
            
        }
        else if(Trigger.isUpdate){
           // ContactTriggerHandler.sendUpdatedEmail(Trigger.new,Trigger.oldmap);
        } 
    } 
}