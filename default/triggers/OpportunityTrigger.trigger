trigger OpportunityTrigger on Opportunity (before insert,before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OpportunityTriggerHandler.setSerialNumber(Trigger.new);
        }
    }

}