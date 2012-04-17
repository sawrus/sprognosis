<%@ page import="com.sp.impl.Vote; com.sp.impl.Prognosis; com.sp.profiles.UserProfile" %>
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

                <g:sortableColumn property="vote" title="${message(code: 'prognosis.vote.label', default: 'Vote')}"/>
                <g:sortableColumn property="id" title="Action"/>
            </tr>
            </thead>
            <tbody>
            <g:each in="${prognosisInstanceList}" status="i" var="prognosisInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:textArea name="description" rows="" cols="">
                        ${fieldValue(bean: prognosisInstance, field: "description")}</g:textArea></td>

                    <td>
                    <!--User vote-->
                        <g:set var="userId" value="${loggedInUserInfo(field: 'id')}"/>
                        <g:if test="${!Vote.findByUserIdAndEntityId(new BigInteger(String.valueOf(userId)), prognosisInstance.id)}">
                            <g:remoteLink action="positive" update="vote${prognosisInstance.id}"
                                          params="[id: prognosisInstance.id]">+</g:remoteLink> /
                            <g:remoteLink action="negative" update="vote${prognosisInstance.id}"
                                          params="[id: prognosisInstance.id]">-</g:remoteLink>

                            <div id="vote${prognosisInstance.id}"></div>
                        </g:if>
                        <g:else>
                            <g:formatNumber number="${prognosisInstance.vote}"/>
                        </g:else>
                    <!--User vote-->
                    </td>
                    <td>
						<g:link action="show" id="${prognosisInstance.id}">Show</g:link>
					</td>
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
