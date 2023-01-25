@RestResource(urlMapping='/ContactAPI/*')
global class apexRest {
    global class ResponseWrapper{
        String message;
        string success;
    }
    @HTTPGet
    global Static List<Contact> getContact(){
        /* RestRequest contactRequest= RestContext.request;
            String contextRequestURL = contactRequest.requestURI;
            Integer contactLimit =Integer.valueOf(contextRequestURL.substring(contextRequestURL.lastIndexOf('/')+1));
            System.debug('contactLimit='+contactLimit);
            System.debug('contextRequestURL='+contextRequestURL);
            List<Contact> conList=[Select FirstName,LastName,Email From Contact Limit :contactLimit ];
            return conList;*/
        RestRequest contactRequest= RestContext.request;
        String contextRequestURL = contactRequest.requestURI;
     //   Map<String,String> contactRequestMap = contactRequest.params;
        Integer contactLimit =Integer.valueOf(contextRequestURL.substring(contextRequestURL.lastIndexOf('/')+1));
        //Integer conLimit =Integer.valueOf(contactRequestMap.get('Limit'));  
        List<Contact> conList=[Select FirstName,LastName,Email From Contact Limit :contactLimit ];
        return conList;
    }
    @HTTPPost
    global Static List<Contact> insertContact(){
        RestRequest contactRequest = RestContext.request;
        String requestBody = contactRequest.requestBody.toString();
        List<Contact> conList= (List<Contact>)JSON.deserialize(requestBody, List<Contact>.class); 
        List<Contact> conToInsert=new List<Contact>();
        for(Contact con : conList){ 
            Contact cont = new Contact();
          	 cont.FirstName=con.FirstName;
            cont.Phone=con.Phone;
            cont.ExternalId__c=con.Id;
            cont.LastName=con.LastName;
            conToInsert.add(cont);
        }
         
        insert conToInsert;
        return conToInsert;
    }
    @HTTPDelete
    global Static Map<String,String> deleteContact(){
        Map<String,String>responseMap=new Map<String,String>();
        RestRequest contactRequest =RestContext.request;
        String contextRequestURL =contactRequest.requestURI; 
        Id conId = Id.valueOf(contextRequestURL.substring(contextRequestURL.lastIndexOf('/')+1));
        Contact con = new Contact(Id=conId);
        /* String []conIds = (contextRequestURL.substring(contextRequestURL.lastIndexOf('/')+1)).split(',');
            List<Contact> conToDelete = new List<Contact>();
            for(String conId :conIds){
            Contact con = new Contact(Id=conId);
            conToDelete.add(con);                                       //To Delete Multiple Contacts
            }
            if(conToDelete.size()>0){
            delete conToDelete;
            }*/
        try{
            delete con;
            responseMap.put('Message','Record Deleted Successfull');
            responseMap.put('Success','1');
        }
        catch(DMLException ex){
            responseMap.put('Message',ex.getMessage());
            responseMap.put('Success','0');
        }
        return responseMap;
    }
    @HTTPPut
    global Static Contact upsertContact(String FirstName ,String LastName){
        Contact con = new Contact();
        RestRequest contextRequest = RestContext.request;
        String contextRequesrURL =contextRequest.requestURI;
        System.debug('contextRequesrURL='+contextRequesrURL);
        String conId =contextRequesrURL.substring(contextRequesrURL.lastIndexOf('/')+1); 
        if(String.isNotEmpty(conId)){
            con.Id=conId;
        }
        con.FirstName=FirstName;
        con.LastName=LastName;
        upsert con;
        return con;
    }
    @HTTPPatch
    global Static List<ResponseWrapper> updateRecords(){
        List<ResponseWrapper> responseWrap = new List<ResponseWrapper>();
        RestRequest contextRequest = RestContext.request;
        String requestBody=contextRequest.requestBody.toString();
        List<Contact> conToUpdate = (List<Contact>)JSON.deserialize(requestBody, List<Contact>.class);
        Database.SaveResult []updateResults = Database.update(conToUpdate, false);
        for(database.SaveResult updateResult:updateResults){
            ResponseWrapper resWrap = new ResponseWrapper();
            if(updateResult.isSuccess()){
                resWrap.success = '1';
                resWrap.message = 'Successfully Updated Contact With Id '+updateResult.getId();
            }
            else{
                resWrap.success = '0';
                for(Database.Error Error :updateResult.getErrors()){
                    resWrap.message = 'Unsuccessfull TO Update Contact With Id '+updateResult.getId()+'.';
                    resWrap.message +=  Error.getStatusCode()+': '+Error.getMessage()+'.' ;
                    resWrap.message += 'Contact Error That Affected this Error :'+Error.getFields()  ;
                }
                
            }
            responseWrap.add(resWrap);
        }
        return responseWrap;
    }
    
}