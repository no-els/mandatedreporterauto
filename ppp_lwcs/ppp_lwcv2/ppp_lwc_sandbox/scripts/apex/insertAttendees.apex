// Replace this with a valid Workshop Id from your org
Id workshopId = 'a1DVD0000012rhB2AQ'; 

// Create a list of Attendee__c records
List<Attendee__c> newAttendees = new List<Attendee__c>{
    new Attendee__c(Name = 'John Doe', Client__c = '003VD00000SHKGrYAP', Workshop__c = workshopId),
    new Attendee__c(Name = 'Jane Smith', Client__c = '003VD00000L5UkXYAV', Workshop__c = workshopId)
};

// Insert the attendees
insert newAttendees;

// Debug to confirm insertion
System.debug('Inserted Attendees: ' + newAttendees);