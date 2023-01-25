public class LeadProcessor implements Database.Batchable<sObject> {
    Public database.QueryLocator start(database.BatchableContext bc){ 
        return database.getQueryLocator([Select Leadsource from Lead]);
    }
    Public Static void execute(database.BatchableContext bc,List<Lead> lList){
        for(Lead l:lList){
            l.Leadsource='web';
        }
        if(lList.size()>0){
            update lList;
        }
    }
    Public Static void finish(database.BatchableContext bc){
        
    }

}