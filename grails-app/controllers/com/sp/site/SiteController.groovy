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

    private static final Language DEFAULT_LANGUAGE = Language.ENGLISH
    private static final COUNT_PROGNOSTICATOR_TEST_PASSED = 10;

    /////////////////////////////////////////// Site actions

    /**
     * index page
     */
    def index = {
        UserProfile userProfile = getUserProfile()
        if (params.category) [categoryInstance: PostCategory.get(params.category), userProfile: userProfile]
        else [postInstance: parsePost(), userProfile: userProfile]
    }

    /**
     * index page of mobile version
     */
    def mobile = {
        Post postInstance = parsePost()
        UserProfile userProfile = getUserProfile()
        [postInstance: postInstance, userProfile: userProfile]
    }

    /**
     * changing language
     */
    def language = {
        Language language = DEFAULT_LANGUAGE

        if (params.language && !StringUtils.isEmpty(params.language)) {
            language = Language.valueOf(Language.class, String.valueOf(params.language))
        }

        if (userService.authenticateService.isLoggedIn()) {
            UserProfile userProfile = UserProfile.findByUser(userService.user)
            if (userProfile) {
                userProfile.language = language
                userProfile.save(flush: true)
            }
        }

        redirect(action: index, params: [language: language.name()])
    }

    /**
     * creating new comments
     */
    def create = {
        def commentInstance = new Comment()
        commentInstance.properties = params
        return [commentInstance: commentInstance]
    }

    /**
     * redirect to user profile
     */
    def profile = {
        redirect(controller: "userProfile", action: "profile")
    }

    /**
     * redirect to register form
     */
    def register = {
        redirect(controller: "register", action: "index")
    }

    /**
     * redirect to admin panel
     */
    @Secured(['ROLE_ADMIN'])
    def admin = {}

    /////////////////////////////////////////// Prognosis: user actions
    @Secured(['ROLE_USER', 'ROLE_ADMIN'])
    def prognosis = {
        def userProfile = UserProfile.findByUser(userService.getUser())
        def purchasedPrognosisList
        if (userProfile.payProfile.period == 0) {
            purchasedPrognosisList = userProfile.prognosisList
            if (purchasedPrognosisList == null || purchasedPrognosisList.isEmpty()) {
                redirect(action: "actual")
            }
        }
        else {
            purchasedPrognosisList = Prognosis.list()
        }
        [prognosisInstanceList: purchasedPrognosisList, prognosisInstanceTotal: purchasedPrognosisList.size()]
    }

    @Secured(['ROLE_USER'])
    def actual =
        {
            def actualPrognosisList = Prognosis.findAllByActualAndVoteNotLessThan(Boolean.TRUE, 0)
            [prognosisInstanceList: actualPrognosisList, prognosisInstanceTotal: actualPrognosisList.size()]
        }

    @Secured(['ROLE_USER'])
    def buy = {
        Prognosis prognosis = Prognosis.findById(params.itemNumber)
        if (prognosis)
            payService.buyPrognosis(UserProfile.findByUser(userService.getUser()), prognosis)
        else
            flash.message = "Not found Prognosis #" + params.itemNumber
        redirect(action: "prognosis")
    }

    /////////////////////////////////////////// Prognosis: handicapper actions
    @Secured(['ROLE_PROGNOSTICATOR', 'ROLE_ADMIN'])
    def checked = {
        def checkedPrognosis = Prognosis.findAllByPrognosticatorAndIsValid(userService.getUser(), Boolean.TRUE)
        def predictedList = Prognosis.findAllByPrognosticator(userService.getUser())

        def testCondition = checkedPrognosis.size() > COUNT_PROGNOSTICATOR_TEST_PASSED
        if (testCondition)
            flash.message = "All tests pass!"
        else
            flash.message = checkedPrognosis.size() + " tests pass from " + COUNT_PROGNOSTICATOR_TEST_PASSED
        [prognosisInstanceList: predictedList, prognosisInstanceTotal: predictedList.size()]
    }

    /////////////////////////////////////////// other functions

    private redirectToPage(String pageName) {
        def post = Post.findByName(pageName)
        def id = post != null ? post.id : null
        redirect(controller: "site", action: "index", params: [post: id])
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
            else {
                if (!StringUtils.isEmpty(params.language)) {
                    Language language = Language.valueOf(Language.class, params.language)
                    postInstance = Post.findByNameAndLanguage(language.homeName, language)
                } else {
                    postInstance = Post.findByNameAndLanguage(Language.ENGLISH.homeName, Language.ENGLISH)
                }
            }

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
}