@isTest
private class Invoice_PDF_Button_Cx_Test {
    @testSetup static void testSetup() {

        User systemAdministratorUser = DLT_Test_Utils.createUser(
            DLT_Test_Utils.PROFILE_NAME_SYSTEM_ADMIN,
            DLT_Test_Utils.USER_ROLE_DEV_NAME_CUSTOMER_SERVICE,
            DLT_Test_Utils.TEST_USERNAME
        );

        System.runAs(systemAdministratorUser){
            Business_Account__c businessAccountRecord = DLT_Test_Utils.createSampleBusinessAccount();
            insert businessAccountRecord;

            Account customerRecord = DLT_Test_Utils.createCustomer();
            insert customerRecord;

            customerRecord = [SELECT Id, PersonContactId FROM Account WHERE Id = :customerRecord.Id];

            Subscription_Type__c subscriptionTypeRecord = new Subscription_Type__c();
            insert subscriptionTypeRecord;

            Subscription__c subscriptionRecord = DLT_Test_Utils.createSubscription(customerRecord.Id, subscriptionTypeRecord.Id);
            insert subscriptionRecord;

            Invoice__c invoiceRecord = DLT_Test_Utils.createInvoice(customerRecord.Id, businessAccountRecord.Id, subscriptionRecord.Id);
            insert invoiceRecord;
        }
    }
    @isTest
    static void invoicePDF_Test(){
        Invoice_PDF_Button_Cx controllerInvoicePDF = createInvoiceController();

        Test.startTest();

        Assert.isNotNull(controllerInvoicePDF);

        Test.stopTest();
    }

    @isTest
    private static void getIsExemptFromVATTest() {
        Invoice_PDF_Button_Cx controllerInvoicePDF = createInvoiceController();

        Test.startTest();

        Assert.isTrue(controllerInvoicePDF.getIsExemptFromVAT());

        Test.stopTest();
    }

    @isTest
    private static void getStasusTest(){
        Invoice_PDF_Button_Cx controllerInvoicePDF = createInvoiceController();

        Test.startTest();

        Assert.isTrue(controllerInvoicePDF.getIsProforma());
        Assert.isFalse(controllerInvoicePDF.getIsConfirmed());

        Test.stopTest();
    }

    @isTest
    private static void getVatIsAtZeroTest(){
        Invoice_PDF_Button_Cx controllerInvoicePDF = createInvoiceController();

        Test.startTest();

        Assert.isTrue(controllerInvoicePDF.getVatIsAtZero());

        Test.stopTest();
    }


    private static Invoice_PDF_Button_Cx createInvoiceController() {
        Invoice__c invoice = [SELECT Id FROM Invoice__c];
        PageReference pdfInvoice = Page.Invoice_PDF_Button;
        ApexPages.StandardController sc = new ApexPages.StandardController(invoice);

        Test.setCurrentPage(pdfInvoice);

        return new Invoice_PDF_Button_Cx(sc);
    }
}