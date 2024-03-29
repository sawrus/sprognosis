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

                <g:sortableColumn property="id" title="${message(code: 'prognosis.id.label', default: 'Id')}"/>

                <g:sortableColumn property="description"
                                  title="${message(code: 'prognosis.description.label', default: 'Description')}"/>

                <th><g:message code="prognosis.real.label" default="Real"/></th>

                <th><g:message code="prognosis.prognosticator.label" default="Prognosticator"/></th>

                <g:sortableColumn property="vote" title="${message(code: 'prognosis.vote.label', default: 'Vote')}"/>

                <g:sortableColumn property="actual"
                                  title="${message(code: 'prognosis.actual.label', default: 'Actual')}"/>
                <g:sortableColumn property="isValid"
                                  title="${message(code: 'prognosis.isValid.label', default: 'Is valid')}"/>

            </tr>
            </thead>
            <tbody>
            <g:each in="${prognosisInstanceList}" status="i" var="prognosisInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${prognosisInstance.id}">${fieldValue(bean: prognosisInstance, field: "id")}</g:link></td>

                    <td><g:textArea name="description" rows="" cols="">
                        ${fieldValue(bean: prognosisInstance, field: "description")}</g:textArea></td>

                    <td>${fieldValue(bean: prognosisInstance, field: "real")}</td>

                    <td>${fieldValue(bean: prognosisInstance, field: "prognosticator")}</td>

                    <td>${fieldValue(bean: prognosisInstance, field: "vote")}</td>

                    <td><g:formatBoolean boolean="${prognosisInstance.actual}"/></td>
                    <td><g:formatBoolean boolean="${prognosisInstance.isValid}"/></td>

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
