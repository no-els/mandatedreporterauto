// Fetch a test service session ID
Id serviceSessionId = [SELECT Id FROM pmdm__ServiceSession__c LIMIT 1].Id;
// Fetch contact IDs
List<Id> contactIds = new List<Id>();
for (Contact c : [SELECT Id FROM Contact LIMIT 5]) {
    contactIds.add(c.Id);
}

ServiceHandler.processServiceSession(serviceSessionId, contactIds);