public with sharing class ParticipantListController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getParticipants(String site) {
        return [SELECT Id, Name FROM Contact WHERE Site__c = :site];
    }
}
