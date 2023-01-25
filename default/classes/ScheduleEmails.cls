public class ScheduleEmails implements Schedulable {
    Public void execute(System.SchedulableContext sc){
        BatchAccountCheckRating rec=new BatchAccountCheckRating();
        database.executeBatch(rec);
        
    }
    
}