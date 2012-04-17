package com.sp.admin

import org.grails.paypal.BuyerInformation
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class BuyerInformationAdminController
{
    def scaffold = BuyerInformation
}
