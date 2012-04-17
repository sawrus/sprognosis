package com.sp.admin

import com.sp.site.Comment
import org.codehaus.groovy.grails.plugins.springsecurity.Secured


@Secured(['ROLE_ADMIN'])
class CommentAdminController {
    def scaffold = Comment
}