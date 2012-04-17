package com.sp.impl

import com.sp.profiles.PayProfile
import com.sp.profiles.UserProfile
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import org.apache.commons.logging.LogFactory

@Secured(['ROLE_USER'])
class UserProfileController
{
    PayService payService
    UserService userService

    private static final log = LogFactory.getLog(this);


    @Secured(['ROLE_ADMIN'])
    def index = {
        redirect uri: '/'
    }

    def profile = {
        if (userService.authenticateService.isLoggedIn() && UserProfile.findByUser(userService.getUser()))
        {
            UserProfile userProfileInstance = UserProfile.findByUser(userService.getUser())
            render(view: "show", model: [userProfileInstance: userProfileInstance])
        }
        else
        {
            redirect uri: '/'
        }
    }

    def buy = {
        PayProfile payProfile = PayProfile.findByNameAndId(params.itemName, params.itemNumber)
        log.debug("payProfile="+payProfile)
        UserProfile userProfileInstance = UserProfile.findByUser(userService.getUser())
        log.debug("userProfileInstance="+userProfileInstance
        )
        if (accessDenied(userProfileInstance))
            redirect uri: '/'
        else if (payProfile)
            userProfileInstance.payProfile = payProfile
        else
        {
            flash.message = "Pay profile set to Default"
            userProfileInstance.payProfile = PayProfile.findByName("Default")
        }

        payService.monthlySubscription(userProfileInstance)
        render(view: "show", model: [userProfileInstance: userProfileInstance])
    }

    def show = {
        def userProfileInstance = UserProfile.get(params.id)
        if (accessDenied(userProfileInstance))
            redirect uri: '/'
        if (!userProfileInstance)
        {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userProfile.label', default: 'UserProfile'), params.id])}"
            redirect(action: "list")
        }
        else
        {
            [userProfileInstance: userProfileInstance]
        }
    }

    def edit = {
        def userProfileInstance = UserProfile.findByUser(userService.getUser())
        if (accessDenied(userProfileInstance))
            redirect uri: '/'
        if (!userProfileInstance)
        {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userProfile.label', default: 'UserProfile'), params.id])}"
            redirect(action: "list")
        }
        else
        {
            return [userProfileInstance: userProfileInstance]
        }
    }

    private def accessDenied =
    { UserProfile profile->
        return !(profile && userService.authenticateService.isLoggedIn() && userService.getUser().id.equals(profile.user.id))
    }

}
