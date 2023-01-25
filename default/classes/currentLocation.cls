public with sharing class currentLocation { 
    @AuraEnabled
    public Static String getCountries(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.countrystatecity.in/v1/countries');
        request.setMethod('GET'); 
        request.setHeader('X-CSCAPI-KEY','ZHR4THo0ZG1qOGhCQzI3ZDVmMFdHeXJPOE1LQ3Q0YnhWUWNZeURLcQ==');
        HttpResponse response = http.send(request);  
        if(response.getStatusCode() == 200) { 
            return response.getBody();
        }
        else{
            return null;
        }
    }
    @AuraEnabled
    public Static String getStates(string Country){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String Api ='https://api.countrystatecity.in/v1/countries/' +Country +'/states';
        request.setEndpoint(Api);
        request.setMethod('GET'); 
        request.setHeader('X-CSCAPI-KEY','ZHR4THo0ZG1qOGhCQzI3ZDVmMFdHeXJPOE1LQ3Q0YnhWUWNZeURLcQ==');
        HttpResponse response = http.send(request);  
        if(response.getStatusCode() == 200) {    
            List<Object> result = (List<Object> )JSON.deserializeUntyped(response.getBody());  
            return response.getBody();
        }
        else{
            return null;
        }
    }
    @AuraEnabled
    public Static String getDistrict(string country,string state){ 
        System.debug('Country=>'+country);
        System.debug('state=>'+state);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String Api ='https://api.countrystatecity.in/v1/countries/' +Country +'/states/'+state+'/cities'; 
        request.setEndpoint(Api);
        request.setMethod('GET'); 
        request.setHeader('X-CSCAPI-KEY','ZHR4THo0ZG1qOGhCQzI3ZDVmMFdHeXJPOE1LQ3Q0YnhWUWNZeURLcQ==');
        HttpResponse response = http.send(request);  
        if(response.getStatusCode() == 200) {    
            List<Object> result = (List<Object> )JSON.deserializeUntyped(response.getBody());  
            return response.getBody();
        }
        else{
            return null;
        }
    }
}