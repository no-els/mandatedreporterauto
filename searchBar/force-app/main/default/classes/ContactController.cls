public with sharing class ServiceSessionController {
    @AuraEnabled
    public static void addContactsToSession(Id sessionId, List<Id> contactIds) {
        List<pmdm__ProgramEngagement__c> engagements = new List<pmdm__ProgramEngagement__c>();

        for (Id contactId : contactIds) {
            engagements.add(new pmdm__ProgramEngagement__c(
                pmdm__Contact__c = contactId,         // Use actual field name if different
                pmdm__Service_Session__c = sessionId  // Use actual field name if different
            ));
        }

        insert engagements;
    }
}
