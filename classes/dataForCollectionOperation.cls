public class dataForCollectionOperation {
    @AuraEnabled @InvocableVariable(label='Record Collection' description='records to be operated on' required=true) public List<sObject> collection;
    @AuraEnabled @InvocableVariable(label='Field Name' description='the API name of the field to operate on' required=true) public String fieldName;
    @AuraEnabled @InvocableVariable(label='Operation Name' description='choose from sum, average, max, min, maxDate, or minDate' required=true) public String operationName;
}