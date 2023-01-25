@isTest
public class BdayScheduleClassTest {
    @isTest
    public Static void testing(){
        List<Contact> conList =new List<Contact>();
        for(Integer i=0;i<150;i++){
            Contact con =new Contact();
            con.FirstName='name'+i;
            con.LastName='test'+i;
            con.Working_Shift__c='9AM-2PM';
			con.Email='sunilchoudharyjat02@gmail.com';
            con.Birthdate=System.today();
            con.OwnerId='0055g00000FHlPfAAL';
            
            conList.add(con);
        }
        if(conList.size()>0){
            insert conList;
        }
         Test.startTest();
        String settime ='2PM-8PM';
             BdayBatchClass sq= new BdayBatchClass(settime);
        database.executeBatch(sq);
         
         Test.stopTest();
    }

}