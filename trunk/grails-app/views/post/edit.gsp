

<%@ page import="com.sp.site.Post" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'post.label', default: 'Post')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <resource:richTextEditor type="full"/>

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${postInstance}">
            <div class="errors">
                <g:renderErrors bean="${postInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${postInstance?.id}" />
                <g:hiddenField name="version" value="${postInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="post.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" size="100" value="${postInstance?.name}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title"><g:message code="post.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'title', 'errors')}">
                                    <g:textField name="title"  size="100" value="${postInstance?.title}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content"><g:message code="post.content.label" default="Content" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'content', 'errors')}">
                                    %{--<g:textArea name="content" cols="40" rows="5" value="${postInstance?.content}" />--}%
                                    <richui:richTextEditor name="content" id="content" value="${postInstance?.content}" width="640" height="480"/>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="announcement"><g:message code="post.announcement.label" default="Announcement" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'announcement', 'errors')}">
                                    %{--<g:textArea name="announcement" cols="40" rows="5" value="${postInstance?.announcement}" />--}%
                                    <richui:richTextEditor name="announcement" id="announcement" value="${postInstance?.announcement}" width="640" height="360"/>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="post.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'description', 'errors')}">
                                    %{--<g:textArea name="description" cols="40" rows="5" value="${postInstance?.description}" />--}%
                                    <richui:richTextEditor name="description" id="description" value="${postInstance?.description}" width="640" height="240"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="RSSVisible"><g:message code="post.RSSVisible.label" default="RSSV isible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'RSSVisible', 'errors')}">
                                    <g:checkBox name="RSSVisible" value="${postInstance?.RSSVisible}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="allowComments"><g:message code="post.allowComments.label" default="Allow Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'allowComments', 'errors')}">
                                    <g:checkBox name="allowComments" value="${postInstance?.allowComments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="author"><g:message code="post.author.label" default="Author" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'author', 'errors')}">
                                    <g:select name="author.id" from="${com.sp.auth.User.list()}" optionKey="id" value="${postInstance?.author?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="post.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'category', 'errors')}">
                                    <g:select name="category.id" from="${com.sp.site.PostCategory.list()}" optionKey="id" value="${postInstance?.category?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="categoryVisible"><g:message code="post.categoryVisible.label" default="Category Visible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'categoryVisible', 'errors')}">
                                    <g:checkBox name="categoryVisible" value="${postInstance?.categoryVisible}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="post.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'comments', 'errors')}">
                                    
<ul>
<g:each in="${postInstance?.comments?}" var="c">
    <li><g:link controller="comment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="comment" action="create" params="['post.id': postInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'comment.label', default: 'Comment')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="images"><g:message code="post.images.label" default="Images" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'images', 'errors')}">
                                    <g:select name="images" from="${com.sp.site.Image.list()}" multiple="yes" optionKey="id" size="5" value="${postInstance?.images*.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="language"><g:message code="post.language.label" default="Language" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'language', 'errors')}">
                                    <g:select name="language" from="${com.sp.enums.Language?.values()}" keys="${com.sp.enums.Language?.values()*.name()}" value="${postInstance?.language?.name()}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="mainPageVisible"><g:message code="post.mainPageVisible.label" default="Main Page Visible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'mainPageVisible', 'errors')}">
                                    <g:checkBox name="mainPageVisible" value="${postInstance?.mainPageVisible}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="socialVisible"><g:message code="post.socialVisible.label" default="Social Visible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'socialVisible', 'errors')}">
                                    <g:checkBox name="socialVisible" value="${postInstance?.socialVisible}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tags"><g:message code="post.tags.label" default="Tags" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'tags', 'errors')}">
                                    <g:select name="tags" from="${com.sp.site.Tag.list()}" multiple="yes" optionKey="id" size="5" value="${postInstance?.tags*.id}" />
                                </td>
                            </tr>
                        

                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="twitterVisible"><g:message code="post.twitterVisible.label" default="Twitter Visible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'twitterVisible', 'errors')}">
                                    <g:checkBox name="twitterVisible" value="${postInstance?.twitterVisible}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="visible"><g:message code="post.visible.label" default="Visible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'visible', 'errors')}">
                                    <g:checkBox name="visible" value="${postInstance?.visible}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
