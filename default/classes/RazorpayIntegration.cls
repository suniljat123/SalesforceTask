public class RazorpayIntegration {
    public String totalAmount{get;set;} 
     public void payAmount(){
         
    }
    @AuraEnabled
    public Static Map<string,object> payPayment(decimal amount,string currentPageUrl){ 
        amount*=100;
        Http http = new Http(); 
        HttpRequest request = new HttpRequest();
        request.setEndpoint(' https://api.razorpay.com/v1/payment_links');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json'); 
        String username = 'rzp_test_wzPHJ7HsfMm6tE';              
        String password = 'YKeoG7tm1HVSfPfjSWm65rvI';      
        Blob headerValue = Blob.valueOf(username+':'+password);     
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);     
        String requestBody = '{"amount": '+amount+', "currency": "INR", "accept_partial": true, "first_min_partial_amount": 100, "expire_by": 1691097057, "description": "Payment for policy no #23456","notify": { "sms": true, "email": true, "whatsapp":true }, "reminder_enable": true, "callback_url":"https://cloudcertitude-5e-dev-ed--c.develop.vf.force.com/apex/RazorPay?core.apexpages.request.devconsole=1", "callback_method": "get"}';
        request.setBody(requestBody);
        HttpResponse response = http.send(request); 
        System.debug('status code=>'+response.getStatusCode() );
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());    
          return responseMap;
        } else {
            // Handle error 
            return null;
        } 
        
    }
    
}