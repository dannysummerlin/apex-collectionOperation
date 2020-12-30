public class dataFromOperation {
    @AuraEnabled @InvocableVariable public String outputText;
    @AuraEnabled @InvocableVariable public Decimal outputNumber;
    @AuraEnabled @InvocableVariable public Date outputDate;
    @AuraEnabled @InvocableVariable public Boolean hasError;
    @AuraEnabled @InvocableVariable public String errorMessage;
}