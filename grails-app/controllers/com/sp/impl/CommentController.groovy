package com.sp.impl

import com.sp.site.Comment

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.site.Post
import org.apache.commons.logging.LogFactory
import org.apache.commons.lang.StringUtils

@Secured(['ROLE_USER','ROLE_ADMIN','ROLE_PROGNOSTICATOR'])
class CommentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    private static final log = LogFactory.getLog(this);

    UserService userService

    def index = {
        redirect uri: '/'
    }

    def create = {
        def commentInstance = new Comment()
        commentInstance.properties = params
        return [commentInstance: commentInstance]
    }

    def save = {
        def commentInstance = new Comment(params)
        commentInstance.author = userService.getUser()
        commentInstance.visible = true

        Post post = Post.findById(params.post)
        if (!post){
            log.debug("save:params.post="+params.post)
        }
        commentInstance.post.id = post.id

        if (params.description==null) commentInstance.description = ""
        if (params.name==null) commentInstance.name = commentInstance.author.username + "/" + new Date()

        if (!StringUtils.isEmpty(params.content)){
            commentInstance.save(flush: true)

            post.addToComments(commentInstance)
            post.save(flush: true)
        }

        redirect(controller: "site", action: "index", params: [post: params.post])
    }

    def show = {
        def commentInstance = Comment.get(params.id)
        if (!commentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect uri: '/'
        }
        else {
            [commentInstance: commentInstance]
        }
    }
}
