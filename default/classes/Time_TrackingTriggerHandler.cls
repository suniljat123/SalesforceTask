public class Time_TrackingTriggerHandler {
    Public Static void checkHours(List<Time_Tracking__c> newList,List<Time_Tracking__c> oldList, Map<Id,Time_Tracking__c> oldmap){
        set<Date> dateSet=new set<Date>();
        for(Time_Tracking__c rec : newList){
            dateSet.add(rec.date__c);
        }
        List<AggregateResult> sum=[Select Name name,sum(Hours__c) ss From Time_Tracking__c where date__c In:dateSet  Group By Name]; 
        List<Time_Tracking__c> recList=[Select Id,Name,date__c from Time_Tracking__c]; 
        Map<String,Decimal> mapList = new  Map<String,Decimal>(); 
        for(AggregateResult rec : sum){
            mapList.put((String)rec.get('name') ,(Decimal)rec.get('ss')); 
        } 
        for(Time_Tracking__c rec : newList){ 
            if(mapList.containskey(rec.name)){  
                if(mapList.get(rec.name)+rec.Hours__c>24){ 
                    rec.Hours__c.addError('Your Remaining Hours='+(24-mapList.get(rec.name)));
                }    
            }
            else{
                if(rec.Hours__c>24){
                    rec.Hours__c.addError('Hours Should Be Less Than Or Equal To 24');
                } 
            }
        }
    } 
    Public Static void checkUpdatedHours(List<Time_Tracking__c> newList,List<Time_Tracking__c> oldList, Map<Id,Time_Tracking__c> oldmap,Map<Id,Time_Tracking__c> newmap){
        set<Date> dateSet=new set<Date>();
        for(Time_Tracking__c rec : newList){ 
            dateSet.add(rec.date__c);
        }
        List<AggregateResult> sum=[Select Name name,sum(Hours__c) ss From Time_Tracking__c where date__c In:dateSet  Group By Name];  
        List<Time_Tracking__c> recList=[Select Id,Name,date__c from Time_Tracking__c]; 
        Map<String,Decimal> mapList = new  Map<String,Decimal>(); 
        for(AggregateResult rec : sum){
            mapList.put((String)rec.get('name') ,(Decimal)rec.get('ss'));
            
        } 
        for(Time_Tracking__c oldrec : oldList){ 
            if(oldrec.Date__c!=NULL && oldrec.Date__c==newmap.get(oldrec.id).date__c ){         
                Decimal i=	mapList.get(oldrec.name)-oldrec.Hours__c; 
                mapList.put(oldrec.Name,i);
            }
            
        }
        for(Time_Tracking__c rec : newList){ 
            if(mapList.containskey(rec.name)){    
                Decimal sum1 =mapList.get(rec.name)+rec.Hours__c;
                if(sum1>24){  
                    rec.Hours__c.addError('Your Remaining Hours='+(24-mapList.get(rec.name)));
                } 
                
            }
            else{
                if(rec.Hours__c>24){
                    rec.Hours__c.addError('Hours Should Be Less Than Or Equal To 24');
                    
                } 
            } 
        }
    }
    Public Static void undeleteRecord(List<Time_Tracking__c> newList, Map<Id,Time_Tracking__c> oldmap,Map<Id,Time_Tracking__c> newmap){
        set<Date> dateSet=new set<Date>();
        for(Time_Tracking__c rec : newList){
            dateSet.add(rec.date__c);
        }
        List<AggregateResult> sum=[Select Name name,sum(Hours__c) ss From Time_Tracking__c where date__c In:dateSet  Group By Name];   
        Map<String,Decimal> mapList = new  Map<String,Decimal>(); 
        for(AggregateResult rec : sum){  
            mapList.put((String)rec.get('name') ,(Decimal)rec.get('ss')); 
        }  
        for(Time_Tracking__c rec : newList){  
            if(mapList.containskey(rec.name)){   
                if(mapList.get(rec.name)-newmap.get(rec.Id).Hours__c+rec.Hours__c>24){ 
                    rec.Hours__c.addError('Your Remaining Hours='+(24-mapList.get(rec.name)));
                }    
            } 
        }
    }
}