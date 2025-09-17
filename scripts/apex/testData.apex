public with sharing class TestData {
    public static Map<String, Object> households = new Map<String, Object>({
        'name' => 'McAullife-Ortega-Smith Household',
    });

    public static List<Map<String, Object>> householdMembers = new List<Map<String, Object>>({{
        {
            'name' => 'Jay McAullife',
            'email' => 'jay.mcaullife@email.com',
            'monthlyIncome' => 7500.00,
        },
        {
            'name' => 'Isabel Ortega',
            'email' => 'isabel.ortega@email.com',
            'monthlyIncome' => 6800.00,
        },
        {
            'name' => 'Joel Smith',
            'email' => 'joel.smith@email.com',
            'monthlyIncome' => 8200.00,
        }
    }});

    public static List<Map<String, Object>> expenseCategories = new List<Map<String, Object>>({{
        {
            'name' => 'Groceries',
        },
        {
            'name' => 'Utilities',
        },
        {
            'name' => 'Rent',
        },
        {
            'name' => 'Entertainment',
        },
        {
            'name' => 'Transportation',
        },
        {
            'name' => 'Dining Out',
        },
        {
            'name' => 'Healthcare',
        },
        {
            'name' => 'Miscellaneous',
        }
    }});

    public static List<Map<String, Object>> expenses = new List<Map<String, Object>>({{
        {
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Groceries',
            'description' => 'Weekly grocery shopping at Whole Foods',
            'amount' => 150.00,
            'date' => Date.today().addDays(-7),
        },
        {
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Utilities',
            'description' => 'Electric bill for December',
            'amount' => 120.50,
            'date' => Date.today().addDays(-5),
        },
        {
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Rent',
            'description' => 'Monthly rent payment',
            'amount' => 2500.00,
            'date' => Date.today().addDays(-10),
        },
        {
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Entertainment',
            'description' => 'Movie tickets and dinner',
            'amount' => 85.00,
            'date' => Date.today().addDays(-3),
        },
        {
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Transportation',
            'description' => 'Gas for cars',
            'amount' => 75.00,
            'date' => Date.today().addDays(-2),
        },
        {
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Dining Out',
            'description' => 'Pizza delivery',
            'amount' => 45.00,
            'date' => Date.today().addDays(-1),
        },
        {
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Healthcare',
            'description' => 'Doctor visit co-pay',
            'amount' => 25.00,
            'date' => Date.today().addDays(-4),
        },
        {
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Miscellaneous',
            'description' => 'Household supplies',
            'amount' => 35.00,
            'date' => Date.today().addDays(-6),
        }
    }});

    public static List<Map<String, Object>> userExpenses = new List<Map<String, Object>>({{
        {
            'expenseId' => 'Groceries',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        },
        {
            'expenseId' => 'Utilities',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        },
        {
            'expenseId' => 'Rent',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        },
        {
            'expenseId' => 'Entertainment',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        },
        {
            'expenseId' => 'Transportation',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        },
        {
            'expenseId' => 'Dining Out',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        },
        {
            'expenseId' => 'Healthcare',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        },
        {
            'expenseId' => 'Miscellaneous',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        },
        {
            'expenseId' => 'Miscellaneous',
            'userId' => 'Jay McAullife',
            'amount' => 150.00,
        }
    }});

    public static List<Map<String, Object>> userExceptions = new List<Map<String, Object>>({{
        {
            'userId' => 'Jay McAullife',
            'categoryId' => 'Groceries',
            'exceptionType' => 'REDUCED',
            'percent' => 10.00,
        },
        {
            'userId' => 'Isabel Ortega',
            'categoryId' => 'Entertainment',
            'exceptionType' => 'EXEMPT',
            'percent' => 0.00,
        },
        {
            'userId' => 'Joel Smith',
            'categoryId' => 'Transportation',
            'exceptionType' => 'REDUCED',
            'percent' => 15.00,
        }
    }});
}