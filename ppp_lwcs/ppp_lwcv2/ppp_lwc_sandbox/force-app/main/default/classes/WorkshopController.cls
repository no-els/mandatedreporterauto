public with sharing class WorkshopController {
    @AuraEnabled(cacheable=true)
    public static List<Workshop__c> searchWorkshops(String searchTerm) {
        String query = '%' + searchTerm + '%';
        return [SELECT Id, Name, Date__c, Site__c FROM Workshop__c WHERE Name LIKE :query];
    }
    @AuraEnabled(cacheable=true)
    public static List<Attendee__c> getAttendees(Id workshopId) {
        return [SELECT Name, Client__c, Workshop__c FROM Attendee__c WHERE Workshop__c = :workshopId];
    }
    @AuraEnabled(cacheable=true)
    public static List<Workshop__c> getWorkshop(Id workshopId) {
        return [SELECT Id, Name, Date__c, Site__c FROM Workshop__c WHERE Id =:workshopId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String searchTerm) {
        String query = '%' + searchTerm + '%';
        return [SELECT Id, Name, Phone FROM Contact WHERE Name LIKE :query];
    }
    @AuraEnabled
    public Static String addAttendee(String contactId, String workshopId){
        // Check if this attendee already exists
        List<Attendee__c> existing = [SELECT Id FROM Attendee__c 
        WHERE Client__c = :contactId 
        AND Workshop__c = :workshopId 
        LIMIT 1];
        // Fetch Contact Name
        Contact c = [SELECT Name FROM Contact WHERE Id = :contactId LIMIT 1];

        if (!existing.isEmpty()) {
        return 'Duplicate';
        }
        Attendee__c newAttendee = new Attendee__c(
            Client__c = contactId,
            Workshop__c = workshopId,
            Name = c.name
        );
        insert newAttendee;
        return 'Added';
    }
    @AuraEnabled
    public static String deleteAttendee(String attendeeId) {
        try {
            Attendee__c attendee = [SELECT Id FROM Attendee__c WHERE Id = :attendeeId LIMIT 1];
            delete attendee;
            return 'Success';
            } 
        catch (Exception e) {
            return 'Error: ' + e.getMessage();
            }
    }

}
