trigger objectforOpportunityserialnumberTrigger on objectforOpportunityserialnumber__c (before delete) {
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            objectforOpportunitySRNTriggerHandler.deleteError(Trigger.old);
        }
    }

}