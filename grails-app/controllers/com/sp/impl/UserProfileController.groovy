package com.sp.impl

import com.sp.profiles.PayProfile
import com.sp.profiles.UserProfile
import com.sp.site.Image
import org.apache.commons.logging.LogFactory
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_USER','ROLE_PROGNOSTICATOR'])
class UserProfileController {
    PayService payService
    UserService userService

    private static final log = LogFactory.getLog(this);

    @Secured(['ROLE_ADMIN'])
    def index = {
        redirect uri: '/'
    }

    def profile = {
        if (userService.authenticateService.isLoggedIn() && UserProfile.findByUser(userService.getUser())) {
            UserProfile userProfileInstance = UserProfile.findByUser(userService.getUser())
            render(view: "show", model: [userProfileInstance: userProfileInstance])
        }
        else {
            redirect uri: '/'
        }
    }

    def buy = {
        PayProfile payProfile = PayProfile.findByNameAndId(params.itemName, params.itemNumber)
        log.debug("payProfile=" + payProfile)
        UserProfile userProfileInstance = UserProfile.findByUser(userService.getUser())
        log.debug("userProfileInstance=" + userProfileInstance
        )
        if (accessDenied(userProfileInstance))
            redirect uri: '/'
        else if (payProfile)
            userProfileInstance.payProfile = payProfile
        else {
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
        if (userProfileInstance) {
            [userProfileInstance: userProfileInstance]
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userProfile.label', default: 'UserProfile'), params.id])}"
        }
    }

    def edit = {
        def userProfileInstance = UserProfile.findByUser(userService.getUser())
        if (accessDenied(userProfileInstance))
            redirect uri: '/'
        if (userProfileInstance) {
            [userProfileInstance: userProfileInstance]
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userProfile.label', default: 'UserProfile'), params.id])}"
        }
    }

    private def accessDenied =
    { UserProfile profile ->
        return !(profile && userService.authenticateService.isLoggedIn() && userService.getUser().id.equals(profile.user.id))
    }

    private static final String SITE_IMAGE = 'site_image'
    private static final String AVATAR_DIR = File.separator + "avatars"

    def changeImage = {
        ImageController.realPath = servletContext.getRealPath("/")
        ImageController.applicationName= grailsApplication.metadata['app.name']

        def userProfileInstance = UserProfile.findByUser(userService.getUser())
        def imageFile = request.getFile(SITE_IMAGE)
        def imageInstance = createUserImage(userProfileInstance?.user?.username, imageFile)
        if (imageInstance) imageInstance.save(flush: true)

        userProfileInstance.userImage = Image.findByName(userProfileInstance?.user?.username)
        userProfileInstance.save(flush:true)

        redirect(action: "profile", controller: "site")
    }

    private def createUserImage(String name, def imageFile) {
        Image imageInstance = new Image(params)

        imageInstance.name = name
        imageInstance.visible = true
        imageInstance.path = AVATAR_DIR
        imageInstance.description = name

        if (!imageFile.empty){
            def saveImageInstance = ImageController.saveFileAndFillEntity(imageFile, imageInstance)
            return saveImageInstance
        }
    }
}
