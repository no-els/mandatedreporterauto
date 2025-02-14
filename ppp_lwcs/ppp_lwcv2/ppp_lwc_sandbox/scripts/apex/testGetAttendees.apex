// Replace 'a1DVD0000012rhB2AQ' with a valid Workshop Id in your org
Id testWorkshopId = 'a1DVD0000012rhB2AQ';

// Call the method from WorkshopController
List<Attendee__c> attendees = WorkshopController.getAttendees(testWorkshopId);

// Output results to debug log
System.debug('Total Attendees: ' + attendees.size());
for (Attendee__c attendee : attendees) {
    System.debug('Attendee Name: ' + attendee.Name + ', Client: ' + attendee.Client__c + ', Workshop: ' + attendee.Workshop__c);
}