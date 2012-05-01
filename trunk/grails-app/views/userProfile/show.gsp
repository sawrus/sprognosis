<%@ page import="com.sp.profiles.UserProfile" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'userProfile.label', default: 'UserProfile')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <resource:dateChooser/>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <g:ifAnyGranted role="ROLE_ADMIN">

        <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                               args="[entityName]"/></g:link></span>
        <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                                   args="[entityName]"/></g:link></span>
    </g:ifAnyGranted>
</div>

<div class="body">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <g:ifAnyGranted role="ROLE_ADMIN">

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="userProfile.id.label" default="Id"/></td>

                    <td valign="top" class="value">${fieldValue(bean: userProfileInstance, field: "id")}</td>

                </tr>
            </g:ifAnyGranted>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="userProfile.user.label" default="User"/></td>
                <td valign="top" class="value">
                    <g:link controller="register"
                            action="show"
                            id="${userProfileInstance?.user?.id}">${userProfileInstance?.user?.encodeAsHTML()}
                    </g:link>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="userProfile.payProfile.label"
                                                         default="Profile"/></td>
                <td valign="top" class="value">${userProfileInstance?.payProfile?.encodeAsHTML()}
                </td>
            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="userProfile.payProfile.label"
                                                         default="Price"/></td>
                <td valign="top" class="value">
                    ${userProfileInstance?.payProfile?.price} ${userProfileInstance?.payProfile?.priceType}
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Period</td>
                <td valign="top" class="value">
                    from <richui:dateChooser name="startPay" format="dd.MM.yyyy"
                                             value="${userProfileInstance?.payDate}"/>
                    <br>
                    to <richui:dateChooser name="endPay" format="dd.MM.yyyy"
                                           value="${userProfileInstance?.payDate?.plus(userProfileInstance?.payProfile?.period)}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">Image</td>
                <td valign="top" class="value">${userProfileInstance?.userImage?.toHtmlTagWithResize(200,200)}</td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <g:hiddenField name="id" value="${userProfileInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="edit"
                                                 value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
            <g:ifAnyGranted role="ROLE_ADMIN">

                <span class="button"><g:actionSubmit class="delete" action="delete"
                                                     value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                     onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
            </g:ifAnyGranted>
        </g:form>
    </div>
</div>
</body>
</html>
