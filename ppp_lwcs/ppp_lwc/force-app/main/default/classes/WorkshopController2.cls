public with sharing class WorkshopController {
    @AuraEnabled(cacheable=true)
    public static List<Workshop__c> searchWorkshops(String searchTerm) {
        String query = '%' + searchTerm + '%';
        return [SELECT Id, Name, Workshop_Date__c, Site__c FROM Workshop__c WHERE Name LIKE :query LIMIT 10];
    }
}
