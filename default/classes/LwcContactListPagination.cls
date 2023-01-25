public with sharing class LwcContactListPagination { 
    @AuraEnabled
    public Static List<Contact> getContacts(){
        List<Contact> conList = new List<Contact>();
        conList=[Select Id,FirstName,LastName,Phone,Email From Contact WHERE CreatedDate >= THIS_MONTH]; 
        return conList;
    }
    @AuraEnabled
    public Static List<Contact> deleteContact(Id conId){
         List<Contact> conList = new List<Contact>();
        conList=[Select Id,FirstName,LastName,Phone,Email From Contact Where Id=:conId];
        if(conList.size()>0){
            System.debug('delete=>'+conList);
            delete conList; 
        } 
 		return [Select Id,FirstName,LastName,Phone,Email From Contact WHERE CreatedDate >= THIS_MONTH];  
    }
}