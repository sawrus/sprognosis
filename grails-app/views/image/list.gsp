<%@ page import="com.sp.site.Image" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'image.label', default: 'Image')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="id" title="${message(code: 'image.id.label', default: 'Id')}"/>

                <g:sortableColumn property="name" title="${message(code: 'image.name.label', default: 'Name')}"/>

                <g:sortableColumn property="description"
                                  title="${message(code: 'image.fileName.label', default: 'File Name')}"/>

                <g:sortableColumn property="absolutePath"
                                  title="${message(code: 'image.webRootDir.label', default: 'Web Root Path')}"/>

                <g:sortableColumn property="html" title="Html"/>
                <g:sortableColumn property="visible" title="Visible"/>

            </tr>
            </thead>
            <tbody>
            <g:each in="${imageInstanceList}" status="i" var="imageInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${imageInstance.id}">${fieldValue(bean: imageInstance, field: "id")}</g:link></td>

                    <td>${fieldValue(bean: imageInstance, field: "name")}</td>

                    <td>${fieldValue(bean: imageInstance, field: "fileName")}</td>

                    <td>${fieldValue(bean: imageInstance, field: "webRootDir")}</td>

                    <td>${imageInstance.toHtmlPseudoTag()}</td>
                    <td>${fieldValue(bean: imageInstance, field: "visible")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${imageInstanceTotal}"/>
    </div>
</div>
</body>
</html>
