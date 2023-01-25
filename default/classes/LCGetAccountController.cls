public class LCGetAccountController { 
    @AuraEnabled
    public Static List<Contact> getContact(Id recordId){ 
        List<Contact> contList=[SELECT Id,FirstName,Lastname,Name,Email,Phone,AccountId FROM Contact Where AccountId=:recordId];  
        return  contList;
    }
    @AuraEnabled
    public static List<Contact> saveContactList(List<Contact> conList ,Id recordId){  
        set<id> conId =new set<Id>(); 
        for(Contact con:conList){
            if(con.id!=NULL){
                conId.add(con.id); 
            }    
        } 
        List<Contact> allContacts=[Select Id,name from Contact where AccountId=:recordId AND id Not In:conId];
        if(allContacts.size()>0){
            delete allContacts;
        }
        upsert conList; 
        return conList;
    } 
}