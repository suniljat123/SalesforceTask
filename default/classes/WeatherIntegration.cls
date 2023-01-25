public class WeatherIntegration{
    @AuraEnabled
    public static String for1Day(String city){ 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://visual-crossing-weather.p.rapidapi.com/forecast?aggregateHours=1&contentType=json&location='+city); 
        request.setMethod('GET'); 
        request.setHeader('X-RapidAPI-Key','543183bff4msha4a50c7f88baa02p1dd8e8jsnd2c13ebe19ca');
        request.setHeader( 'X-RapidAPI-Host', 'visual-crossing-weather.p.rapidapi.com');
        HttpResponse response = http.send(request);   
        return response.getBody(); 
    } 
     @AuraEnabled
    public static String for15Days(String city){ 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://visual-crossing-weather.p.rapidapi.com/forecast?aggregateHours=24&contentType=json&location='+city); 
        request.setMethod('GET'); 
        request.setHeader('X-RapidAPI-Key','543183bff4msha4a50c7f88baa02p1dd8e8jsnd2c13ebe19ca');
        request.setHeader( 'X-RapidAPI-Host', 'visual-crossing-weather.p.rapidapi.com');
        HttpResponse response = http.send(request);   
        return response.getBody(); 
    }
}