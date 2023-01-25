@isTest
public class LeadProcessorTest {
    @isTest
    Public Static void test1(){
        List<lead> lList=new List<lead>();
        for(Integer i=0;i<200;i++){
            Lead l=new Lead();
            l.lastname='test'+i;
            l.LeadSource='phone';
            l.Status='Working';
            l.Company='company'+i;
            lList.add(l);
        }
        if(lList.size()>0){
            insert lList;
        }
        Test.startTest();
        LeadProcessor n=new LeadProcessor();
        database.executeBatch(n);
          
        Test.stopTest();
    }

}