

<%@ page import="com.sp.site.Comment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${commentInstance}">
            <div class="errors">
                <g:renderErrors bean="${commentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="comment.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="15" value="${commentInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="comment.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${commentInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content"><g:message code="comment.content.label" default="Content" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'content', 'errors')}">
                                    <g:textField name="content" value="${commentInstance?.content}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="author"><g:message code="comment.author.label" default="Author" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'author', 'errors')}">
                                    <g:select name="author.id" from="${com.sp.auth.User.list()}" optionKey="id" value="${commentInstance?.author?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comment"><g:message code="comment.comment.label" default="Comment" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'comment', 'errors')}">
                                    <g:select name="comment.id" from="${com.sp.site.Comment.list()}" optionKey="id" value="${commentInstance?.comment?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="post"><g:message code="comment.post.label" default="Post" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'post', 'errors')}">
                                    <g:select name="post.id" from="${com.sp.site.Post.list()}" optionKey="id" value="${commentInstance?.post?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="visible"><g:message code="comment.visible.label" default="Visible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'visible', 'errors')}">
                                    <g:checkBox name="visible" value="${commentInstance?.visible}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
