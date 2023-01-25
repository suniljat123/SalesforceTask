public with sharing class Covid {
    @AuraEnabled
    public Static string getCovidDetails(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://data.covid19india.org/v4/min/data.min.json'); 
        request.setMethod('GET'); 
        HttpResponse response = http.send(request); 
        System.debug('response.getStatusCode()=>'+response.getStatusCode()); 
        if(response.getStatusCode() == 200) {   
            return response.getBody();
        }
        else{
            return NULL;
        } 
    }
    
}