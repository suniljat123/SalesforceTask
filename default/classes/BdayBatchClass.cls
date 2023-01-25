global class BdayBatchClass implements database.Batchable<sObject> {
    String var9AM;
    String var2PM;
    String var2PMand9AM;
    public  BdayBatchClass(string settime){
        var2PMand9AM=settime; 
    }
    global database.QueryLocator start(database.BatchableContext bc){
         date d = System.today();
        return database.getQueryLocator([Select Id,Name,firstname,lastname,Birthdate,Email,ownerId,Working_Shift__c  from Contact Where Birthdate=:d AND Working_Shift__c=:var2PMand9AM]) ;
        
    }
    global void execute(database.BatchableContext bc,List<Contact> conList){ 
         List<User> allUser=[Select id,email,name from user];  
         Map<Id,user> userMap=new Map<Id,User>();
        for(User usr:allUser){
            userMap.put(usr.id,usr);
        }  
        Map<Integer,String> emailBody = new  Map<Integer,String>(); 
        if(True){
            emailBody.put(1,'Count your life by smiles, not tears. Count your age by friends, not years. Happy birthday!');
            emailBody.put(2,'Happy birthday! I hope all your birthday wishes and dreams come true.');
            emailBody.put(3,'You are only young once, but you can be immature for a lifetime. Happy birthday!');
            emailBody.put(4,'Happy birthday to someone who is forever young!');
            emailBody.put(5,'Just wanted to be the first one to wish you happy birthday so I can feel superior to your other well-wishers. So, happy birthday!');
            emailBody.put(6,'Wishing you a beautiful day with good health and happiness forever. Happy birthday!');
            emailBody.put(7,'On this wonderful day, I wish you the best that life has to offer! Happy birthday!');
            emailBody.put(8,'Happy birthday to you. From good friends and true, from old friends and new, may good luck go with you and happiness too!');
            emailBody.put(9,'Sending you a birthday wish wrapped with all my love. Have a very happy birthday!');
            emailBody.put(10,'On this special day, I raise a toast to you and your life. Happy birthday.');
            emailBody.put(11,'You look younger than ever! Happy birthday!');
            emailBody.put(12,'Everybody has birthdays. You just wear yours better than most!');
        }
        List<messaging.Email> sendingEmailList = new List<messaging.Email>();
        for(Contact con : conList){
            if(con.email!=NULL){ 
                Messaging.SingleEmailMessage emailmsg = new Messaging.SingleEmailMessage();
                String[] toaddress= new String[]{con.email}; 
                    emailmsg.setToAddresses(toaddress); 
                String disname;
                if(con.FirstName!=NULL){
                    disname= con.FirstName;
                }
                else{
                    disname= con.lastName;
                }
                List<String> userEmail=new List<String>();
                userEmail.add(userMap.get(con.ownerId).email);
                emailmsg.setBccAddresses(userEmail);
                emailmsg.setSenderDisplayName(disname);
                String subject = 'Welcome '+ con.FirstName;
                emailmsg.setSubject(subject);
                String content= 'Hii,'+con.Name+',<br/><br/>'+ emailBody.get(Date.Today().Month())+'<br/><br/>'+ 'Good Luck'; 
                emailmsg.setHtmlBody(content); 
                sendingEmailList.add(emailmsg); 
            }  
               Messaging.sendEmail(sendingEmailList); 

        
        }
    }
    global void finish(database.BatchableContext bc){
        
    }

}