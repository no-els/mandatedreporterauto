public with sharing class WorkshopParticipantListController {
    @AuraEnabled(cacheable=true)
    public static List<Attendee__c> getWorkshopParticipants(String workshopId) {
        return [SELECT Id, Name, Client__c FROM Attendee__c WHERE Workshop__c = :workshopId];
    }
}
