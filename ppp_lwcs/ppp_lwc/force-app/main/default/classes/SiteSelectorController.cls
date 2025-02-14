public with sharing class SiteSelectorController {
    @AuraEnabled(cacheable=true)
    public static List<String> getSites() {
        Schema.DescribeFieldResult fieldResult = Contact.Site__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();
        List<String> sites = new List<String>();
        for (Schema.PicklistEntry entry : picklistValues) {
            sites.add(entry.getValue());
        }
        return sites;
    }
}
