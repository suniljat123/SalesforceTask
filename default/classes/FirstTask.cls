public class FirstTask {
    public static void add( String cnt,String acnt ,String opp){
        Account acc=New Account();
        acc.name=acnt;
        acc.phone='123456';
        insert acc;
        Contact cn=new Contact();
        cn.LastName = cnt;
        cn.AccountId = acc.id;
        insert cn;
        Opportunity op = new Opportunity();
        op.Stagename='Prospecting';
        op.CloseDate=Date.today();
        op.name=opp;
        op.AccountId=acc.id;
        insert op;
        
    }
    public static void upd(String name,Id conId){  
        Contact c= new Contact();
        c.LastName=name;
        c.Id=conid;
        update c;
        Account a=new account();
		a.Id=c.AccountId;
        a.name=name;
        update a;
       
    }
    public static void upd2(String name,Id uid){
        Account a = new Account();
        a.Name=name;
        a.id=uid;
        update a;
        List<Contact> conList = new List<Contact>();
        conList = [SELECT Id,Firstname, LastName FROM Contact WHERE AccountId =: uid];
        for(contact c:conList){
            c.lastname=name;
        }
        update conList;
        
    }

}