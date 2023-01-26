public class Invoice_PDF_Button_Cx {

    public Invoice__c invoice{get;set;}
    public String language {get;set;}
    public String amount_excl_VAT {get;set;}
    public String amount_incl_VAT {get;set;}
    public String amount_VAT {get;set;}
    public String requestDate {get;set;}
    public String endDate {get;set;}
    public String startDate {get;set;}
    public String title {get;set;}

    private static final String CONFIRMED_LABEL = 'Confirmed';
    private static final String PROFORMA_STATUS = 'Pro Forma';

    public Invoice_PDF_Button_Cx(ApexPages.StandardController controller){
        Invoice__c invoiceRecord = (Invoice__c) controller.getRecord();

        invoice = [
            SELECT Id,
            Customer__r.Salutation,
            Total_Amount_excl_VAT__c,
            Total_Amount_incl_VAT__c,
            VAT__c, Status__c,
            Subscription__r.Discount_Type__c,
        //    Customer__r.Owner_Title__c, // ex. GUTTP_Member__r.GUTTP_Owner_Title__c
            Last_Name__c,
            First_Name__c,
            Invoice_Account__r.Name,
            Invoice_Owner_Title__c,
            Invoice_Last_Name__c,
            Invoice_First_Name__c,
            Invoice_Street_Number__c,
            Invoice_Postal_Code__c,
            Invoice_City__c,
            Invoice_Country__c,
            TECH_isIntraCommunautaire__c,
            Customer__r.Preferred_Language__pc,
            // Subscription__r.Customer__c, // ex. GUTTP_Program__r.GUTTP_Member__c
            Subscription__r.Subscription_Type__r.Subscription_Category__c,
            Order_Number__c,
            Invoice_Number__c,
            Request_Date__c,
            Subscription__r.VAT_Number__c,
            Subscription__r.External_Reference__c,
            Customer__r.CIN__pc, // ex. CIN__c
            Duration__c,
            Start_Date__c,
            End_Date__c,
            Exempt_from_VAT__c,
            TECH_Payment_Reference__c,
            VAT_Number__c,
            Inv_Additional_adress_information__c,
            Subscription__r.Discount_Value__c,
            Subscription_VAT_Number__c,
            Order_Reference__c
            FROM Invoice__c
            WHERE Id = :invoiceRecord.Id
        ];

        endDate = formatDate(invoice.End_Date__c);
        startDate =  formatDate(invoice.Start_Date__c);
        requestDate = formatDate(invoice.Request_Date__c);

        if(invoice != null){
            language = getOfficialCountryCode();
        }
        if( String.isNotBlank(invoice.Invoice_Country__c)){
            invoice.Invoice_Country__c = getCountryNameByCode(invoice.Invoice_Country__c);
        }

        replaceDollarByEuro();
    }

    // GETTERS
    public Boolean getIsExemptFromVAT(){
        return invoice.Exempt_from_VAT__c;
    }

    public Boolean getIsConfirmed(){
        return CONFIRMED_LABEL.equals(invoice.Status__c);
    }
    public Boolean getIsProforma(){
        return PROFORMA_STATUS.equals(invoice.Status__c);
    }

    public Boolean getVatIsAtZero(){
        return (invoice.VAT__c == 0 || invoice.VAT__c == null);
    }

    // HELPERS
    /*
     * method pour forcer le format de la request date, endDate, StartDate
    **/
    private String formatDate(Date anyDate){
        if (anyDate == null) {
            return '';
        }

        String day = Integer.valueof(anyDate.day()) < 10 ? '0'+ String.valueOf(anyDate.day()) : String.valueOf(anyDate.day());
        String month = Integer.valueof(anyDate.month()) < 10 ? '0'+ String.valueOf(anyDate.month()) : String.valueOf(anyDate.month());

        return  day+'/'+ month +'/'+anyDate.year();
    }

    private void replaceDollarByEuro(){
        amount_excl_VAT = String.valueOf(invoice.Total_Amount_excl_VAT__c)+ ' €' ;
        amount_excl_VAT = amount_excl_VAT.replace('.', ',');
        amount_VAT = String.valueOf(invoice.VAT__c)+ ' €';
        amount_VAT = amount_VAT.replace('.', ',');
        amount_Incl_VAT = String.valueOf(invoice.Total_Amount_incl_VAT__c)+ ' €';
        amount_Incl_VAT = amount_Incl_VAT.replace('.', ',');
    }

    private String getOfficialCountryCode(){
        return invoice.Customer__r.Preferred_Language__pc == 'FR' ? 'fr_FR' :
        	   invoice.Customer__r.Preferred_Language__pc == 'NL' ? 'nl_NL' :
        	   invoice.Customer__r.Preferred_Language__pc == 'DE' ? 'de_DE' :
        	   invoice.Customer__r.Preferred_Language__pc == 'EN' ? 'en_US' : 'en_US';
    }

    /**
    *   Return country name from isoCountryCodes (static resource) 
    *
    *   @author Erwan Raulo
    *   @Date Creation 30/08/2018
    *   @Date Modification 30/08/2018
    *   @param: code -- the country code related to the desired country name in the static resource, if no matching happen then initial country code is returned.
    */
    private class Country {
        public string code;
        public string name;
    }
    private static String getCountryNameByCode(String code){
        String name = '';

        for (StaticResource sr : [SELECT Id, Body FROM StaticResource WHERE Name = 'webForm_IsoCountryCode' LIMIT 1]) {
            String allcontents = sr.Body.toString().subStringAfter('= ');

            for(Country c : (List<Country>)JSON.deserialize(allcontents, List<Country>.class)){
                if(c.code == code){
                    name = c.name;
                    break;
                }
            }

            break;
        }

        return String.isNotBlank(name) ? name : code;
    }
}