public class task4 {
    public Account acc{get;set;}
    public list<Contact> con{get;set;}
    public String inputid{get;set;}
    public String checkId{get;set;}
    public List<contact> store{get;set;} 
    public List<contact> deleteall{get;set;}
    public Integer index{get;set;}
    public Checkbox1 objcheckbox{get;set;}
    public List<Checkbox1> sub{get;set;}
    public List<contact> del {get;set;}
	public List<Contact> conList2 {get;set;}
    public task4(){
        store = new List<contact>();
        deleteall=new List<contact>();
        sub=new list<Checkbox1>();  
        del = new List<Contact>();
    }    
    //Creating Wraapper class
    public class Checkbox1{
        public Contact conwrap{get;set;}
        public Boolean isSelected{get;set;}        
        public checkbox1(Contact conwrap,Boolean isSelected){
  			this.isSelected=isSelected ;
        	this.conwrap=conwrap;
        }
    }    
    public void deleteSelected(){
           for(Integer i=0; i<sub.size(); i++){
            	if(sub[i].isSelected){
                    if(sub[i].conwrap.id!=null){
                        del.add(sub[i].conwrap);
                    }
                	sub.remove(i);
                	i--;
           		 }
        	}   	             
 	}    
    public void showRecord(){
        
        for(Contact  cr : [Select Id,Firstname,Lastname,email,phone FROM Contact WHERE Accountid=:inputid]){
            sub.add(new Checkbox1 (cr, false));
        }
        
        con=[Select Id,Firstname,Lastname,email,phone FROM Contact WHERE Accountid=:inputid];  
    }
    public void saveInfo(){ 
        List<Contact> conList = new List<Contact>();
        for(Checkbox1 w : sub){
            conList.add(w.conwrap);
        }
        upsert conList;
        if(del.size()>0){
            delete del;
            del.clear();
        }
        if(deleteall.size()>0){
            delete deleteall;
            deleteall.clear();
        }
                       
    }
    public void addTask(){ 
        contact obj=new Contact(AccountId=inputid,lastname='ABC');        
         sub.add(new Checkbox1 (obj, false));        
    }
    public void deleteNow(){            
       Contact temp=sub[index].conwrap;
        if(temp.id!=null){
            del.add(temp);
        }
        sub.remove(index);
    }
    public void deleteAll(){
        sub.clear();
        deleteall=[Select Id,Firstname,Lastname,email,phone FROM Contact WHERE AccountId=:inputid ];
    }
}