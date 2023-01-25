public class ContactTriggerHandler{
    public static Boolean isFirst = true;
    @AuraEnabled
    public static String getLatitudeLongitude(String city){ 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://visual-crossing-weather.p.rapidapi.com/forecast?aggregateHours=24&location='+city); 
        request.setMethod('GET'); 
        request.setHeader('X-RapidAPI-Key','6f39e97dbdmsh761dbec0f991669p141375jsn057fa2913c23');
        request.setHeader( 'X-RapidAPI-Host', 'visual-crossing-weather.p.rapidapi.com');
        HttpResponse response = http.send(request);  
        System.debug('response.getStatusCode()=>'+response.getStatusCode());
        System.debug('response()1=>'+response.getBody());
        return response.getBody();
        
    } 
    @future(callout=true)
    public static void sendWhatsappMessage(Id recId){
        Contact con=[Select ID, FirstName,LastName,Phone From Contact where Id=:recId]; 
        System.debug('con.Phone()=>'+con.Phone);
        if(con.Phone!=Null){
            String Whatsapp_number='91'+con.Phone; 
            String FirstName=' ';
            String LastName=con.LastName+' ';
            if(con.FirstName!=NULL){
                FirstName=con.FirstName+' ';
            }
            String Name=FirstName+LastName;
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://graph.facebook.com/v15.0/100298942960882/messages'); 
            request.setMethod('POST');
            request.setHeader('Content-Type','application/json');
            String body='{"messaging_product": "whatsapp","to":"'+Whatsapp_number+'","type":"template","template":{"name":"hello_world","language":{"code":"en_us"}}}';  //"text","text": {"body":"Hello '+Name+'"}}';
            request.setBody(body);
            System.debug('body()=>'+body);
            String apiToken ='EAARHMX88gFkBACR7534I8vpahv4pu7XeWxHCQDWaZBAPrlBrUegXURazIbmO5osYTz5gVUKWWWI0ZC5bJnNyRVT48L9XMSmZBq9RNmzAtgddx2tK1GXdGoVeLXQFx7lHltQcKMEJFkwFamjfXdI6YHKjj3GNtdyabewYfMMiukXU6BkvZBvXgOoHLjLrkGTQkwUyvtCUS0dfOsgmPYGD';
            request.setHeader('Authorization','Bearer '+apiToken);
            HttpResponse response = http.send(request);  
            System.debug('response.getStatusCode()=>'+response.getStatusCode());
            System.debug('response()=>'+response.getBody());
            if(response.getStatusCode() == 200) {   
                // return true;
            }
            else{
                // return false;
            } 
        }
        
        
    }
    Public Static void checkPhone(List<Contact> newList){
        for(Contact con:newList){
            if(con.Phone==NULL){
                con.addError('Please Enter Your Phone Number');
            } 
            if(con.FirstName==NULL){
                con.addError('Please Enter Your FirstName');
            } 
        }
    } 
    Public Static void sendEmail(List<contact> conList){
        List<messaging.Email> sendingEmailList = new List<messaging.Email>();
        for(Contact con : conList){
            if(con.email!=NULL){
                Messaging.SingleEmailMessage emailmsg = new Messaging.SingleEmailMessage();
                String[] toaddress= new String[]{con.email};
                    emailmsg.setToAddresses(toaddress);
                String subject = 'Welcome '+ con.FirstName;
                emailmsg.setSubject(subject);
                String disname= con.FirstName;
                emailmsg.setSenderDisplayName(disname);
                String content= 'Welcome '+con.FirstName+',<br/><br/>'+'We are receiving your Name in our LuckyDraw contest! <br/><br/>'+
                    ' So, Dear '+con.FirstName+' Please collect your Gift...<br/><br/>'+'Thank You <br/><br/>Your Mobile Number='+con.Phone+'<br/><br/>D-Mart';
                emailmsg.setHtmlBody(content);
                sendingEmailList.add(emailmsg);
            } 
            Messaging.sendEmail(sendingEmailList);
        }
    }
    Public Static void sendUpdatedEmail(List<Contact> conList, Map<id,Contact> oldmap ){
        List<messaging.Email> sendingEmailList = new List<messaging.Email>();
        for(Contact con : conList){
            if(oldmap!=NULL && con.phone!=oldmap.get(con.Id).phone &&con.Phone!=NUll){
                Messaging.SingleEmailMessage emailmsg = new Messaging.SingleEmailMessage();
                String[] toaddress= new String[]{con.email};
                    emailmsg.setToAddresses(toaddress);
                String subject = 'Welcome '+ con.FirstName;
                emailmsg.setSubject(subject);
                String disname= con.FirstName;
                emailmsg.setSenderDisplayName(disname);
                String content= 'Welcome '+con.FirstName+',<br/><br/>'+'We are receiving your Name in our LuckyDraw contest! <br/><br/>'+
                    ' So, Dear '+con.FirstName+' Please collect your Gift...<br/><br/>'+'Thank You <br/><br/>Your Updated Mobile Number='+con.Phone+'<br/><br/>D-Mart';
                emailmsg.setHtmlBody(content);
                sendingEmailList.add(emailmsg);
            }
            Messaging.sendEmail(sendingEmailList);
        }   
    }
    Public Static void countContact(List<Contact> newList , List<Contact> oldList,Map<id,Contact> oldmap){
        Set<Id> accid=new Set<Id>();
        if(newList!=NULL){
            for(Contact con:newList){
                if(con.AccountId!=NULL){
                    accid.add(con.AccountId);
                }
            }
        }
        if(oldList!=NULL){
            for(Contact con:oldList){
                if(con.AccountId!=NULL){
                    accid.add(con.AccountId);
                }
            }
        } 
        List<Account> accList =[Select Id,Child__c,(Select id,Sibiling__c from Contacts) FROM Account WHERE Id In:accid];  
        if(accList.size()>0){
            for(Account acc:accList ){ 
                acc.Child__c=acc.Contacts.Size();       
            }
        }
        if(accList.size()>0){
            update accList;
        }  
        //Updating Salary Feild using AggregateResult query
        List<Account> accountList =new List<Account>();
        Map<Id,Decimal> mapList = new Map<Id,Decimal>();
        List<AggregateResult> total_result=[Select AccountId accid,count(Id) cc,sum(Salary__c) s from Contact where AccountId In :accid group by AccountId];
        if(total_result.size()>0){
            for(AggregateResult ar :total_result){
                Id acc_id=(Id)ar.get('accid');
                Decimal Sal=(Decimal)ar.get('s');
                Decimal cnt=(Decimal)ar.get('cc');
                Account a=new Account(Id=acc_id); 
                a.Sum_of_Salary__c=Sal; 
                accountList.add(a); 
                mapList.put(acc_id,cnt);
            }     
        }
        if(accountList.size()>0){
            update accountList;    
        } 
        List<Contact> conList=new List<Contact>();
        List<contact> contaList=[Select AccountID,id,Sibiling__c from contact where AccountID In:accid];
        for(Contact con :contaList){ 
            con.Sibiling__c=mapList.get(con.AccountId)-1; 
            conList.add(con);
        } 
        if(conList.size()>0){
            upsert conList;
        }
    } 
}