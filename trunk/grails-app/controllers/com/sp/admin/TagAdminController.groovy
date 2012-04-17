package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.site.Tag

@Secured(['ROLE_ADMIN'])
class TagAdminController {
    def scaffold = Tag
}