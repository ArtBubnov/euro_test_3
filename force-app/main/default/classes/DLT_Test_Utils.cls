@isTest
public without sharing class DLT_Test_Utils {

    public static final String TEST_USERNAME = 'dummytestuser@eurostart.delta.test.net';

    public static final String PROFILE_NAME_SYSTEM_ADMIN = 'System Administrator';

    public static final String USER_ROLE_DEV_NAME_CUSTOMER_SERVICE = 'Customer_Service';

    public static final String BUSINESS_ACCOUNT_NAME = 'Account Test';

    public static final String CUSTOMER_LASTNAME = 'lastnameTest';
    public static final String CUSTOMER_FIRSTNAME = 'firstnameTest';
    public static final String CUSTOMER_EMAIL = 'emailContact@example.com';
    public static final String CUSTOMER_PREF_LANG = 'English (UK)';
    public static final String CUSTOMER_CIN = 'Test CIN';
    public static final String CUSTOMER_PHONE = '128256512';

    public static final String SUBSCRIPTION_STATUS = 'New';
    public static final Date SUBSCRIPTION_START_DATE = Date.newInstance(2018, 03, 10);
    public static final Date SUBSCRIPTION_END_DATE = Date.newInstance(2018, 03, 30);
    public static final String SUBSCRIPTION_NAME = 'Subscription Name Test';
    public static final String SUBSCRIPTION_ORDER_NUMBER = '987654321';

    public static final String INVOICE_DISCOUNT_TYPE = 'discountType Test';
    public static final Integer INVOICE_DISCOUNT_VALUE = 12;
    public static final Integer INVOICE_DURATION = 20;
    public static final Boolean INVOICE_EXEMPT_VAT = True;
    public static final String INVOICE_EXTERNAL_REF = 'external Ref Test';
    public static final Date INVOICE_DATE = Date.newInstance(2018, 03, 10);
    public static final String INVOICE_NUMBER = 'invoice number test';
    public static final String INVOICE_PAYMENT_METHOD = 'Credit Card';
    public static final String INVOICE_PROMO_NAME = 'promo name test';
 	public static final String INVOICE_STATUS = 'Pro Forma';
 	public static final String INVOICE_COUNTRY = 'FR';
    public static final Integer INVOICE_TOTAL_AMOUNT_EXCL_VAT = 0 ;
    public static final Integer INVOICE_TOTAL_AMOUNT_INCL_VAT = 0;
    public static final Integer INVOICE_VAT = 0;
    public static final Boolean INVOICE_TRANSFERED = false;

    public static User createUser(String profileName, String roleName, String userName) {
        User u = new User();

        u.Username = userName;
        u.FirstName = 'Test';
        u.LastName = 'Dummy';
        u.LanguageLocaleKey = 'fr';
        u.Email = 'test@test.com';
        u.Alias = 'tdum';
        u.TimeZoneSidKey = 'Europe/Paris';
        u.LocaleSidKey = 'fr_FR_EURO';
        u.EmailEncodingKey = 'ISO-8859-1';
        u.ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id;
        u.userRoleId = [SELECT Id FROM UserRole WHERE DeveloperName = :roleName].Id;

        return u;
    }

    public static Business_Account__c createSampleBusinessAccount(){
        return new Business_Account__c(
            Name = BUSINESS_ACCOUNT_NAME
        );
    }

    public static Account createCustomer() {
        Account c = new Account();

        c.LastName = CUSTOMER_LASTNAME;
        c.FirstName = CUSTOMER_FIRSTNAME;
        c.PersonEmail = CUSTOMER_EMAIL;
        c.Phone = CUSTOMER_PHONE;
        c.Preferred_Language__pc = CUSTOMER_PREF_LANG;
        c.CIN__pc = CUSTOMER_CIN;
        c.RecordTypeId = Account.getSObjectType().getDescribe().getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();

        return c;
    }

    public static Subscription__c createSubscription(Id invoiceAccountId, Id subscriptionTypeId){
        return new Subscription__c(
            Invoice_Account__c = invoiceAccountId,
            Subscription_Type__c = subscriptionTypeId,
            Status__c = SUBSCRIPTION_STATUS,
            Start_Date__c = SUBSCRIPTION_START_DATE,
            Starting_date__c = SUBSCRIPTION_START_DATE,
            End_Date__c = SUBSCRIPTION_END_DATE,
            Ending_date__c = SUBSCRIPTION_END_DATE,
            Order_Number__c = SUBSCRIPTION_ORDER_NUMBER
        );
    }

    public static Invoice__c createInvoice(Id customerId, Id invoiceAccountId, Id subscriptionId) {
        Invoice__c invoice = new Invoice__c();

        invoice.Customer__c = customerId;
        invoice.Invoice_Account__c = invoiceAccountId;
        invoice.Subscription__c = subscriptionId;
        invoice.Discount_Type__c = INVOICE_DISCOUNT_TYPE;
        invoice.Discount_Value__c = INVOICE_DISCOUNT_VALUE;
        invoice.Duration__c = INVOICE_DURATION;
        invoice.Start_Date__c = SUBSCRIPTION_START_DATE;
        invoice.End_Date__c = SUBSCRIPTION_END_DATE;
        invoice.Exempt_from_VAT__c = INVOICE_EXEMPT_VAT;
        invoice.External_Reference__c = INVOICE_EXTERNAL_REF;
        invoice.Invoice_Date__c = INVOICE_DATE;
        invoice.Invoice_Number__c = INVOICE_NUMBER;
        invoice.Payment_Method__c = INVOICE_PAYMENT_METHOD;
        invoice.Promo_Name__c = INVOICE_PROMO_NAME;
        invoice.Status__c = INVOICE_STATUS;
        invoice.Total_Amount_excl_VAT__c = INVOICE_TOTAL_AMOUNT_EXCL_VAT;
        invoice.Total_Amount_incl_VAT__c = INVOICE_TOTAL_AMOUNT_INCL_VAT;
        invoice.VAT__c = INVOICE_VAT;
        invoice.Transferred__c = INVOICE_TRANSFERED;
        invoice.Invoice_Country__c = INVOICE_COUNTRY;

        return invoice; 
    }
}