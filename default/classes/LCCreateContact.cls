public class LCCreateContact {
    @AuraEnabled
    public Static void createContact(String Name){
        Contact con = new contact();
        con.LastName=Name;
        con.AccountId='0015g00000wOJCGAA4';
        insert con;
    }

}