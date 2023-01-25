public class LCSendEmailController { 
    @AuraEnabled
    public static List<wrap> getcontactNames(Id recordId,boolean flag){ 
        List<contact> conList = [SELECT Id,FirstName,Lastname,Name,Email,AccountId FROM Contact WHERE AccountId =:recordId];
        List<wrap> rList = new List<wrap>();
        if(flag==true){ 
            for(contact con : conList){
                rList.add(new wrap(true, con));
            } 
        }
        else{ 
            for(contact con : conList){
                rList.add(new wrap(false, con));
            } 
        } 
        return rList;
    }
    @AuraEnabled
    public static Boolean checkCheckBox(List<wrap> wrapList){
        boolean flag=true;
        for(Integer i=0;i<wrapList.size();i++){
            if(wrapList[i].check==false){
                flag=false;
                break;
            }
        }
        return flag;
    }
    public class wrap{
        @AuraEnabled
        public Boolean check{get;set;}
        @AuraEnabled
        Public Contact conwrap{get;set;} 
        public wrap(){
            check = false;
            conwrap = new Contact(); 
        }
        public wrap(Boolean b, Contact c){
            conwrap=c;
            check=b;
        }  
    }
    public class RecipitentWrapper{ 
        @AuraEnabled
        Public Contact conwrap{get;set;}
        @AuraEnabled
        Public String recipitentType{get;set;}
        public RecipitentWrapper(){ 
            conwrap = new Contact();
            recipitentType='';
        }  
        public RecipitentWrapper(String value, Contact c){
            conwrap=c;
            recipitentType=value;
        } 
    } 
    @AuraEnabled
    public static List<RecipitentWrapper> setRecipitentType(List<Contact> conList){
        List<RecipitentWrapper> rList = new List<RecipitentWrapper>();
        for(contact con : conList){
            rList.add(new RecipitentWrapper('', con));
        } 
        Return rList;   
    }
    @AuraEnabled
    public static List<Contact> saveContactList(List<Contact> conList ,Id recordId){  
        set<id> conId =new set<Id>(); 
        for(Contact con:conList){
            if(con.id!=NULL){
                conId.add(con.id); 
            }    
        } 
        List<Contact> allContacts=[Select Id,name from Contact where AccountId=:recordId AND id Not In:conId];
        if(allContacts.size()>0){
            delete allContacts;
        }
        upsert conList; 
        return conList;
    } 
    @AuraEnabled 
    public static List<Contact> getSelectedContact(List<wrap> wrapList){ 
        List<Contact> conList = new List<Contact>(); 
        for(wrap con : wrapList){ 
            if(con.check){
                conList.add(con.conwrap);
            }     
        }   
        Return conList;
    }
    @AuraEnabled 
    public static void sendEmails(List<RecipitentWrapper> conList ,String bodyText,List<String> nameList,List<String> bodyList){  
        List<ContentVersion> cvList = new List<ContentVersion>();
        List<ContentDocumentLink> cdList = new List<ContentDocumentLink>();
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>(); 
        for(Integer i = 0;i<nameList.size();i++){ 
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(nameList[i]); 
            efa.setBody(EncodingUtil.base64Decode(bodyList[i]));  
            attachments.add(efa);
        }   
        List<messaging.Email> sendingEmailList = new List<messaging.Email>();
        List<String> ccEmails=new List<String>();
        List<String> toEmails=new List<String>();
        for(RecipitentWrapper con :conList ){
            if(con.recipitentType=='To'){ 
                toEmails.add(con.conwrap.Email);
            }
            else if(con.recipitentType=='CC'){ 
                ccEmails.add(con.conwrap.Email);
            }
        } 
        Messaging.SingleEmailMessage emailmsg = new Messaging.SingleEmailMessage(); 
        emailmsg.setToAddresses(toEmails); 
        emailmsg.setCcAddresses(ccEmails); 
        String subject = 'Welcome ';
        emailmsg.setSubject(subject);
        String disname= 'Cloud Certitude';
        emailmsg.setSenderDisplayName(disname);  
        emailmsg.setHtmlBody(bodyText);
        emailmsg.setFileAttachments(attachments);
        sendingEmailList.add(emailmsg);  
        Messaging.sendEmail(sendingEmailList); 
    }
}