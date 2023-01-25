public class Task2{
    public Account acc{get;set;}
     public list<Contact> con{get;set;}
    public String inputid{get;set;}
    public Contact newcon{get;set;}
    public String checkId{get;set;}
    public List<contact> store{get;set;} 
    public List<contact> deleteall{get;set;}
    public Integer index{get;set;} 
    Public Task2(ApexPages.StandardController controller){
        
    }
    
    public void showRecord(){
        
        con=[Select Id,Firstname,Lastname,email,phone FROM Contact WHERE Accountid=:inputid];  
    }
    public void saveInfo(){
        
      
        if(store.size()>0){
        delete store;
            
        }
        if(deleteall.size()>0){
            delete deleteall;
        }
         upsert con;	
        
    }
    public void addTask(){        
        con.add(new Contact(AccountId=inputid,lastname='ABC'));        
    }
    public void deleteNow(){
        
             
        Contact temp= con[index];
        con.remove(index);
        store.add(temp);
 
    }
    public void deleteAll(){
        con.clear();
        deleteall=[Select Id,Firstname,Lastname,email,phone FROM Contact WHERE AccountId=:inputid ];
    }
}