<%@ page import="com.sp.site.Post" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'post.label', default: 'Post')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.id.label" default="Id"/></td>

                <td valign="top" class="value">${fieldValue(bean: postInstance, field: "id")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.name.label" default="Name"/></td>

                <td valign="top" class="value">${fieldValue(bean: postInstance, field: "name")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.description.label" default="Description"/></td>

                <td valign="top" class="value">${fieldValue(bean: postInstance, field: "description")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.content.label" default="Content"/></td>

                <td valign="top" class="value">${fieldValue(bean: postInstance, field: "content")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.announcement.label" default="Announcement"/></td>

                <td valign="top" class="value">${fieldValue(bean: postInstance, field: "announcement")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.RSSVisible.label" default="RSSV isible"/></td>

                <td valign="top" class="value"><g:formatBoolean boolean="${postInstance?.RSSVisible}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.allowComments.label" default="Allow Comments"/></td>

                <td valign="top" class="value"><g:formatBoolean boolean="${postInstance?.allowComments}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.author.label" default="Author"/></td>

                <td valign="top" class="value"><g:link controller="user" action="show"
                                                       id="${postInstance?.author?.id}">${postInstance?.author?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.category.label" default="Category"/></td>

                <td valign="top" class="value"><g:link controller="postCategory" action="show"
                                                       id="${postInstance?.category?.id}">${postInstance?.category?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.categoryVisible.label"
                                                         default="Category Visible"/></td>

                <td valign="top" class="value"><g:formatBoolean boolean="${postInstance?.categoryVisible}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.comments.label" default="Comments"/></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${postInstance.comments}" var="c">
                            <li><g:link controller="comment" action="show"
                                        id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.dateCreated.label" default="Date Created"/></td>

                <td valign="top" class="value"><g:formatDate date="${postInstance?.dateCreated}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.images.label" default="Images"/></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${postInstance.images}" var="i">
                            <li><g:link controller="image" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.language.label" default="Language"/></td>

                <td valign="top" class="value">${postInstance?.language?.encodeAsHTML()}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.lastUpdated.label" default="Last Updated"/></td>

                <td valign="top" class="value"><g:formatDate date="${postInstance?.lastUpdated}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.mainPageVisible.label"
                                                         default="Main Page Visible"/></td>

                <td valign="top" class="value"><g:formatBoolean boolean="${postInstance?.mainPageVisible}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.socialVisible.label" default="Social Visible"/></td>

                <td valign="top" class="value"><g:formatBoolean boolean="${postInstance?.socialVisible}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.tags.label" default="Tags"/></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${postInstance.tags}" var="t">
                            <li><g:link controller="tag" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.title.label" default="Title"/></td>

                <td valign="top" class="value">${fieldValue(bean: postInstance, field: "title")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.twitterVisible.label"
                                                         default="Twitter Visible"/></td>

                <td valign="top" class="value"><g:formatBoolean boolean="${postInstance?.twitterVisible}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="post.visible.label" default="Visible"/></td>

                <td valign="top" class="value"><g:formatBoolean boolean="${postInstance?.visible}"/></td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <g:hiddenField name="id" value="${postInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="edit"
                                                 value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete"
                                                 value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </g:form>
    </div>
</div>
</body>
</html>
