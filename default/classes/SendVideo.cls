public class SendVideo {
    public static void sendVideoOnWhatsapp(){
        String Whatsapp_number='917878438668';  
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://graph.facebook.com/v15.0/100298942960882/messages'); 
            request.setMethod('POST');
            request.setHeader('Content-Type','application/json');
            String body='{"messaging_product": "whatsapp","to":"'+Whatsapp_number+'","type": "image","image":{"link": "https://i.imgur.com/hZAgpQW.jpg"}}';  //"text","text": {"body":"Hello '+Name+'"}}';
            request.setBody(body);
            System.debug('body()=>'+body);
            String apiToken ='EAARHMX88gFkBACR7534I8vpahv4pu7XeWxHCQDWaZBAPrlBrUegXURazIbmO5osYTz5gVUKWWWI0ZC5bJnNyRVT48L9XMSmZBq9RNmzAtgddx2tK1GXdGoVeLXQFx7lHltQcKMEJFkwFamjfXdI6YHKjj3GNtdyabewYfMMiukXU6BkvZBvXgOoHLjLrkGTQkwUyvtCUS0dfOsgmPYGD';
            request.setHeader('Authorization','Bearer '+apiToken);
            HttpResponse response = http.send(request);  
            System.debug('response.getStatusCode()=>'+response.getStatusCode());
            System.debug('response()=>'+response.getBody());
            if(response.getStatusCode() == 200) {   
                // return true;
            }
            else{
                // return false;
            }
    }

}