trigger LeadTrigger on Lead (before insert,after insert) {
    if(Trigger.isBefore){
      if(Trigger.isInsert){ 
            LeadTriggerHandler.checkContactExistence(Trigger.new,Trigger.newMap);
        }
    }
    else{
         if(Trigger.isInsert){ 
            LeadTriggerHandler.addCampaignMember(Trigger.new,Trigger.newMap);
        }
    }

}