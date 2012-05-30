package com.sp.admin

import com.sp.impl.Command
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class CommandAdminController
{
    def scaffold = Command
}
