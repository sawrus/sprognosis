package com.sp.admin

import com.sp.site.PostCategory
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.enums.Language
import com.sp.site.Post
import com.sp.site.Banner

@Secured(['ROLE_ADMIN'])
class PostCategoryAdminController {

    def scaffold = PostCategory

    @Secured(['ROLE_ADMIN'])
    def setDefaultLanguage = {
//        for (PostCategory category: PostCategory.list()){
//            category.language=Language.ENGLISH
//            category.save(flush: true)
//
//            for (Post post: category.posts){
//                post.language=Language.ENGLISH
//                post.save(flush: true)
//            }
//        }
//        for (Banner banner: Banner.list()){
//            banner.language=Language.ENGLISH
//            banner.save(flush: true)
//        }
        redirect(action: "list")
    }

}
