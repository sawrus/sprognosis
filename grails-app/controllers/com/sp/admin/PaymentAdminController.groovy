package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import org.grails.paypal.Payment
import org.grails.paypal.PaymentItem

@Secured(['ROLE_ADMIN'])
class PaymentAdminController
{
    def scaffold = Payment

    def clear = {
        PaymentItem.executeUpdate("delete PaymentItem pi")
        Payment.executeUpdate("delete Payment p")
        redirect uri: '/'
    }
}
