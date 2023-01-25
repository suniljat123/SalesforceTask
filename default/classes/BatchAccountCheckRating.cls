global class BatchAccountCheckRating implements database.Batchable<sObject>,database.Stateful
{
    //global Map<Id, Account> accountMap= new Map<Id,Account>();
    //   global BatchAccountCheckRating(Map<Id,Account> accMap){
    //     accountMap=accMap;
    // }
    global database.QueryLocator start(database.BatchableContext bc){
        return database.getQueryLocator([Select id,	Rating from Account Where Rating!=NULL]) ;
        
    }
    global void execute(database.BatchableContext bc,List<Account> accList){
        
        for(Account acc:accList){ 
            if(acc.Rating=='Warm'){
                acc.Industry='Agriculture';
            }
            else  if(acc.Rating=='Hot'){
                acc.Industry='Banking';
            }
        } 
        if(accList.size()>0){
            update accList;
        }
    }
    global void finish(database.BatchableContext bc){
        List<Account> aList=[Select id , Rating,Name,Email__c FROM Account Where Rating!=NULL];
        System.debug('aList=>'+aList ); 
        for(Account acc : aList){
            if(acc.Email__c!=NULL){
                System.debug('aList=>'+acc.Email__c );
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {acc.Email__c};    
                mail.setToAddresses(toAddresses);   
                mail.setSubject('Account Crreation ');
                mail.setPlainTextBody('Account Created Successfull and Rating of Account is:'+acc.Rating );
                System.debug('Email is=>'+toAddresses);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
            
        }
        
    }
    
}