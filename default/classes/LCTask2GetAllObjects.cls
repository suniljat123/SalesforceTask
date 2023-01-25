public  class LCTask2GetAllObjects  {    
    @auraEnabled
    public static List<ObjectPermissions> getAllObjects(){ 
        List<ObjectPermissions> returnObj= new List<ObjectPermissions>();
        List<ObjectPermissions> allObject=[SELECT Id,SObjectType FROM ObjectPermissions];
        for(ObjectPermissions obj:allObject){
            returnObj.add(obj);
        } 
        return returnObj;
    }
    @auraEnabled
    public static List<String> getAllFeilds( String objname){ 
        String type=objname;
        List<string> allFeilds= new List<String>();
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();         
        Schema.SObjectType leadSchema = schemaMap.get(type);
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();         
        for(String a:fieldMap.keyset()){
            allFeilds.add(fieldMap.get(a).getDescribe().getName()); 
        } 
        return allFeilds;        
    }
    @AuraEnabled
    public static list<sobject> showAllRecordsvalue(String query){    
        return Database.query(query); 
    }
    @auraEnabled
    public static  String  returnQuery(List<String> selected,String objName){
         String query = 'SELECT '; 
        for(String addFeild:selected ){
            query=query+addFeild+',';
        } 
        query=query.removeEnd(','); 
        query=query+' From  '+objName ;
        return query;
    }
    @auraEnabled
    public static List<String> getApiLabelType( String objName,List<String> selected){  
        String type=objName; 
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType leadSchema = schemaMap.get(type);
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();   
        List<String> finalList=new List<String>(); 
        for(Integer i=0;i<selected.size();i++){
            finalList.add(fieldMap.get(selected[i]).getDescribe().getName());             
        } 
        return finalList;        
    }
    @AuraEnabled
    public static List<String> seprateQuery(String query){ 
        List<String> allFeilds = new List<String>(); 
        query=query.substring(6,query.indexOf('From') ); 
        query=query.trim(); 
         allFeilds=query.split(','); 
        Return allFeilds;
    }
    @AuraEnabled
    public static String trimQuery(String query){ 
        query=query.substring(0,query.indexOf('WHERE') ); 
        query=query.trim();  
        return query;
    }
    
}