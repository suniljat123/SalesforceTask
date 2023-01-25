trigger Time_TrackingTrigger on Time_Tracking__c (before insert,before update,after insert,after update,after undelete) {
    if(Trigger.isbefore){
        if(Trigger.isInsert ){
            Time_TrackingTriggerHandler.checkHours(Trigger.new,Trigger.old,Trigger.oldmap);
        }
        else if(Trigger.isupdate ){
            Time_TrackingTriggerHandler.checkUpdatedHours(Trigger.new,Trigger.old,Trigger.oldmap,Trigger.newmap);
        }
    }
    else{
         if( Trigger.isundelete){
            Time_TrackingTriggerHandler.undeleteRecord(Trigger.new,Trigger.oldmap,Trigger.newmap);
        }
    }

}