/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_pmdm_ServiceDeliveryTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_pmdm_ServiceDeliveryTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new pmdm__ServiceDelivery__c());
    }
}