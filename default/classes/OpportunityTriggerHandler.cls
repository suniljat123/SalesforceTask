public class OpportunityTriggerHandler {   
    Public Static void setSerialNumber(List<Opportunity> oppList){ 
        objectforOpportunityserialnumber__c   SerialNumber = [Select id,MaxSrNumber__c from objectforOpportunityserialnumber__c WHERE Id='a095g000004FENiAAO'] ;
         Decimal Srno; 
        Srno=SerialNumber.MaxSrNumber__c;   
        for(Opportunity opp:oppList){  
             Srno=Srno+1;  
             opp.Serial_Number__c=Srno;    
         }
        SerialNumber.MaxSrNumber__c=Srno;  
        update SerialNumber; 
    }

}