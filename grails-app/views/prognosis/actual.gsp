<%@ page import="org.grails.paypal.Payment; com.sp.auth.User; com.sp.impl.Vote; com.sp.impl.Prognosis; com.sp.profiles.UserProfile" %>
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

<paypal:errors bean="payment"/>

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
                    </td>
                    <td>
                        <g:if test="${!UserProfile.checkPrognosisOnPaid(new BigInteger(String.valueOf(userId)), prognosisInstance)}">
                            <g:link action="show" id="${prognosisInstance.id}">Show</g:link>
                        </g:if>
                        <g:else>
                            <paypal:button
                                    itemName="Prognosis #${prognosisInstance.id}"
                                    itemNumber="${prognosisInstance.id}"
                                    buyerId="${userId}"
                                    amount="10.0"
                                    discountAmount="0"
                                    transactionId="${params?.transactionId}"
                                    buttonAlt="Buy Prognosis #${prognosisInstance.id}"
                                    returnAction="buy" returnController="prognosis"/>
                        </g:else>
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
