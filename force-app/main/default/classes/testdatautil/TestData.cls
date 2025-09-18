public with sharing class TestData {
    public static Map<String, Object> households = new Map<String, Object>{
        'name' => 'McAullife-Ortega-Smith Household'
    };

    public static List<Map<String, Object>> householdMembers = new List<Map<String, Object>>{
        new Map<String, Object>{
            'name' => 'Jay McAullife',
            'email' => 'jay.mcaullife@email.com',
            'monthlyIncome' => 7500.00
        },
        new Map<String, Object>{
            'name' => 'Isabel Ortega',
            'email' => 'isabel.ortega@email.com',
            'monthlyIncome' => 6800.00
        },
        new Map<String, Object>{
            'name' => 'Joel Smith',
            'email' => 'joel.smith@email.com',
            'monthlyIncome' => 8200.00
        }
    };

    public static List<Map<String, Object>> expenseCategories = new List<Map<String, Object>>{
        new Map<String, Object>{
            'name' => 'Groceries'
        },
        new Map<String, Object>{
            'name' => 'Utilities'
        },
        new Map<String, Object>{
            'name' => 'Rent'
        },
        new Map<String, Object>{
            'name' => 'Entertainment'
        },
        new Map<String, Object>{
            'name' => 'Transportation'
        },
        new Map<String, Object>{
            'name' => 'Dining Out'
        },
        new Map<String, Object>{
            'name' => 'Healthcare'
        },
        new Map<String, Object>{
            'name' => 'Miscellaneous'
        }
    };

    public static List<Map<String, Object>> expenses = new List<Map<String, Object>>{
        new Map<String, Object>{
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Groceries',
            'description' => 'Weekly grocery shopping at Whole Foods',
            'amount' => 150.00,
            'date' => Date.today().addDays(-7)
        },
        new Map<String, Object>{
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Utilities',
            'description' => 'Electric bill for December',
            'amount' => 120.50,
            'date' => Date.today().addDays(-5)
        },
        new Map<String, Object>{
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Rent',
            'description' => 'Monthly rent payment',
            'amount' => 2500.00,
            'date' => Date.today().addDays(-10)
        },
        new Map<String, Object>{
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Entertainment',
            'description' => 'Movie tickets and dinner',
            'amount' => 85.00,
            'date' => Date.today().addDays(-3)
        },
        new Map<String, Object>{
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Transportation',
            'description' => 'Gas for cars',
            'amount' => 75.00,
            'date' => Date.today().addDays(-2)
        },
        new Map<String, Object>{
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Dining Out',
            'description' => 'Pizza delivery',
            'amount' => 45.00,
            'date' => Date.today().addDays(-1)
        },
        new Map<String, Object>{
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Healthcare',
            'description' => 'Doctor visit co-pay',
            'amount' => 25.00,
            'date' => Date.today().addDays(-4)
        },
        new Map<String, Object>{
            'householdId' => 'McAullife-Ortega-Smith Household',
            'categoryId' => 'Miscellaneous',
            'description' => 'Household supplies',
            'amount' => 35.00,
            'date' => Date.today().addDays(-6)
        }
    };

    public static List<Map<String, Object>> userExpenses = new List<Map<String, Object>>{
        new Map<String, Object>{
            'expenseId' => 'Groceries',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        },
        new Map<String, Object>{
            'expenseId' => 'Utilities',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        },
        new Map<String, Object>{
            'expenseId' => 'Rent',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        },
        new Map<String, Object>{
            'expenseId' => 'Entertainment',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        },
        new Map<String, Object>{
            'expenseId' => 'Transportation',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        },
        new Map<String, Object>{
            'expenseId' => 'Dining Out',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        },
        new Map<String, Object>{
            'expenseId' => 'Healthcare',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        },
        new Map<String, Object>{
            'expenseId' => 'Miscellaneous',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        },
        new Map<String, Object>{
            'expenseId' => 'Miscellaneous',
            'userId' => 'Jay McAullife',
            'amount' => 150.00
        }
    };

    public static List<Map<String, Object>> userExceptions = new List<Map<String, Object>>{
        new Map<String, Object>{
            'userId' => 'Jay McAullife',
            'categoryId' => 'Groceries',
            'exceptionType' => 'REDUCED',
            'percent' => 10.00
        },
        new Map<String, Object>{
            'userId' => 'Isabel Ortega',
            'categoryId' => 'Entertainment',
            'exceptionType' => 'EXEMPT',
            'percent' => 0.00
        },
        new Map<String, Object>{
            'userId' => 'Joel Smith',
            'categoryId' => 'Transportation',
            'exceptionType' => 'REDUCED',
            'percent' => 15.00
        }
    };
}