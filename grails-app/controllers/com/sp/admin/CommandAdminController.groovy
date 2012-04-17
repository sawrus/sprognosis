package com.sp.admin

import com.sp.impl.Command
import com.sp.impl.SportService
import com.sp.impl.Category
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class CommandAdminController
{
    def scaffold = Command

    def SportService sportService

    def load = {
        def category = Category.findByName("Football")
        sportService.init(category)

        try
        {
            sportService.parseClubs()
        }
        catch (e)
        {
            flash.message = e.getMessage()
        }
        redirect uri: '/'
    }
}
