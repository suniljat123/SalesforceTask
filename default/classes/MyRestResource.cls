@RestResource(urlMapping='/AccountAPI')
global with sharing class MyRestResource {
    @HttpGet
    global static List<Account> getRecord() {
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response; 
        List<Account> accountList=[SELECT Id,Name,Phone,Description,Rating FROM Account ];
        return accountList;
    }
}