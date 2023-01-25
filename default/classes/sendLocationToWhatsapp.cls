public class sendLocationToWhatsapp {
    @AuraEnabled
    Public Static Boolean sendLocation(String Latitude,String Longitude, String Address){ 
            String Whatsapp_number='917878438668';  
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://graph.facebook.com/v15.0/100298942960882/messages'); 
            request.setMethod('POST');
            request.setHeader('Content-Type','application/json');
            String body='{"messaging_product": "whatsapp","to":"'+Whatsapp_number+'","type": "location","location": {"longitude": "'+Longitude+'","latitude": "'+Latitude+'","name": "'+Address+'","address": "'+Address+'"}}';  //"text","text": {"body":"Hello '+Name+'"}}';
            request.setBody(body);
            System.debug('body()=>'+body);
            String apiToken ='EAARHMX88gFkBAMHWWHZB6CkkzAkObBpxzxzNbZBLQVBV9TXDcRPMsINWUZCWcdqjkJr6R1pK5sN3I0XhyoegIvBK6j5eqBVD9fYqVD0r4tZBJ71Fu2UyHyBPXIzZAzliBs5G51eEnPBCM1aMYGzzFbqbVRasTu2H2LJLKffqIasE7w8C4WIWmVGW0OxHz6ZCkSZBOnEclKCMtzgIuqJYMpB';
            request.setHeader('Authorization','Bearer '+apiToken); // You can get api Token on=>https://developers.facebook.com/apps/1204177820483673/whatsapp-business/wa-dev-console/?business_id=210112051387960
            HttpResponse response = http.send(request);  
            System.debug('response.getStatusCode()=>'+response.getStatusCode());
            System.debug('response()=>'+response.getBody());
            if(response.getStatusCode() == 200) {   
                  return true;
            }
            else{
                  return false;
            }
    }
}