package com.sp.site

import org.apache.commons.logging.LogFactory
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.profiles.UserProfile
import com.sp.impl.Prognosis
import com.sp.impl.UserService
import com.sp.enums.Language
import org.apache.commons.lang.StringUtils
import com.sp.auth.User

class SiteController {

    private static final log = LogFactory.getLog(this);
    UserService userService
    
    private static final Language DEFAULT_LANGUAGE=Language.ENGLISH

    def index = {

        Post postInstance = parsePost()

        if (!postInstance) {
            log.debug("index.params="+params)
        }
        else {

            def userProfile = null
            if (userService.authenticateService.isLoggedIn()){
                userProfile = UserProfile.findByUser(userService.user)
            }
            [postInstance: postInstance,
              userProfile: userProfile
            ]
        }
    }

    def mobile = {

        Post postInstance = parsePost()

        if (!postInstance) {
            log.debug("index.params="+params)
        }
        else {

            UserProfile userProfile = getUserProfile()
            [postInstance: postInstance,
                    userProfile: userProfile
            ]
        }
    }

    private UserProfile getUserProfile() {
        def userProfile = null
        if (userService.authenticateService.isLoggedIn()) {
            userProfile = UserProfile.findByUser(userService.user)
        }
        return userProfile
    }

    private Post parsePost() {
        def postInstance
        if (params.post) {
            postInstance = Post.get(params.post)
        } else {
            UserProfile userProfile = getUserProfile()
            if (userProfile && userProfile.language)
                postInstance = Post.findByNameAndLanguage(userProfile.language.homeName, userProfile.language)
            else
                postInstance = Post.findByNameAndLanguage(Language.ENGLISH.homeName, Language.ENGLISH)

            def id = params.id
            if (id) {
                def post = Post.get(id)
                if (post) {
                    postInstance = post
                }
            }
        }
        return postInstance
    }

    def language = {
        Language language = DEFAULT_LANGUAGE
        
        if (params.language && !StringUtils.isEmpty(params.language)) {
            language = Language.valueOf(Language.class, String.valueOf(params.language))
        }

        if (userService.authenticateService.isLoggedIn()){
            UserProfile userProfile = UserProfile.findByUser(userService.user)
            userProfile.language = language
            userProfile.save(flush: true)
        }

        redirect(action: index)
    }

    def create = {
        def commentInstance = new Comment()
        commentInstance.properties = params
        return [commentInstance: commentInstance]
    }


    def profile = {
        redirect(controller: "userProfile", action: "profile")
    }

    def register = {
        redirect(controller: "register", action: "index")
    }

    @Secured(['ROLE_ADMIN'])
    def admin = {

    }

    @Secured(['ROLE_USER','ROLE_ADMIN'])
    def prognosis = {
        def userProfile = UserProfile.findByUser(userService.getUser())
        def purchasedPrognosisList
        if (userProfile.payProfile.period==0)
        {
            purchasedPrognosisList = userProfile.prognosisList
        }
        else
        {
            purchasedPrognosisList = Prognosis.list()
        }
        [prognosisInstanceList: purchasedPrognosisList, prognosisInstanceTotal: purchasedPrognosisList.size()]
    }

    private redirectToPage(String pageName) {
        def post = Post.findByName(pageName)
        def id = post != null ? post.id : null
        redirect(controller: "site", action: "index", params: [post: id])
    }
}
