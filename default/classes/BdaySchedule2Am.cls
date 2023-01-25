global class BdaySchedule2Am implements Schedulable{ 
     global String settime ='2PM-8PM';
    global void execute(SchedulableContext sc){
        BdayBatchClass bdy =new BdayBatchClass(settime);
        database.executeBatch(bdy);
    }
    
}