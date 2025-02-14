public class ServiceHandler {
    
    // Fetch Service Session Details
    public static pmdm__ServiceSession__c fetchServiceSession(Id serviceSessionId) {
        pmdm__ServiceSession__c serviceSession = [
            SELECT Id, Name 
            FROM pmdm__ServiceSession__c 
            WHERE Id = :serviceSessionId 
            LIMIT 1
        ];
        System.debug('Fetched Service Session: ' + serviceSession);
        return serviceSession;
    }

    // Fetch Existing Program Engagements
    public static Map<Id, Program_Engagement__c> fetchProgramEngagements(List<Id> contactIds) {
        Map<Id, Program_Engagement__c> programEngagementMap = new Map<Id, Program_Engagement__c>();
        for (Program_Engagement__c engagement : [
            SELECT Id, Contact__c 
            FROM Program_Engagement__c 
            WHERE Contact__c IN :contactIds
        ]) {
            programEngagementMap.put(engagement.Contact__c, engagement);
        }
        System.debug('Fetched Program Engagements: ' + programEngagementMap);
        return programEngagementMap;
    }

    // Fetch Existing Program Participants
    public static Map<Id, Program_Participant__c> fetchProgramParticipants(List<Id> contactIds) {
        Map<Id, Program_Participant__c> programParticipantMap = new Map<Id, Program_Participant__c>();
        for (Program_Participant__c participant : [
            SELECT Id, Contact__c, Service_Session__c 
            FROM Program_Participant__c 
            WHERE Contact__c IN :contactIds
        ]) {
            programParticipantMap.put(participant.Contact__c, participant);
        }
        System.debug('Fetched Program Participants: ' + programParticipantMap);
        return programParticipantMap;
    }

    // Process Service Session for Contacts
    public static void processServiceSession(Id serviceSessionId, List<Id> contactIds) {
        // Step 1: Fetch Service Session
        pmdm__ServiceSession__c serviceSession = fetchServiceSession(serviceSessionId);

        // Step 2: Fetch Existing Records
        Map<Id, Program_Engagement__c> programEngagements = fetchProgramEngagements(contactIds);
        Map<Id, Program_Participant__c> programParticipants = fetchProgramParticipants(contactIds);

        // Step 3: Prepare Lists for DML
        List<Program_Engagement__c> newEngagements = new List<Program_Engagement__c>();
        List<Program_Participant__c> newParticipants = new List<Program_Participant__c>();
        List<Program_Participant__c> updatedParticipants = new List<Program_Participant__c>();

        // Step 4: Process Each Contact
        for (Id contactId : contactIds) {
            // Check or Create Program Engagement
            if (!programEngagements.containsKey(contactId)) {
                Program_Engagement__c newEngagement = new Program_Engagement__c(
                    Contact__c = contactId,
                    Program_Name__c = serviceSession.Name // Example mapping
                );
                newEngagements.add(newEngagement);
            }

            // Check or Create Program Participant
            if (!programParticipants.containsKey(contactId)) {
                Program_Participant__c newParticipant = new Program_Participant__c(
                    Contact__c = contactId,
                    Service_Session__c = serviceSessionId
                );
                newParticipants.add(newParticipant);
            } else {
                // Update Existing Participant
                Program_Participant__c existingParticipant = programParticipants.get(contactId);
                existingParticipant.Status__c = 'Updated'; // Example update
                updatedParticipants.add(existingParticipant);
            }
        }

        // Step 5: Perform DML Operations
        if (!newEngagements.isEmpty()) {
            insert newEngagements;
            System.debug('Inserted Program Engagements: ' + newEngagements.size());
        }
        if (!newParticipants.isEmpty()) {
            insert newParticipants;
            System.debug('Inserted Program Participants: ' + newParticipants.size());
        }
        if (!updatedParticipants.isEmpty()) {
            update updatedParticipants;
            System.debug('Updated Program Participants: ' + updatedParticipants.size());
        }
    }
}

