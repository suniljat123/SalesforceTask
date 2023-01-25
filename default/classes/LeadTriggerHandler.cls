public class LeadTriggerHandler{  
    Public Static void checkContactExistence(List<Lead> newList,Map<Id,Lead> newMap){ 
        for(Lead leadvar : newList){ 
            if(leadvar.FirstName==NULL){
               
                leadvar.firstname.addError('Please Enter Your FirstName');
            }
        }  
        Map<String,Contact> conMapFirstName=new Map<String,Contact>();
        Map<String,Contact> conMapLastName=new Map<String,Contact>();
        Map<String,Campaign> campMap=new Map<String,Campaign>();
        List<Campaign> campList=[SELECT Id, Name, ParentId, IsActive  FROM Campaign]; 
        for(Contact con:[Select id,name,firstname,lastname from contact]){
            conMapFirstName.put(con.FirstName,con);
            conMapLastName.put(con.LastName,con); 
        } 
        for(Campaign camp:campList){
            campMap.put(camp.Name,camp);
        }        
        List<Contact> conlist = new List<Contact>(); 
        for(Lead leadvar : newList){
             System.debug('fullname=>'+leadvar.name); 
            if(conMapFirstName.containsKey(leadvar.FirstName) && conMapLastName.containsKey(leadvar.LastName)){  
            }
            else{ 
                Contact con =new contact();
                con.FirstName=leadvar.FirstName;
                con.LastName=leadvar.LastName;  
                conlist.add(con);     
            }
        } 
        if(conlist.size()>0){ 
            insert conlist;
        }  
        Map<String,Campaign> campaignMap = new Map<String,Campaign>(); 
        for(Lead leadvar : newList){ 
            if(campMap.containskey(leadvar.Company)){  
            }
            else{ 
                campaign camp= new campaign(IsActive=True);
                camp.Name=leadvar.Company;
                campaignMap.put(leadvar.company ,camp);      
            } 
        } 
        if(campaignMap.size()>0){
            insert campaignMap.values();     
        }            
    } 
    Public Static void addCampaignMember(List<Lead> newList,Map<Id,Lead> newMap){ 
        Set<String> Lname = new Set<String>();
        Set<String> leadCompanyName =new Set<String>(); 
        for(Lead leadvar : newList){  
            Lname.add(leadvar.FirstName+' '+leadvar.LastName);
            leadCompanyName.add(leadvar.company);
        }  
        Map<String,contact> allNewContactsMap=new Map<String,Contact>(); 
        List<Contact> allNewContacts = [SELECT Id,Firstname,Lastname,Name From Contact Where name In :Lname];
        for(Contact c:allNewContacts){ 
            allNewContactsMap.put(c.firstname+' '+c.lastname,c); 
        } 
        List<Campaign> allCampaigns=[SELECT Id,Name from Campaign WHERE Name In:leadCompanyName];
        Map<String,Campaign> allCampaignsMap=new Map<String,Campaign>();
        Map<Id,Campaign> allCampaignsId= new Map<Id,Campaign>();  
        for(Campaign camp:allCampaigns){
            allCampaignsMap.put(camp.Name,camp);  
            allCampaignsId.put(camp.Id,camp);
        } 
        List<CampaignMember> CampaignMemberList=new List<CampaignMember>();
        Map<Id,CampaignMember> CampaignMemberCappaignId=new Map<Id,CampaignMember>();
        Map<Id,CampaignMember> CampaignMemberContactId=new Map<Id,CampaignMember>();
        for(CampaignMember cm:[SELECT Id, CampaignId, ContactId FROM CampaignMember]){
            CampaignMemberCappaignId.put(cm.CampaignId ,cm);
            CampaignMemberContactId.put(cm.ContactId,cm);     
        }
        for(Lead leadvar:newList){
            if(allCampaignsMap.containskey(leadvar.company)){ 
                CampaignMember cm=new CampaignMember(CampaignId=allCampaignsMap.get(leadvar.company).id,ContactId=allNewContactsMap.get(leadvar.firstname+' '+leadvar.lastname).id ,Status='Sent');
                if(CampaignMemberCappaignId.containskey(cm.CampaignId)&&CampaignMemberContactId.containskey(cm.ContactId)){     
                }
                else{
                    CampaignMemberList.add(cm);    
                }    
            } 
        }
        if(CampaignMemberList.size()>0){ 
            insert CampaignMemberList;
        } 
    }
}