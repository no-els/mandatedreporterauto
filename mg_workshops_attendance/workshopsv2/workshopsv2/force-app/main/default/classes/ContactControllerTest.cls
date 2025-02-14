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
public class ContactControllerTest {

    // Set up test data and run test cases
    @isTest
    static void testSearchContacts() {
        // Step 1: Create test data
        List<Contact> testContacts = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe'),
            new Contact(FirstName = 'Jane', LastName = 'Smith'),
            new Contact(FirstName = 'Jake', LastName = 'Johnson')
        };
        insert testContacts;

        // Step 2: Test with a search term that should return results
        Test.startTest();
        List<Contact> results = ContactController.searchContacts('Ja');
        Test.stopTest();
        
        // Step 3: Assertions for expected results
        System.assertNotEquals(0, results.size(), 'Expected some results for search term "Ja"');
        System.assertEquals(2, results.size(), 'Expected 2 results for search term "Ja"');
        
        // Verify that the returned contacts match expected values
        Set<String> expectedNames = new Set<String>{'Jane Smith', 'Jake Johnson'};
        for (Contact c : results) {
            System.assert(expectedNames.contains(c.Name), 'Unexpected contact found: ' + c.Name);
        }

        // Step 4: Test with a search term that should return no results
        List<Contact> noResults = ContactController.searchContacts('XYZ');
        System.assertEquals(0, noResults.size(), 'Expected no results for search term "XYZ"');
    }
}