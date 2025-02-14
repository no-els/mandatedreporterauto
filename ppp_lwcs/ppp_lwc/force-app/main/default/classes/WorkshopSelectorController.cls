public with sharing class WorkshopSelectorController {

    @AuraEnabled
    public static void addParticipantToWorkshop(Id workshopId, Id participantId) {
        try {
            Attendee__c newAttendee = new Attendee__c(
                Workshop__c = workshopId,
                Client__c = participantId
            );
            insert newAttendee;
        } catch (Exception e) {
            throw new AuraHandledException('Error adding participant: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void removeParticipantFromWorkshop(Id workshopId, Id participantId) {
        try {
            List<Attendee__c> attendees = [SELECT Id FROM Attendee__c 
                                           WHERE Workshop__c = :workshopId 
                                           AND Client__c = :participantId];

            if (!attendees.isEmpty()) {
                delete attendees;
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error removing participant: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Attendee__c> getWorkshopParticipants(Id workshopId) {
        return [SELECT Id, Client__c, Client__r.Name 
                FROM Attendee__c 
                WHERE Workshop__c = :workshopId];
    }
}
