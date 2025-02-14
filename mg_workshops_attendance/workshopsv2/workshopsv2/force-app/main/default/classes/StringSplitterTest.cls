/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class StringSplitterTest {

    @isTest
    static void testSplitString() {
        // Step 1: Prepare test data (requests)
        StringSplitter.Request req1 = new StringSplitter.Request();
        req1.commaSeparatedString = 'Apple,Banana,Cherry';

        StringSplitter.Request req2 = new StringSplitter.Request();
        req2.commaSeparatedString = '  Dog, Cat ,  Fish ';

        StringSplitter.Request req3 = new StringSplitter.Request();
        req3.commaSeparatedString = '';

        StringSplitter.Request req4 = new StringSplitter.Request();
        req4.commaSeparatedString = null; // Null input

        List<StringSplitter.Request> requests = new List<StringSplitter.Request>{ req1, req2, req3, req4 };

        // Step 2: Call the method
        Test.startTest();
        List<StringSplitter.Response> responses = StringSplitter.splitString(requests);
        Test.stopTest();

        // Step 3: Assertions for each response
        // Response 1: 'Apple,Banana,Cherry'
        System.assertEquals(3, responses[0].splitStrings.size(), 'Expected 3 items in the first response');
        System.assertEquals('Apple', responses[0].splitStrings[0], 'First item should be "Apple"');
        System.assertEquals('Banana', responses[0].splitStrings[1], 'Second item should be "Banana"');
        System.assertEquals('Cherry', responses[0].splitStrings[2], 'Third item should be "Cherry"');

        // Response 2: '  Dog, Cat ,  Fish '
        System.assertEquals(3, responses[1].splitStrings.size(), 'Expected 3 items in the second response');
        System.assertEquals('  Dog', responses[1].splitStrings[0], 'First item should be "  Dog" (leading spaces preserved)');
        System.assertEquals(' Cat ', responses[1].splitStrings[1], 'Second item should be " Cat " (spaces preserved)');
        System.assertEquals('  Fish ', responses[1].splitStrings[2], 'Third item should be "  Fish " (spaces preserved)');

        // Response 3: Empty string
        System.assertEquals(0, responses[2].splitStrings.size(), 'Expected no items in the third response');

        // Response 4: Null string
        System.assertEquals(0, responses[3].splitStrings.size(), 'Expected no items in the fourth response');
    }
}