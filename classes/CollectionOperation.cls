public class CollectionOperation {
	@InvocableMethod(label='Collection Operation' description='Perform an operation on the values of the selected field in a collection')
	public static dataFromOperation[] operations(dataForCollectionOperation[] inputs) {
        dataFromOperation[] wrapper = new dataFromOperation[]{};
        for(Integer count = 0; count < inputs.size(); count++) {
            dataForCollectionOperation input = inputs[count];
            dataFromOperation output = new dataFromOperation();
            try {
                switch on input.operationName {
                    when 'count' { output.outputNumber = collectionCount(input); }
                    when 'unique' { output.outputText = collectionUnique(input); }
                    when 'concat' { output.outputText = collectionConcat(input); }
                    when 'sum' { output.outputNumber = collectionSum(input); }
                    when 'average' { output.outputNumber = collectionAverage(input); }
                    when 'max' { output.outputNumber = collectionMax(input); }
                    when 'min' { output.outputNumber = collectionMin(input); }
                    when 'maxDate' { output.outputDate = collectionMaxDate(input); }
                    when 'minDate' { output.outputDate = collectionMinDate(input); }
                    when else {}
                }
            } catch (Exception e) {
                output.hasError = true;
                output.errorMessage = e.getMessage();
                System.debug('An exception occurred: ' + e.getMessage());
            }
            wrapper.add(output);
        }
		return wrapper;
	}
    public static String collectionUnique(dataForCollectionOperation input) {
        Set<String> outputSet = new Set<String>();
        for(Integer count = 0; count < input.collection.size(); count++) {
            if(input.collection[count].isSet(input.fieldName) && input.collection[count].get(input.fieldName) != null)
				outputSet.add((String) input.collection[count].get(input.fieldName));
        }
        return String.join(new List<String>(outputSet), ', ');
    }
    public static String collectionConcat(dataForCollectionOperation input) {
        List<String> outputSet = new List<String>();
        for(Integer count = 0; count < input.collection.size(); count++) {
            if(input.collection[count].isSet(input.fieldName) && input.collection[count].get(input.fieldName) != null)
				outputSet.add((String) input.collection[count].get(input.fieldName));
        }
        return String.join(outputSet, ', ');
    }
	public static Decimal collectionCount(dataForCollectionOperation input) {
		Decimal validCount = 0;
		for(Integer count = 0; count < input.collection.size(); count++)
			if(input.collection[count].isSet(input.fieldName) && input.collection[count].get(input.fieldName) != null)
				validCount++;
		return validCount;
	}
	public static Decimal collectionSum(dataForCollectionOperation input) {
		Decimal sum = 0;
		for(Integer count = 0; count < input.collection.size(); count++)
			if(input.collection[count].isSet(input.fieldName) && input.collection[count].get(input.fieldName) != null)
				sum += (Decimal) input.collection[count].get(input.fieldName);
		return sum;
	}
	public static Decimal collectionAverage(dataForCollectionOperation input) { return (input.collection.size() != 0 ? collectionSum(input) / input.collection.size() : 0); }
	public static Decimal collectionMax(dataForCollectionOperation input) {
		Decimal max = 0;
		for(Integer count = 0; count < input.collection.size(); count++)
			if(input.collection[count].isSet(input.fieldName) && input.collection[count].get(input.fieldName) != null)
				max = (Decimal) input.collection[count].get(input.fieldName) > max ? (Decimal) input.collection[count].get(input.fieldName) : max;
		return max;
	}
	public static Decimal collectionMin(dataForCollectionOperation input) {
		Decimal min = 2147483647;
		for(Integer count = 0; count < input.collection.size(); count++)
			if(input.collection[count].isSet(input.fieldName) && input.collection[count].get(input.fieldName) != null)
				min = (Decimal) input.collection[count].get(input.fieldName) < min ? (Decimal) input.collection[count].get(input.fieldName) : min;
		return (min != 2147483647 ? min : 0);
	}
	public static Date collectionMaxDate(dataForCollectionOperation input) {
		Date max = Date.newInstance(1700,1,1);
		for(Integer count = 0; count < input.collection.size(); count++)
			if(input.collection[count].isSet(input.fieldName) && input.collection[count].get(input.fieldName) != null)
				max = (Date) input.collection[count].get(input.fieldName) > max ? (Date) input.collection[count].get(input.fieldName) : max;
		return (max.isSameDay(Date.newInstance(1700,1,1)) ? null : max);
	}
	public static Date collectionMinDate(dataForCollectionOperation input) {
		Date min = Date.newInstance(4000,12,31);
		for(Integer count = 0; count < input.collection.size(); count++)
			if(input.collection[count].isSet(input.fieldName) && input.collection[count].get(input.fieldName) != null)
				min = (Date) input.collection[count].get(input.fieldName) < min ? (Date) input.collection[count].get(input.fieldName) : min;
		return (min.isSameDay(Date.newInstance(4000,12,31)) ? null : min);
	}
}