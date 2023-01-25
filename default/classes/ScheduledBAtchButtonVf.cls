public class ScheduledBAtchButtonVf {
	Public List<Account> acc = new List<account>();
    public String name{get;set;}
        Public String Email{get;set;}
    Public String rating{get;set;}
    Public Integer hour{get;set;}
    Public Integer minute{get;set;}
    
    Public integer i=0;
    public ScheduledBAtchButtonVf(ApexPages.StandardController controller){
        
    }
    Public void save(){
        i++;  
       Account a=new account();
        a.name=name;
        a.Email__c=Email;
        a.Rating=rating;
        acc.add(a);
        if(acc.size()>0){
            insert acc;
        }
        if(hour<24 && minute<60 ){
            ScheduleEmailCustomTime sq= new ScheduleEmailCustomTime();
        String sch=   '0' + ' ' + string.valueof(minute) + ' ' + string.valueof(hour) + ' ' +  '*' + ' ' + '*' + ' ' + '?'  ;
        System.schedule('time'+i ,sch,sq);
        }
         
    }
}