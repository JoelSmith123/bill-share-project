# Manifest Files

## Overview
This directory contains deployment manifests for the Bill Sharing Salesforce application.

## Files

### allMetadata.xml
The main deployment manifest containing only the custom components and essential dependencies for the bill sharing application.

**Size Reduction**: Reduced from 1,548 lines (74K) to 66 lines (1.9K) - a 97% reduction in size.

### allMetadata.xml.backup
Backup of the original comprehensive manifest that included all standard Salesforce metadata.

### billShareMetadata.xml
A copy of the minimal manifest with a descriptive name.

### minimalMetadata.xml
Another copy of the minimal manifest for reference.

## What's Included in the Minimal Manifest

### Custom Objects
- `Expense__c` - Main expense records
- `ExpenseCategory__c` - Categories for expenses
- `UserException__c` - User-specific exceptions for expense categories
- `UserExpense__c` - Junction object linking users to expenses

### Custom Tabs
- Tabs for all four custom objects

### Custom Fields
- `Contact.MonthlyIncome__c` - Monthly income field on Contact object

### Custom Record Types
- `Account.Household` - Household record type for Account object

### Essential Dependencies
- Standard objects: Account, Contact, User (for lookups and relationships)
- Essential profiles: Admin, Standard
- Essential settings: Security, Sharing, Org
- Sharing rules for custom objects

## Benefits of the Minimal Manifest

1. **Faster Deployments**: Significantly reduced deployment time due to smaller manifest
2. **Reduced Complexity**: Only includes what's actually needed for the application
3. **Easier Maintenance**: Clear focus on custom components only
4. **Better Performance**: Less metadata to process during deployment
5. **Contextual Deployments**: Only new changes are included, making deployments more targeted

## Usage

Use `allMetadata.xml` for deployments. The backup file can be restored if needed:

```bash
cp manifest/allMetadata.xml.backup manifest/allMetadata.xml
```
