package com.sp.enums

/**
 * @author Evgeny Isaev
 */
public enum SiteFunction {
    AS_USER("My Account","userProfile", "profile"),
    AS_HANDICAPPER("My Tips","checked"),
    PAYMENT_INFORMATION("Payment Information","payment"),
    CONTACT_US("Contact us","contact")

    private String name
    private String controller = "site"
    private String action

    SiteFunction(String name, String controller, String action) {
        this.name = name
        this.controller = controller
        this.action = action
    }

    SiteFunction(String name, String action) {
        this.name = name
        this.action = action
    }

    String getName() {
        return name
    }

    String getController() {
        return controller
    }

    String getAction() {
        return action
    }

    static SiteFunction parseByName(String name){
        SiteFunction result = null
        for (SiteFunction siteFunction: SiteFunction.values()){
            if (siteFunction.name.equals(name)){
                result = siteFunction
            }
        }
        return result
    }

}