package com.sp.site

import com.sp.enums.Language
import com.sp.enums.SiteFunction
import com.sp.impl.Prognosis
import com.sp.impl.UserService
import com.sp.profiles.UserProfile
import org.apache.commons.logging.LogFactory
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

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
        if (params.category){
            PostCategory categoryInstance = PostCategory.list().iterator().next()
            Long categoryId = parseParameterAsId(params.category)
            if (categoryId){
                def get = PostCategory.get(categoryId)
                if (get) categoryInstance = get
            }
            [categoryInstance: categoryInstance, userProfile: userProfile]
        }
        else {
            Post postInstance = parsePost()
            SiteFunction function = parseSiteFunction(postInstance)
            if (function){
                callAction(function)
            } else {
                [postInstance: postInstance, userProfile: userProfile]
            }
        }
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

        if (params.language) {
            language = Language.parseLanguageByName(params.language)
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

    def contact = {
        [postInstance: Post.findByName(SiteFunction.CONTACT_US.name), userProfile: userProfile]
    }

    /////////////////////////////////////////// Prognosis: user actions
	@Secured(['ROLE_USER'])
    def purchased = {
        def userProfile = UserProfile.findByUser(userService.getUser())
        def purchasedPrognosisList
        if (userProfile.payProfile.period == 0) {
            purchasedPrognosisList = userProfile.prognosisList
            if (purchasedPrognosisList == null || purchasedPrognosisList.isEmpty()) {
                redirect(action: "sold")
            }
        }
        else {
            purchasedPrognosisList = Prognosis.list()
        }

        [prognosisInstanceList: purchasedPrognosisList,
                prognosisInstanceTotal: purchasedPrognosisList.size(),
                postInstance: Post.findByName(SiteFunction.AS_USER.name), userProfile: userProfile
        ]
    }
    @Secured(['ROLE_USER'])
    def sold =
    {
        def userProfile = UserProfile.findByUser(userService.getUser())
        def actualPrognosisList = Prognosis.findAllByActualAndVoteNotLessThan(Boolean.TRUE, 0)
        [prognosisInstanceList: actualPrognosisList,
                prognosisInstanceTotal: actualPrognosisList.size(),
                postInstance: Post.findByName(SiteFunction.AS_USER.name), userProfile: userProfile
        ]
    }

    /////////////////////////////////////////// Prognosis: handicapper actions
    @Secured(['ROLE_PROGNOSTICATOR', 'ROLE_ADMIN'])
    def checked = {
        def userProfile = UserProfile.findByUser(userService.getUser())
        def checkedPrognosis = Prognosis.findAllByPrognosticatorAndIsValid(userService.getUser(), Boolean.TRUE)
        def predictedList = Prognosis.findAllByPrognosticator(userService.getUser())

        def testCondition = checkedPrognosis.size() > COUNT_PROGNOSTICATOR_TEST_PASSED
        if (testCondition)
            flash.message = "All tests run"
        else
            flash.message = checkedPrognosis.size() + " tests passed out of " + COUNT_PROGNOSTICATOR_TEST_PASSED
        [prognosisInstanceList: predictedList,
                prognosisInstanceTotal: predictedList.size(),
                postInstance: Post.findByName(SiteFunction.AS_HANDICAPPER.name), userProfile: userProfile
        ]
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
        Post postInstance = Post.list().iterator().next()
        if (params.post) {
            Long postId = parseParameterAsId(params.post)
            def get = Post.get(postId)
            if (get) postInstance = get
        } else {
            UserProfile userProfile = getUserProfile()
            if (userProfile && userProfile.language)
                postInstance = Post.findByNameAndLanguage(userProfile.language.homeName, userProfile.language)
            else {
                if (params.language) {
                    Language language = Language.parseLanguageByName(params.language)
                    postInstance = Post.findByNameAndLanguage(language.homeName, language)
                } else {
                    postInstance = Post.findByNameAndLanguage(Language.ENGLISH.homeName, Language.ENGLISH)
                }
            }

            if (params.id) {
                Long postId = parseParameterAsId(params.id)
                postInstance = Post.get(postId)
            }
        }
        return postInstance
    }

    private Long parseParameterAsId(Object parameter) {
        Long result = null
        try {
            result = Long.parseLong(String.valueOf(parameter))
        } catch (NumberFormatException e) {
            log.debug("parseParameterAsId:parameter=" + parameter + "; e:" + e)
        }
        return result
    }

    private SiteFunction parseSiteFunction(Post post) {
        return post && post.name ? SiteFunction.parseByName(post.name) : null
    }

    private callAction(SiteFunction function) {
        redirect(action: function.action, controller: function.controller)
    }
}
