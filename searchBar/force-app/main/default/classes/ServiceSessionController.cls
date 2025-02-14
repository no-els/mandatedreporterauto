public with sharing class ServiceSessionController {
    @AuraEnabled
    public static void addContactsToSession(Id sessionId, List<Id> contactIds) {
        List<pmdm__ProgramEngagement__c> engagements = new List<pmdm__ProgramEngagement__c>();

        for (Id contactId : contactIds) {
            engagements.add(new pmdm__ProgramEngagement__c(
                Contact__c = contactId,
                Service_Session__c = sessionId
            ));
        }

        insert engagements;
    }
}
