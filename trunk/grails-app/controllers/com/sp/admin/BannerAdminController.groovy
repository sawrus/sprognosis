package com.sp.admin

import com.sp.site.Banner
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class BannerAdminController {

    def scaffold = Banner
}
