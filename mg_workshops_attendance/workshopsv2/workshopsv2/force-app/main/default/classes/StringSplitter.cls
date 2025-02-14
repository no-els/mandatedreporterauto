public with sharing class StringSplitter {
    
    // Inner class to accept inputs from Flow
    public class Request {
        @InvocableVariable(required=true)
        public String commaSeparatedString;
    }
    
    // Inner class to return outputs to Flow
    public class Response {
        @InvocableVariable
        public List<String> splitStrings;
        
        public Response(List<String> splitStrings) {
            this.splitStrings = splitStrings;
        }
    }

    // Invocable method for Flow
    @InvocableMethod(label='Split Comma-Separated String' description='Splits a comma-separated string into a list')
    public static List<Response> splitString(List<Request> requests) {
        List<Response> responses = new List<Response>();

        for (Request req : requests) {
            List<String> splitStrings = String.isBlank(req.commaSeparatedString) ? 
                                        new List<String>() : 
                                        req.commaSeparatedString.split(',');
            responses.add(new Response(splitStrings));
        }

        return responses;
    }
}