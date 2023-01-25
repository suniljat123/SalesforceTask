public class AccountTriggerHandler {
    public AccountTriggerHandler(){
        
    }
    Public Static void NameChecking(List<Account> newList){
        for(Account acc: newList){
            if(acc.name=='Kamran'){
                acc.Phone='7878438668';
            }
        }
    }
    Public Static void creatingopp(List<Account> newList){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc: newList){
            Opportunity opp = new Opportunity();
            opp.Name=acc.name;
            opp.CloseDate=System.today();
            opp.StageName='Qualification';
            opp.AccountId=acc.Id;
            oppList.add(opp);
        }
        if(oppList.size()>0){
            insert oppList;
        }     
    }
    Public Static void updatePhoneDescription(List<account> newList , Map<Id,Account> oldmap){ 
        for(Account acc :newList ){
            if(oldmap!=NULL && acc.Phone!=oldmap.get(acc.Id).phone){
                acc.Description='You update Phone Number';
            }
        }     
    }
    Public Static void updateOppPhone(List<account> newList,Map<Id,Account> oldmap){
        Map<Id,Account> relatedAccList = new Map<Id,Account>();
        List<Opportunity> oppList =new List<Opportunity>();
        
        for(Account acc:newList){
            if(oldmap!=NULL && acc.Phone!=oldmap.get(acc.Id).Phone){
                relatedAccList.put(acc.Id,acc);
            }
        }
        for(Opportunity opp:[SELECT Id,phone__c,AccountId FROM Opportunity where AccountId In:relatedAccList.keyset()]){
            Opportunity oppo = new Opportunity();
            if(relatedAccList.containsKey(opp.AccountId)){
                oppo.Id=opp.Id ;
                oppo.phone__c= relatedAccList.get(opp.AccountId).Phone; 
                oppList.add(oppo);
            }
        }
        if(oppList.size()>0){
            update oppList;
        }
    } 
    Public Static void deleteRelatedContacts(List<Account> oldList){ 
        for(Account a:oldList){
            Contact con=new Contact();
            con.LastName= a.Name;
            con.Title='abc';
            insert con;      
        }
        
    }
    Public Static void creatingOppAfterUndeleteAccount(List<Account> newList){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account a:newList){
            Opportunity opp = new Opportunity();
            opp.AccountId=a.Id;
            opp.CloseDate=System.today();
            opp.StageName='Prospecting';
            opp.Name=a.Name;
            oppList.add(opp);
            
        }
        if(oppList.size()>0){
            insert oppList;
        }
    }
   /* Public Static void callBatchClass(Map<Id,Account> accMap){ ////for Batch class
        if(accMap.size()>0){
            database.executeBatch(new BatchAccountCheckRating(accMap));
        }
    }*/
    Public static void cpyBillingAddressToShippingAddress(List<Account> accList){
        for(Account acc:accList){
            if(acc.BillingCity!=Null || acc.BillingCountry!=NULL || acc.BillingState!=NULL ||acc.BillingPostalCode!=NULL || acc.BillingStreet!=NULL){
               acc.ShippingCountry= acc.BillingCountry;
                acc.ShippingState=acc.BillingState;
                acc.ShippingCity=acc.BillingCity;
                acc.ShippingPostalCode=acc.BillingPostalCode;
                acc.ShippingStreet=acc.BillingStreet;
            }
            else{
                acc.ShippingCountry= 'India';
                acc.ShippingState='Rajasthan';
                acc.ShippingCity='Ajmer';
                acc.ShippingPostalCode='345001';
                acc.ShippingStreet='Pratap Nagar';
            }
        }
         
    }
}