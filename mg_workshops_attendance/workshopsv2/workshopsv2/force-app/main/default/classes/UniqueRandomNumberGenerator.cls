public class UniqueRandomNumberGenerator {

    // Invocable method that can be called from Salesforce Flow
    @InvocableMethod
    public static List<List<String>> generateRandomNumbers(List<Inputs> inputList) {
        // Initialize a list to hold the results, which will be a list of string collections
        List<List<String>> allNumbers = new List<List<String>>();

        // Iterate over each input provided in the inputList
        for (Inputs input : inputList) {
            // Extract minimum, maximum, and count from the input
            Integer min = input.min;
            Integer max = input.max;
            Integer count = input.count;
            Set<Integer> allowedSet = new Set<Integer>();

            // Convert allowedList strings to integers and add to the allowedSet
            for (String num : input.allowedList) {
                Integer allowedNumber = Integer.valueOf(num);
                if (allowedNumber >= min && allowedNumber <= max) {
                    allowedSet.add(allowedNumber);
                }
            }

            // Calculate the maximum possible unique numbers in the allowed set
            Integer maxUniqueCount = allowedSet.size();

            // If the requested count exceeds the possible unique numbers, default to the maximum possible
            if (count > maxUniqueCount) {
                count = maxUniqueCount;
            }

            // Use a Set to store unique random numbers
            Set<Integer> generatedNumbers = new Set<Integer>();
            // Initialize a list to store the final random numbers as strings
            List<String> randomNumbers = new List<String>();

            // Convert the allowed set to a list for easy indexing
            List<Integer> allowedList = new List<Integer>(allowedSet);

            // Continue generating numbers until the required count is reached
            while (generatedNumbers.size() < count) {
                // Generate a random index to pick from the allowedList
                Integer randomIndex = Math.round(Math.random() * (allowedList.size() - 1));
                Integer randomNumber = allowedList[randomIndex];

                // Check if the generated number is not already in the set
                if (!generatedNumbers.contains(randomNumber)) {
                    // Add the unique random number to the set and to the list as a string
                    generatedNumbers.add(randomNumber);
                    randomNumbers.add(String.valueOf(randomNumber));
                }
            }

            // Add the list of random numbers to the allNumbers list
            allNumbers.add(randomNumbers);
        }

        // Return the list of lists containing random numbers as strings
        return allNumbers;
    }

    // Inner class to define the input structure for the Invocable method
    public class Inputs {
        // Minimum value for the random number generation range
        @InvocableVariable(required=true)
        public Integer min;

        // Maximum value for the random number generation range
        @InvocableVariable(required=true)
        public Integer max;

        // Number of unique random numbers to generate
        @InvocableVariable(required=true)
        public Integer count;

        // List of allowed numbers to pick from
        @InvocableVariable(required=true)
        public List<String> allowedList;
    }
}