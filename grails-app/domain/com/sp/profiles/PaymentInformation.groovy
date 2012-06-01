package com.sp.profiles

import com.sp.enums.PaymentType

class PaymentInformation {
    UserProfile userProfile
    PaymentType paymentType = PaymentType.PAYPAL

    //PayPal
    String PayPalAccount

    //US Wire
    String USWireAccountHolderName
    String USWireAccountNumber
    String USWireRoutingNumber
    String USWireBankName
    String USWireBankAddress1
    String USWireBankAddress2
    String USWireBankZIPPostalCode
    String USWireBankCity
    String USWireBankState

    //InternationalWire
    String IWireAccountHolderName
    String IWireAccountNumberIBAN
    String IWireSWIFTCode
    String IWireBankName
    String IWireBankAddress1
    String IWireBankAddress2
    String IWireBankZIPPostalCode
    String IWireBankCity
    String IWireBankProvRegion
    String IWireBankCountry
    
    //Beneficiary Information(for International Wire)
    String BeneficiaryName
    String Address1
    String Address2
    String ZIPPostalCode
    String City
    String ProvRegion
    String Country
    
    static constraints = {
    }
}
