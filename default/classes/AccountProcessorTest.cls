@isTest
public class AccountProcessorTest {
    @isTest
    Public static void testContactCount(){
        List<Account> accList=new List<Account>();
        List<Contact> conList=new List<Contact>();
        List<Id> accid=new List<Id>();
        for(Integer i=0;i<50;i++){
            Account a=new account();
            a.Name='test'+i;
            accList.add(a);
        }
        if(accList.size()>0){
            insert accList;
        }
        Integer i=0;
        for(Account a:accList){
            accid.add(a.id);
            Contact con=new Contact();
            con.lastname='test'+i;
            con.AccountId=a.id;
            conList.add(con);
        }
        if(conList.size()>0){
            insert conList;
        }
        Test.startTest();
            AccountProcessor.countContacts(accid);
         Test.stopTest();
        
    }

}