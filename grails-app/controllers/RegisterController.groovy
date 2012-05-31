import org.springframework.security.providers.UsernamePasswordAuthenticationToken as AuthToken
import org.springframework.security.context.SecurityContextHolder as SCH

import com.sp.auth.Role
import com.sp.auth.User
import com.sp.enums.Language
import com.sp.impl.ImageController
import com.sp.profiles.PayProfile
import com.sp.profiles.UserProfile
import com.sp.site.Image
import org.apache.commons.logging.LogFactory
import com.sp.site.Invite

/**
 * Registration controller.
 */
class RegisterController {

	def authenticateService
	def daoAuthenticationProvider
	def emailerService

    private static final String FIND_INVITE_BY_KEY = "from Invite as i where i.invite_key=:invite_key and i.invite_used=:invite_used"

	static Map allowedMethods = [save: 'POST', update: 'POST']

	/**
	 * User Registration Top page.
	 */
	def index = {

		// skip if already logged in
		if (authenticateService.isLoggedIn()) {
			redirect action: show
			return
		}

        def findInvite = Invite.find(FIND_INVITE_BY_KEY, [invite_key: String.valueOf(params.invite), invite_used: true])
        System.out.println("params.invite="+params.invite + "; findInvite="+findInvite)
        if (!params.invite || !findInvite) redirect uri: '/'

		if (session.id) {
			def person = new User()
			person.properties = params
			return [person: person]
		}

		redirect uri: '/'
	}

	/**
	 * User Information page for current user.
	 */
	def show = {

		// get user id from session's domain class.
		def user = authenticateService.userDomain()
		if (user) {
			render view: 'show', model: [person: User.get(user.id)]
            //UserProfile userProfile = UserProfile.findByUser(user)
            //redirect(controller: "userProfile", action: "show", params: [id: userProfile.id])
		}
		else {
			redirect action: index
		}
	}

	/**
	 * Edit page for current user.
	 */
	def edit = {

		def person
		def user = authenticateService.userDomain()
		if (user) {
			person = User.get(user.id)
		}

		if (!person) {
			flash.message = "[Illegal Access] User not found with id ${params.id}"
			redirect action: index
			return
		}

		[person: person]
	}

	/**
	 * update action for current user's edit page
	 */
	def update = {

		def person
		def user = authenticateService.userDomain()
		if (user) {
			person = User.get(user.id)
		}
		else {
			redirect action: index
			return
		}

		if (!person) {
			flash.message = "[Illegal Access] User not found with id ${params.id}"
			redirect action: index, id: params.id
			return
		}

		// if user want to change password. leave passwd field blank, passwd will not change.
		if (params.passwd && params.passwd.length() > 0
				&& params.repasswd && params.repasswd.length() > 0) {
			if (params.passwd == params.repasswd) {
				person.passwd = authenticateService.encodePassword(params.passwd)
			}
			else {
				person.passwd = ''
				flash.message = 'The passwords you entered do not match.'
				render view: 'edit', model: [person: person]
				return
			}
		}

		person.userRealName = params.userRealName
		person.email = params.email
		if (params.emailShow) {
			person.emailShow = true
		}
		else {
			person.emailShow = false
		}

		if (person.save()) {
			redirect action: show, id: person.id
		}
		else {
			render view: 'edit', model: [person: person]
		}
	 }

	/**
	 * Person save action.
	 */
	def save = {

		// skip if already logged in
		if (authenticateService.isLoggedIn()) {
			redirect action: show
			return
		}

		def person = new User()
		person.properties = params

		def config = authenticateService.securityConfig
		def defaultRole = config.security.defaultRole

		def role = Role.findByAuthority(defaultRole)
		if (!role) {
			person.passwd = ''
			flash.message = 'Default Role not found.'
			render view: 'index', model: [person: person]
			return
		}

		if (params.captcha.toUpperCase() != session.captcha) {
			person.passwd = ''
			flash.message = 'Access code did not match.'
			render view: 'index', model: [person: person]
			return
		}

		if (params.passwd != params.repasswd) {
			person.passwd = ''
			flash.message = 'The passwords you entered do not match.'
			render view: 'index', model: [person: person]
			return
		}

		def pass = authenticateService.encodePassword(params.passwd)
		person.passwd = pass
		person.enabled = true
		person.emailShow = true
		person.description = ''
		if (person.save()) {
			role.addToPeople(person)
			if (config.security.useMail) {
				String emailContent = """You have signed up for an account at:

 ${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}

 Here are the details of your account:
 -------------------------------------
 LoginName: ${person.username}
 Email: ${person.email}
 Full Name: ${person.userRealName}
 Password: ${params.passwd}
"""

				def email = [
					to: [person.email], // 'to' expects a List, NOT a single email address
					subject: "[${request.contextPath}] Account Signed Up",
					text: emailContent // 'text' is the email body
				]
				emailerService.sendEmails([email])
			}

			person.save(flush: true)

            ImageController.realPath = servletContext.getRealPath("/")
            ImageController.applicationName= grailsApplication.metadata['app.context']

            def imageFile = request.getFile(SITE_IMAGE)
            def imageInstance = createUserImage(person.username, imageFile)
            if (imageInstance) imageInstance.save(flush: true)
            createUserProfile(person)
		}
		else {
			person.passwd = ''
			render view: 'index', model: [person: person]
		}
	}

    private static final String SITE_IMAGE = 'site_image'
    private static final String AVATAR_DIR = File.separator + "avatars"
    private static final log = LogFactory.getLog(this);

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

    private def createUserProfile(User person) {
        UserProfile userProfile = new UserProfile()
        userProfile.language = Language.ENGLISH
        userProfile.user = person
        userProfile.payProfile = PayProfile.findByName("Default")
        userProfile.userImage = Image.findByName(person.username)

        def userProfileSave = userProfile.save(flush: true)
        def auth = new AuthToken(person.username, params.passwd)
        def authtoken = daoAuthenticationProvider.authenticate(auth)
        SCH.context.authentication = authtoken

        if (userProfileSave) {
            redirect(controller: "userProfile", action: "show", params: [id: userProfile.id])
        } else {
            redirect uri: '/'
        }

    }
}
