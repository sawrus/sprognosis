<%@ page import="com.sp.impl.Prognosis" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'prognosis.label', default: 'Prognosis')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="create" action="testing"><g:message code="default.new.label"
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


                <g:sortableColumn property="description"
                title="${message(code: 'prognosis.description.label', default: 'Description')}"/>


                <g:sortableColumn property="actual"
                title="${message(code: 'prognosis.actual.label', default: 'Actual')}"/>
                <g:sortableColumn property="vote" title="${message(code: 'prognosis.vote.label', default: 'Vote')}"/>
                <g:sortableColumn property="id" title="Action"/>
            </tr>
            </thead>
            <tbody>
            <g:each in="${prognosisInstanceList}" status="i" var="prognosisInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:textArea name="description" rows="" cols="">
                        ${fieldValue(bean: prognosisInstance, field: "description")}</g:textArea></td>

                    <td><g:formatBoolean boolean="${prognosisInstance.actual}"/></td>
                    <td>${fieldValue(bean: prognosisInstance, field: "vote")}</td>
                    <td><g:link action="show"
                                id="${prognosisInstance.id}">Show</g:link></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${prognosisInstanceTotal}"/>
    </div>
</div>
</body>
</html>
