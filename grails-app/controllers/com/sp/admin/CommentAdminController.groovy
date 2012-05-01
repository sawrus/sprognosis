package com.sp.admin

import com.sp.site.Comment
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.impl.Prognosis


@Secured(['ROLE_ADMIN'])
class CommentAdminController {
    def scaffold = Comment

    def deleteAll = {
        Comment.executeUpdate("delete Comment c")
    }
}