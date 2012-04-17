package com.sp.admin

import com.sp.profiles.UserProfile
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class UserProfileAdminController
{
    def scaffold = UserProfile
}
