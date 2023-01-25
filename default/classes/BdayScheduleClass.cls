global class BdayScheduleClass implements Schedulable {
    global String settime ='9AM-2PM';
    global void execute(SchedulableContext sc){
        BdayBatchClass bdy =new BdayBatchClass(settime);
        database.executeBatch(bdy);
    }    
}