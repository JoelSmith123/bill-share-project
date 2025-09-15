public with sharing class TestDataFactory {

    public static void createTestData() {
        Account household = createHousehold();
        createHouseholdMembers(household.Id);
    }
    
    private static Account createHousehold() {
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
        return a;
    }

    private static Contact createHouseholdMembers(Id accountId) {
        List<Contact> householdMembers = new List<Contact>();
        householdMembers.add(this.createHouseholdMember(accountId, 'Jay', 'McAullife'));
        householdMembers.add(this.createHouseholdMember(accountId, 'Isabel', 'Ortega'));
        householdMembers.add(this.createHouseholdMember(accountId, 'Joel', 'Smith'));
        insert householdMembers;
        return householdMembers;
    }

    private static Contact createHouseholdMember(Id accountId, String firstName, String lastName) {
        Contact c = new Contact();
        c.FirstName = firstName;
        c.LastName = lastName;
        c.AccountId = accountId;
        return c;
    }
}