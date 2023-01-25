public class ScheduleEmailCustomTime implements Schedulable {
    Public void execute(System.SchedulableContext sc){
        BatchAccountCheckRating rec=new BatchAccountCheckRating();
        database.executeBatch(rec);
        
        /*ScheduleEmailCustomTime sq= new ScheduleEmailCustomTime();
        String sch='0 15 10 * * ?';                                //Write this⬅️⬅️⬅️⬅️ code to anonymous window to scheduled batch class at 10:15 AM EveryDay
        System.schedule('Hello',sch,sq);       */ 
    }    
}