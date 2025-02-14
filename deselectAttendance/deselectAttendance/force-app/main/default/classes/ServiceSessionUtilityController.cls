public with sharing class ServiceSessionUtilityController {
    @AuraEnabled
    public static void updateAttendeeStatus(Id serviceSessionId, String status) {
        List<Attendee__c> attendees = [SELECT Id FROM Attendee__c WHERE ServiceSession__c = :serviceSessionId];
        for (Attendee__c attendee : attendees) {
            attendee.AttendanceStatus__c = status; // Update to "Not Present" or the appropriate status for deselection
        }
        update attendees;
    }
}
