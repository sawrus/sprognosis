package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.profiles.PayProfile

@Secured(['ROLE_ADMIN'])
class PayProfileAdminController
{
    def scaffold = PayProfile
}
