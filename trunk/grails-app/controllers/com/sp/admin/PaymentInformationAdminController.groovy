package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import org.grails.paypal.Payment
import com.sp.profiles.PaymentInformation

@Secured(['ROLE_ADMIN'])
class PaymentInformationAdminController
{
    def scaffold = PaymentInformation
}
