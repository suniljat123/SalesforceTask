public class customcontroller {
    public customcontroller(){
        
    }
    public Account accid{get;set;}
    public Contact conrecord{get;set;}
    public Opportunity opprecord{get;set;}
    public String accname{get;set;}
    public String fname{get;set;}
    public String lname{get;set;}
    public String assname{get;set;}
    public String oppname{get;set;}
    public Integer amnt{get;set;}
    public id search{get;set;}
    
    
    public void saveinfo(){
        Account acc=new Account(name=accname);        
        insert acc;
        
        Contact con = new Contact(lastname=lname);
        con.Firstname=fname;
        con.AssistantName=assname;
        con.Accountid =acc.id;
        insert con;
        Opportunity opp = new Opportunity(Name=oppname,StageName='Prospecting',CloseDate=Date.today());
        opp.Amount=amnt;
        opp.accountid=acc.id;
        insert opp;       
    }
    public void Search_id(){
       // Account accid=[select Name, First_Name__c,	Lastname__c ,(SELECT LastName, AssistantName  FROM Contact),(SELECT Name,Amount FROM Opportunity) FROM Account where id=:search];
     
         accid=[select Name, First_Name__c,	Lastname__c from Account where id=:search];
        conrecord= [SELECT LastName, AssistantName  FROM Contact WHERE AccountId =: search]; 
        opprecord=[SELECT Name,Amount FROM Opportunity where Accountid=:search];
        
        
    }
    public void update_me(){
       //	Account accid=[select Name, First_Name__c,	Lastname__c from Account where id=:search];
        Contact conrecord= [SELECT LastName, AssistantName  FROM Contact WHERE AccountId =: search]; 
        Opportunity opprecord=[SELECT Name,Amount FROM Opportunity where Accountid=:search];
       Account accid = new Account();
        accId.id = search;
        accid.name=accname;
        	accid.First_Name__c=fname;
        update accid;
        conrecord.lastname=lname;
        conrecord.AssistantName=assname;
        conrecord.Accountid =accid.id;
        update conrecord;
         opprecord.Name=oppname;
        opprecord.StageName='Prospecting';
        opprecord.CloseDate=Date.today();
        opprecord.Amount=amnt;
        opprecord.accountid=accid.id;
        update opprecord;    
    }
    public void delete_record(){
        
        Account accid=[select Name, First_Name__c,	Lastname__c from Account where id=:search];
       // Contact conrecord= [SELECT LastName, AssistantName  FROM Contact WHERE AccountId =: search]; 
        //Opportunity opprecord=[SELECT Name,Amount FROM Opportunity where Accountid=:search];
        
		System.debug('data'+accid);
            delete accid;
        
        
        
    }
}