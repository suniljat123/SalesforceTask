public class Github {
    @AuraEnabled
    public static String getUserData(String userName){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.github.com/users/'+userName); 
        request.setMethod('GET'); 
        HttpResponse response = http.send(request);  
        if(response.getStatusCode() == 200) {   
            return response.getBody();
        }
        else{
            return NULL;
        } 
    }
    
}