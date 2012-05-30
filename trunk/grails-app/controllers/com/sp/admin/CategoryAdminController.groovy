package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class CategoryAdminController
{
    def scaffold = com.sp.impl.Category
}
