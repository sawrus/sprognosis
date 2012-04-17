package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.impl.Vote

@Secured(['ROLE_ADMIN'])
class VoteAdminController
{
    def scaffold = Vote
}
