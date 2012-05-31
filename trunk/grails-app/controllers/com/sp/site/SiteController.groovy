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

    private static final String FIND_POST_BY_NAME = "from Post as p where lower(p.name)=:postName and p.language=:language"
    private static final String FIND_CATEGORY_BY_NAME = "from PostCategory as c where lower(c.name)=:categoryName and c.language=:language"
    public static final String FIND_INVITE_BY_KEY = "from Invite as i where i.invite_key=:invite_key and i.invite_used=:invite_used"

    /////////////////////////////////////////// Site actions

    def search = {
        UserProfile userProfile = getUserProfile()
        Language language = DEFAULT_LANGUAGE
        PostCategory categoryInstance = null
        Post postInstance = null

        if (params.search) {
            String postName = String.valueOf(params.search).replaceAll("_", " ").toLowerCase()
            postInstance = Post.find(FIND_POST_BY_NAME, [postName: postName, language: language])
            if (postInstance) {
                language = postInstance.language
                SiteFunction function = parseSiteFunction(postInstance)
                if (function) {
                    callAction(function)
                } else {
                    if (userProfile) {
                        render view: "index", model: [postInstance: postInstance, userProfile: userProfile]
                    } else {
                        render view: "index", model: [postInstance: postInstance, language: language.name()]
                    }
                }
            } else {
                String categoryName = String.valueOf(params.search).replaceAll("_", " ").toLowerCase()
                categoryInstance = PostCategory.find(FIND_CATEGORY_BY_NAME, [categoryName: categoryName, language: language])
                if (categoryInstance) {
                    if (userProfile) {
                        render view: "index", model: [categoryInstance: categoryInstance, userProfile: getUserProfile()]
                    } else {
                        render view: "index", model: [categoryInstance: categoryInstance, language: language.name()]
                    }
                }
            }
        }

        if (!postInstance && !categoryInstance) {
            redirect(action: index)
        }
    }

    def index = {
        UserProfile userProfile = getUserProfile()
        if (params.category) {
            [categoryInstance: PostCategory.findById(params.category), userProfile: userProfile]
        }
        else {
            Post postInstance = parsePost()
            SiteFunction function = parseSiteFunction(postInstance)
            if (function) {
                callAction(function)
            } else {
                [postInstance: postInstance, userProfile: userProfile]
            }
        }
    }

    def mobile = {
        [postInstance: parsePost(), userProfile: getUserProfile()]
    }

    def language = {
        Language language = DEFAULT_LANGUAGE
        if (params.language) {
            language = Language.parseLanguageByName(params.language)
        }
        if (userService.authenticateService.isLoggedIn()) {
            UserProfile userProfile = getUserProfile()
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

    def generateInvite = {
        try {
            com.sp.site.Invite.generateKey()
        } catch (Exception e) {
            log.debug("generateInvite.e:",e)
        }
        redirect(action: "index")
    }

    def register = {
        if (userService.authenticateService.isLoggedIn()) {
            redirect(controller: "register", action: "index")
        } else {
            if (params.invite) {
                if (!checkInvite(params.invite)) {
                    flash.message = 'Ooops, Sorry, you have not invite to our club'
                    render view: 'register'
                } else {
                    redirect(controller: "register", action: "index", params: [invite: params.invite])
                }
            }
        }
    }

    @Secured(['ROLE_ADMIN'])
    def admin = {}

    def error = {
    }

    def contact = {
        [postInstance: Post.findByName(SiteFunction.CONTACT_US.name), userProfile: userProfile]
    }

    def payment = {
        [postInstance: Post.findByName(SiteFunction.PAYMENT_INFORMATION.name), userProfile: userProfile]
    }

    /////////////////////////////////////////// Prognosis: user actions
    @Secured(['ROLE_USER'])
    def purchased = {
        def userProfile = getUserProfile()
        def purchasedPrognosisList
        if (userProfile.payProfile.period == 0) {
            purchasedPrognosisList = userProfile?.prognosisList
            if (purchasedPrognosisList == null || purchasedPrognosisList.isEmpty()) {
                redirect(action: "sold")
            }
        }
        else {
            purchasedPrognosisList = Prognosis.list()
        }

        Language language = userProfile ? userProfile.language : DEFAULT_LANGUAGE
        [prognosisInstanceList: purchasedPrognosisList,
                prognosisInstanceTotal: purchasedPrognosisList.size(),
                postInstance: Post.findByNameAndLanguage(SiteFunction.AS_USER.name, language), userProfile: userProfile
        ]
    }
    @Secured(['ROLE_USER'])
    def sold =
    {
        def userProfile = getUserProfile()
        Language language = userProfile ? userProfile.language : DEFAULT_LANGUAGE
        def actualPrognosisList = Prognosis.findAllByActualAndVoteNotLessThan(Boolean.TRUE, 0)
        [prognosisInstanceList: actualPrognosisList,
                prognosisInstanceTotal: actualPrognosisList.size(),
                postInstance: Post.findByNameAndLanguage(SiteFunction.AS_USER.name, language), userProfile: userProfile
        ]
    }

    /////////////////////////////////////////// Prognosis: handicapper actions
    @Secured(['ROLE_PROGNOSTICATOR', 'ROLE_ADMIN'])
    def checked = {
        def userProfile = getUserProfile()
        Language language = userProfile ? userProfile.language : DEFAULT_LANGUAGE
        def checkedPrognosis = Prognosis.findAllByPrognosticatorAndIsValid(userService.user, Boolean.TRUE)
        def predictedList = Prognosis.findAllByPrognosticator(userService.user)

        def testCondition = checkedPrognosis.size() > COUNT_PROGNOSTICATOR_TEST_PASSED
        if (testCondition)
            flash.message = "All tests run"
        else
            flash.message = checkedPrognosis.size() + " tests passed out of " + COUNT_PROGNOSTICATOR_TEST_PASSED
        [prognosisInstanceList: predictedList,
                prognosisInstanceTotal: predictedList.size(),
                postInstance: Post.findByNameAndLanguage(SiteFunction.AS_HANDICAPPER.name, language), userProfile: userProfile
        ]
    }

    /////////////////////////////////////////// other functions

    private Post parsePost() {
        Post postInstance = null
        if (params.post) {
            postInstance = Post.findById(params.post)
        } else {
            UserProfile userProfile = getUserProfile()
            if (userProfile && userProfile.language)
                postInstance = Post.findByNameAndLanguage(userProfile.language.homeName, userProfile.language)
            else {
                if (params.language) {
                    Language language = Language.parseLanguageByName(params.language)
                    postInstance = Post.findByNameAndLanguage(language.homeName, language)
                } else {
                    postInstance = Post.findByNameAndLanguage(DEFAULT_LANGUAGE.homeName, DEFAULT_LANGUAGE)
                }
                if (params.id) {
                    postInstance = Post.findById(params.id)
                }
            }
        }
        return postInstance
    }

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

    private SiteFunction parseSiteFunction(Post post) {
        return post && post.name ? SiteFunction.parseByName(post.name) : null
    }

    private callAction(SiteFunction function) {
        redirect(action: function.action, controller: function.controller)
    }

    private boolean checkInvite(String inviteKey) {
        boolean isCorrectInvite = false
        Invite invite = Invite.find(FIND_INVITE_BY_KEY, [invite_key: inviteKey, invite_used: false])
        if (invite) {
            invite.invite_used = true
            invite.save(flash: true);
            isCorrectInvite = true
        }
        return isCorrectInvite
    }
}
