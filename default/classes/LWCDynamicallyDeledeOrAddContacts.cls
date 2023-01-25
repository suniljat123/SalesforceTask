public with sharing class LWCDynamicallyDeledeOrAddContacts {
    public LWCDynamicallyDeledeOrAddContacts() {

    }
    @AuraEnabled
    public Static List<Contact> getContact(Id accId){ 
        List<Contact> contList=[SELECT Id,FirstName,Lastname,Email,Phone,AccountId FROM Contact Where AccountId=:accId];  
        return  contList;
    } 
    @AuraEnabled
    public static List<Contact> saveContactList(List<Contact> conList,List<Contact> deleteList ){  
        List<Contact> delList = new List<Contact>();  
        for(Contact con1 : deleteList){
            if(con1.Id!=NULL){
                delList.add(con1);
            } 
        } 
        if(delList.size()>0){ 
             delete delList;
        } 
        if(conList.size()>0){ 
              upsert conList; 
        }
        return conList;
    } 
}