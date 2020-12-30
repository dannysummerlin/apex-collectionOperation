@isTest
public class CollectionOperationTest {
	static void testOperation(String operationName, String fieldName, String target) { testOperation(operationName, fieldName, null, null, target); }
	static void testOperation(String operationName, String fieldName, Date target) { testOperation(operationName, fieldName, null, target, null); }
    static void testOperation(String operationName, String fieldName, Decimal target) { testOperation(operationName, fieldName, target, null, null); }
	static void testOperation(String operationName, String fieldName, Decimal targetNumber, Date targetDate, String targetString) {
		Opportunity o1 = new Opportunity(Name='Test',Amount=1000,CloseDate=Date.newInstance(1990,1,1));
		Opportunity o2 = new Opportunity(Name='Test',Amount=200,CloseDate=Date.newInstance(1990,10,10));
		Opportunity[] opps = new Opportunity[]{o1, o2};
		dataForCollectionOperation testInput = new dataForCollectionOperation();
		testInput.operationName = operationName;
		testInput.fieldName = fieldName;
		testInput.collection = opps;
		dataFromOperation[] testOutput = CollectionOperation.operations(new dataForCollectionOperation[]{testInput});
		if(targetDate != null)
			System.assert(testOutput[0].outputDate.isSameDay(targetDate));
		if(targetNumber != null)
			System.assert(testOutput[0].outputNumber == targetNumber);
		if(targetString != null)
			System.assert(testOutput[0].outputText == targetString);
	}
    static testMethod void validateUnique() { testOperation('unique', 'Name', 'Test'); }
    static testMethod void validateConcat() { testOperation('concat', 'Name', 'Test, Test'); }
	static testMethod void validateAverage() { testOperation('average', 'Amount', 600); }
	static testMethod void validateMax() { testOperation('max', 'Amount', 1000); }
	static testMethod void validateMin() { testOperation('min', 'Amount', 200); }
	static testMethod void validateMaxDate() { testOperation('maxDate', 'CloseDate', Date.newInstance(1990,10,10)); }
	static testMethod void validateMinDate() { testOperation('minDate', 'CloseDate', Date.newInstance(1990,1,1)); }
	static testMethod void validateCount() { testOperation('count', 'Amount', 2); }
}