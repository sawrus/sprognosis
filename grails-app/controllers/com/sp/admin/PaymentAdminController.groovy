package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import org.grails.paypal.Payment

@Secured(['ROLE_ADMIN'])
class PaymentAdminController
{
    def scaffold = Payment
}
