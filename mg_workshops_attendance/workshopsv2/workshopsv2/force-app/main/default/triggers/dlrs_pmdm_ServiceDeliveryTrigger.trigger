/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
trigger dlrs_pmdm_ServiceDeliveryTrigger on pmdm__ServiceDelivery__c
    (before delete, before insert, before update, after delete, after insert, after undelete, after update)
{
    dlrs.RollupService.triggerHandler(pmdm__ServiceDelivery__c.SObjectType);
}