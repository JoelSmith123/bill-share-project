public with sharing class TestDataFactory {

    public void createTestData() {
        System.debug('creating test data...');
        Account household = createHousehold();
        List<Contact> householdMembers = createHouseholdMembers(household.Id);
        List<ExpenseCategory__c> expenseCategories = createExpenseCategories(household.Id);
        List<Expense__c> expenses = createExpenses(household.Id, expenseCategories);
        createUserExpenses(expenses, householdMembers);
        createUserExceptions(householdMembers, expenseCategories);
        System.debug('test data created!');
    }

    public void createNewTestDataDeleteOld() {
        this.deleteAllData();
        this.createTestData();
    }

    public void deleteAllData() {
        System.debug('deleting test data...');
        delete [SELECT Id FROM Account WHERE RecordTypeId = :Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Household').getRecordTypeId()];
        delete [SELECT Id FROM Contact WHERE AccountId = :Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Household').getRecordTypeId()];
        delete [SELECT Id FROM ExpenseCategory__c];
        delete [SELECT Id FROM Expense__c];
        delete [SELECT Id FROM UserExpense__c];
        delete [SELECT Id FROM UserException__c];
        System.debug('test data deleted.');
    }
    
    private Account createHousehold() {
        System.debug('creating household...');

        String householdName = 'McAullife-Ortega-Smith Household';
        // if household already exists, return it
        List<Account> households = [SELECT Id FROM Account WHERE Name = :householdName];
        if (households.size() > 0) {
            return households[0];
        }

        Account a = new Account();
        a.Name = householdName;
        a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Household').getRecordTypeId();
        insert a;
        System.debug('household created!');
        return a;
    }

    private List<Contact> createHouseholdMembers(Id accountId) {
        System.debug('creating household members...');
        List<Contact> householdMembersToAdd = new List<Contact>();
        List<Contact> allHouseholdMembers = new List<Contact>();
        
        // Get all household members from TestData
        List<Map<String, Object>> householdMembersFromMockData = TestData.householdMembers;
        
        // Extract emails from TestData
        List<String> householdMemberEmails = new List<String>();
        for (Map<String, Object> member : householdMembersFromMockData) {
            householdMemberEmails.add((String) member.get('email'));
        }
        
        // Check which members already exist
        List<Contact> existingHouseholdMembers = [SELECT Id, Email FROM Contact WHERE AccountId = :accountId AND Email IN :householdMemberEmails];
        Set<String> existingEmails = new Set<String>();
        for (Contact existingMember : existingHouseholdMembers) {
            existingEmails.add(existingMember.Email);
        }
        
        // Add existing members to the return list
        allHouseholdMembers.addAll(existingHouseholdMembers);
        
        // Create new members only for those that don't exist
        for (Map<String, Object> memberData : householdMembersFromMockData) {
            String email = (String) memberData.get('email');
            if (!existingEmails.contains(email)) {
                String fullName = (String) memberData.get('name');
                String[] nameParts = fullName.split(' ');
                String firstName = nameParts[0];
                String lastName = nameParts[1];
                Decimal monthlyIncome = (Decimal) memberData.get('monthlyIncome');
                
                householdMembersToAdd.add(createHouseholdMember(accountId, firstName, lastName, email, monthlyIncome));
            }
        }
        
        // Insert new members if any
        if (!householdMembersToAdd.isEmpty()) {
            insert householdMembersToAdd;
            allHouseholdMembers.addAll(householdMembersToAdd);
        }
        System.debug('household members created!');
        return allHouseholdMembers;
    }

    private Contact createHouseholdMember(Id accountId, String firstName, String lastName, String email, Decimal monthlyIncome) {
        Contact c = new Contact();
        c.FirstName = firstName;
        c.LastName = lastName;
        c.Email = email;
        c.AccountId = accountId;
        c.MonthlyIncome__c = monthlyIncome; // Custom field for monthly income
        return c;
    }
    
    private List<ExpenseCategory__c> createExpenseCategories(Id householdId) {
        System.debug('creating expense categories...');
        List<ExpenseCategory__c> categoriesToAdd = new List<ExpenseCategory__c>();
        List<ExpenseCategory__c> allCategories = new List<ExpenseCategory__c>();
        
        // Get all expense categories from TestData
        List<Map<String, Object>> categoriesFromMockData = TestData.expenseCategories;
        
        // Extract category names from TestData
        List<String> categoryNames = new List<String>();
        for (Map<String, Object> category : categoriesFromMockData) {
            categoryNames.add((String) category.get('name'));
        }
        
        // Check which categories already exist
        List<ExpenseCategory__c> existingCategories = [SELECT Id, Name FROM ExpenseCategory__c WHERE Household__c = :householdId AND Name IN :categoryNames];
        Set<String> existingCategoryNames = new Set<String>();
        for (ExpenseCategory__c existingCategory : existingCategories) {
            existingCategoryNames.add(existingCategory.Name);
        }
        
        // Add existing categories to the return list
        allCategories.addAll(existingCategories);
        
        // Create new categories only for those that don't exist
        for (Map<String, Object> categoryData : categoriesFromMockData) {
            String categoryName = (String) categoryData.get('name');
            if (!existingCategoryNames.contains(categoryName)) {
                categoriesToAdd.add(createExpenseCategory(householdId, categoryName));
            }
        }
        
        // Insert new categories if any
        if (!categoriesToAdd.isEmpty()) {
            insert categoriesToAdd;
            allCategories.addAll(categoriesToAdd);
        }
        
        System.debug('expense categories created!');
        return allCategories;
    }
    
    private ExpenseCategory__c createExpenseCategory(Id householdId, String categoryName) {
        ExpenseCategory__c category = new ExpenseCategory__c();
        category.Name__c = categoryName;
        category.Household__c = householdId;
        return category;
    }
    
    private List<Expense__c> createExpenses(Id householdId, List<ExpenseCategory__c> categories) {
        List<Expense__c> expensesToAdd = new List<Expense__c>();
        List<Expense__c> allExpenses = new List<Expense__c>();
        
        // Get all expenses from TestData
        List<Map<String, Object>> expensesFromMockData = TestData.expenses;
        
        // Create a map of category names to IDs for lookup
        Map<String, Id> categoryNameToId = new Map<String, Id>();
        for (ExpenseCategory__c category : categories) {
            categoryNameToId.put(category.Name, category.Id);
        }
        
        // Extract expense descriptions from TestData for comparison
        List<String> expenseDescriptions = new List<String>();
        for (Map<String, Object> expense : expensesFromMockData) {
            expenseDescriptions.add((String) expense.get('description'));
        }
        
        // Check which expenses already exist
        List<Expense__c> existingExpenses = [SELECT Id, Description__c FROM Expense__c WHERE Household__c = :householdId AND Description__c IN :expenseDescriptions];
        Set<String> existingDescriptions = new Set<String>();
        for (Expense__c existingExpense : existingExpenses) {
            existingDescriptions.add(existingExpense.Description__c);
        }
        
        // Add existing expenses to the return list
        allExpenses.addAll(existingExpenses);
        
        // Create new expenses only for those that don't exist
        for (Map<String, Object> expenseData : expensesFromMockData) {
            String description = (String) expenseData.get('description');
            if (!existingDescriptions.contains(description)) {
                String categoryName = (String) expenseData.get('categoryId');
                Id categoryId = categoryNameToId.get(categoryName);
                Decimal amount = (Decimal) expenseData.get('amount');
                Date expenseDate = (Date) expenseData.get('date');
                
                expensesToAdd.add(createExpense(householdId, categoryId, description, amount, expenseDate));
            }
        }
        
        // Insert new expenses if any
        if (!expensesToAdd.isEmpty()) {
            insert expensesToAdd;
            allExpenses.addAll(expensesToAdd);
        }
        
        return allExpenses;
    }
    
    private Expense__c createExpense(Id householdId, Id categoryId, String description, Decimal amount, Date expenseDate) {
        Expense__c expense = new Expense__c();
        expense.Household__c = householdId;
        expense.Category__c = categoryId;
        expense.Description__c = description;
        expense.TotalAmount__c = amount;
        expense.ExpenseDate__c = expenseDate;
        return expense;
    }
    
    private void createUserExpenses(List<Expense__c> expenses, List<Contact> householdMembers) {
        List<UserExpense__c> userExpensesToAdd = new List<UserExpense__c>();
        
        // Get all user expenses from TestData
        List<Map<String, Object>> userExpensesFromMockData = TestData.userExpenses;
        
        // Create maps for lookup
        Map<String, Id> expenseDescriptionToId = new Map<String, Id>();
        for (Expense__c expense : expenses) {
            expenseDescriptionToId.put(expense.Description__c, expense.Id);
        }
        
        Map<String, Id> userNameToId = new Map<String, Id>();
        for (Contact member : householdMembers) {
            userNameToId.put(member.FirstName + ' ' + member.LastName, member.Id);
        }
        
        // Extract unique combinations for comparison
        Set<String> existingUserExpenseKeys = new Set<String>();
        for (Map<String, Object> userExpenseData : userExpensesFromMockData) {
            String expenseDescription = (String) userExpenseData.get('expenseId');
            String userName = (String) userExpenseData.get('userId');
            existingUserExpenseKeys.add(expenseDescription + '|' + userName);
        }
        
        // Check which user expenses already exist
        List<UserExpense__c> existingUserExpenses = [SELECT Id, Expense__c, User__c FROM UserExpense__c WHERE Expense__c IN :expenses];
        Set<String> existingKeys = new Set<String>();
        for (UserExpense__c existing : existingUserExpenses) {
            // Get the expense description and user name for the key
            for (Expense__c expense : expenses) {
                if (expense.Id == existing.Expense__c) {
                    for (Contact member : householdMembers) {
                        if (member.Id == existing.User__c) {
                            existingKeys.add(expense.Description__c + '|' + member.FirstName + ' ' + member.LastName);
                            break;
                        }
                    }
                    break;
                }
            }
        }
        
        // Create new user expenses only for those that don't exist
        for (Map<String, Object> userExpenseData : userExpensesFromMockData) {
            String expenseDescription = (String) userExpenseData.get('expenseId');
            String userName = (String) userExpenseData.get('userId');
            String key = expenseDescription + '|' + userName;
            
            if (!existingKeys.contains(key)) {
                Id expenseId = expenseDescriptionToId.get(expenseDescription);
                Id userId = userNameToId.get(userName);
                Decimal amount = (Decimal) userExpenseData.get('amount');
                
                if (expenseId != null && userId != null) {
                    UserExpense__c userExpense = new UserExpense__c();
                    userExpense.Expense__c = expenseId;
                    userExpense.User__c = userId;
                    userExpense.AmountPaid__c = amount;
                    userExpensesToAdd.add(userExpense);
                }
            }
        }
        
        // Insert new user expenses if any
        if (!userExpensesToAdd.isEmpty()) {
            insert userExpensesToAdd;
        }
    }
    
    private void createUserExceptions(List<Contact> householdMembers, List<ExpenseCategory__c> categories) {
        List<UserException__c> exceptionsToAdd = new List<UserException__c>();
        
        // Get all user exceptions from TestData
        List<Map<String, Object>> exceptionsFromMockData = TestData.userExceptions;
        
        // Create maps for lookup
        Map<String, Id> userNameToId = new Map<String, Id>();
        for (Contact member : householdMembers) {
            userNameToId.put(member.FirstName + ' ' + member.LastName, member.Id);
        }
        
        Map<String, Id> categoryNameToId = new Map<String, Id>();
        for (ExpenseCategory__c category : categories) {
            categoryNameToId.put(category.Name, category.Id);
        }
        
        // Extract unique combinations for comparison
        Set<String> existingExceptionKeys = new Set<String>();
        for (Map<String, Object> exceptionData : exceptionsFromMockData) {
            String userName = (String) exceptionData.get('userId');
            String categoryName = (String) exceptionData.get('categoryId');
            existingExceptionKeys.add(userName + '|' + categoryName);
        }
        
        // Check which user exceptions already exist
        List<UserException__c> existingExceptions = [SELECT Id, User__c, Category__c FROM UserException__c WHERE User__c IN :householdMembers];
        Set<String> existingKeys = new Set<String>();
        for (UserException__c existing : existingExceptions) {
            // Get the user name and category name for the key
            for (Contact member : householdMembers) {
                if (member.Id == existing.User__c) {
                    for (ExpenseCategory__c category : categories) {
                        if (category.Id == existing.Category__c) {
                            existingKeys.add(member.FirstName + ' ' + member.LastName + '|' + category.Name);
                            break;
                        }
                    }
                    break;
                }
            }
        }
        
        // Create new user exceptions only for those that don't exist
        for (Map<String, Object> exceptionData : exceptionsFromMockData) {
            String userName = (String) exceptionData.get('userId');
            String categoryName = (String) exceptionData.get('categoryId');
            String key = userName + '|' + categoryName;
            
            if (!existingKeys.contains(key)) {
                Id userId = userNameToId.get(userName);
                Id categoryId = categoryNameToId.get(categoryName);
                String exceptionType = (String) exceptionData.get('exceptionType');
                Decimal percent = (Decimal) exceptionData.get('percent');
                
                if (userId != null && categoryId != null) {
                    exceptionsToAdd.add(createUserException(userId, categoryId, exceptionType, percent));
                }
            }
        }
        
        // Insert new user exceptions if any
        if (!exceptionsToAdd.isEmpty()) {
            insert exceptionsToAdd;
        }
    }
    
    private UserException__c createUserException(Id userId, Id categoryId, String exceptionType, Decimal percent) {
        UserException__c userException = new UserException__c();
        userException.User__c = userId;
        userException.Category__c = categoryId;
        userException.ExceptionType__c = exceptionType;
        userException.Percent__c = percent;
        return userException;
    }
}