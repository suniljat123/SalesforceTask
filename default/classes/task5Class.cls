public class task5Class{
    Public Id inputId{get;set;}
    Public List<ContentDocumentLink> recList{get;set;} 
    Public List<Attachment> attList{get;set;}
    Public Attachment myfile;
    Public task5Class(ApexPages.StandardController controller){
       
       recList=new List<ContentDocumentLink>();
        
    }
    Public Attachment getmyfile(){
        myfile = new Attachment();
        return myfile;
    }  
    Public Integer idx1{get;set;}
    Public Integer idx2{get;set;}
    Public Void Search(){
         recList=[SELECT ContentDocument.CreatedBy.Name,ContentDocument.ContentSize,ContentDocument.Title, ContentDocument.LastModifiedDate  FROM ContentDocumentLink where LinkedEntityId=:inputId];
         attList=[SELECT Name, LastModifiedDate, BodyLength FROM Attachment Where ParentId=:inputId]; 
    }
    Public Void upload(){ 
        Attachment a = new Attachment(parentId = inputId, name=myfile.name, body = myfile.body); 
    	 attList.add(a);
        upsert attList;
  		Search();   
    } 
    Public Void delete1(){
        ContentDocumentLink a= recList.remove(idx1);      
         delete a;    
    }
    Public Void delete2(){
         Attachment a = attList.remove(idx2); 
         delete a;
    }
}