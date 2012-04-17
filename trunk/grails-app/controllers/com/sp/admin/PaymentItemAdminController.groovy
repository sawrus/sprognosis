package com.sp.admin

import org.grails.paypal.PaymentItem

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class PaymentItemAdminController
{
    def scaffold = PaymentItem
}
