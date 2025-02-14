@IsTest
public class UniqueRandomNumberGeneratorTest {

    // Test case: Generate random numbers within a valid range where min and max are 1 and 5, and count is 5
    @IsTest
    static void testGenerateRandomNumbersValidRange() {
        // Prepare input parameters
        UniqueRandomNumberGenerator.Inputs input = new UniqueRandomNumberGenerator.Inputs();
        input.min = 1;
        input.max = 5;
        input.count = 5;
        input.allowedList = new List<String>{'1', '2', '3', '4', '5'};

        // Add the input to a list as required by the invocable method
        List<UniqueRandomNumberGenerator.Inputs> inputList = new List<UniqueRandomNumberGenerator.Inputs>{input};

        // Execute the method inside a test context
        Test.startTest();
        List<List<String>> result = UniqueRandomNumberGenerator.generateRandomNumbers(inputList);
        Test.stopTest();

        // Verify the result contains 5 unique numbers
        System.assertEquals(1, result.size());
        System.assertEquals(5, result[0].size());
        Set<String> uniqueCheck = new Set<String>(result[0]);
        System.assertEquals(5, uniqueCheck.size());  // Check that all numbers are unique
    }

    // Test case: Generate random numbers within a larger range where min is 1, max is 10, and count is 5
    @IsTest
    static void testGenerateRandomNumbersWithLargerRange() {
        // Prepare input parameters
        UniqueRandomNumberGenerator.Inputs input = new UniqueRandomNumberGenerator.Inputs();
        input.min = 1;
        input.max = 10;
        input.count = 5;
        input.allowedList = new List<String>{'1', '3', '5', '7', '9', '10'};

        // Add the input to a list
        List<UniqueRandomNumberGenerator.Inputs> inputList = new List<UniqueRandomNumberGenerator.Inputs>{input};

        // Execute the method inside a test context
        Test.startTest();
        List<List<String>> result = UniqueRandomNumberGenerator.generateRandomNumbers(inputList);
        Test.stopTest();

        // Verify the result contains 5 unique numbers within the allowed list
        System.assertEquals(1, result.size());
        System.assertEquals(5, result[0].size());
        Set<String> uniqueCheck = new Set<String>(result[0]);
        System.assertEquals(5, uniqueCheck.size());
        for (String numbertocheck : uniqueCheck) {
            System.assert(input.allowedList.contains(numbertocheck));
        }
    }

    // Test case: Generate a single random number where min and max are both set to 10
    @IsTest
    static void testGenerateRandomNumbersWithSingleNumber() {
        // Prepare input parameters
        UniqueRandomNumberGenerator.Inputs input = new UniqueRandomNumberGenerator.Inputs();
        input.min = 10;
        input.max = 10;
        input.count = 1;
        input.allowedList = new List<String>{'10'};

        // Add the input to a list
        List<UniqueRandomNumberGenerator.Inputs> inputList = new List<UniqueRandomNumberGenerator.Inputs>{input};

        // Execute the method inside a test context
        Test.startTest();
        List<List<String>> result = UniqueRandomNumberGenerator.generateRandomNumbers(inputList);
        Test.stopTest();

        // Verify the result contains exactly 1 number, which should be "10"
        System.assertEquals(1, result.size());
        System.assertEquals(1, result[0].size());
        System.assertEquals('10', result[0][0]);
    }

    // Test case: Generate random numbers with a small range where min is 5, max is 7, and count is 3
    @IsTest
    static void testGenerateRandomNumbersWithSmallRangeAndCount() {
        // Prepare input parameters
        UniqueRandomNumberGenerator.Inputs input = new UniqueRandomNumberGenerator.Inputs();
        input.min = 5;
        input.max = 7;
        input.count = 3;
        input.allowedList = new List<String>{'5', '6', '7'};

        // Add the input to a list
        List<UniqueRandomNumberGenerator.Inputs> inputList = new List<UniqueRandomNumberGenerator.Inputs>{input};

        // Execute the method inside a test context
        Test.startTest();
        List<List<String>> result = UniqueRandomNumberGenerator.generateRandomNumbers(inputList);
        Test.stopTest();

        // Verify the result contains 3 unique numbers within the range 5 to 7
        System.assertEquals(1, result.size());
        System.assertEquals(3, result[0].size());
        Set<String> uniqueCheck = new Set<String>(result[0]);
        System.assertEquals(3, uniqueCheck.size());
        for (String numbertocheck : uniqueCheck) {
            System.assert(input.allowedList.contains(numbertocheck));
        }
    }

    // Test case: Handle the scenario where count exceeds the possible unique numbers in the range
    @IsTest
    static void testGenerateRandomNumbersCountExceedsRange() {
        // Prepare input parameters
        UniqueRandomNumberGenerator.Inputs input = new UniqueRandomNumberGenerator.Inputs();
        input.min = 1;
        input.max = 3;
        input.count = 5;  // This exceeds the range (1-3), should default to max 3
        input.allowedList = new List<String>{'1', '2', '3'};

        // Add the input to a list
        List<UniqueRandomNumberGenerator.Inputs> inputList = new List<UniqueRandomNumberGenerator.Inputs>{input};

        // Execute the method inside a test context
        Test.startTest();
        List<List<String>> result = UniqueRandomNumberGenerator.generateRandomNumbers(inputList);
        Test.stopTest();

        // Verify the result contains 3 unique numbers, the maximum possible for the range 1 to 3
        System.assertEquals(1, result.size());
        System.assertEquals(3, result[0].size());
        Set<String> uniqueCheck = new Set<String>(result[0]);
        System.assertEquals(3, uniqueCheck.size());
        for (String numbertocheck : uniqueCheck) {
            System.assert(input.allowedList.contains(numbertocheck));
        }
    }

    // Test case: Handle the scenario where an allowed number is out of the range
    @IsTest
    static void testGenerateRandomNumbersWithOutOfRangeAllowedNumber() {
        // Prepare input parameters
        UniqueRandomNumberGenerator.Inputs input = new UniqueRandomNumberGenerator.Inputs();
        input.min = 1;
        input.max = 5;
        input.count = 3;
        input.allowedList = new List<String>{'1', '2', '6'};  // '6' is out of range and should be ignored

        // Add the input to a list
        List<UniqueRandomNumberGenerator.Inputs> inputList = new List<UniqueRandomNumberGenerator.Inputs>{input};

        // Execute the method inside a test context
        Test.startTest();
        List<List<String>> result = UniqueRandomNumberGenerator.generateRandomNumbers(inputList);
        Test.stopTest();

        // Verify the result contains 2 unique numbers within the range 1 to 5 (as '6' should be ignored)
        System.assertEquals(1, result.size());
        System.assertEquals(2, result[0].size());
        Set<String> uniqueCheck = new Set<String>(result[0]);
        System.assertEquals(2, uniqueCheck.size());
        System.assert(uniqueCheck.contains('1') || uniqueCheck.contains('2'));
        System.assert(!uniqueCheck.contains('6'));  // Ensure '6' is not in the results
    }
}