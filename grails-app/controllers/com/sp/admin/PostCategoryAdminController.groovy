package com.sp.admin

import com.sp.site.PostCategory
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class PostCategoryAdminController {

    def scaffold = PostCategory
}
