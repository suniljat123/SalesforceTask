public class objectforOpportunitySRNTriggerHandler {
    Public Static void deleteError(List<objectforOpportunityserialnumber__c> newList){
        for(objectforOpportunityserialnumber__c opp:newList){
            if(opp.Id=='a095g000004FENiAAO'){
                opp.addError('You Can\'t Delete This Record Because This Record Provide Some Special Functionality');
            }
            
        }
    }

}