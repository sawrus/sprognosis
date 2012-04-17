<%@ page import="com.sp.profiles.UserProfile" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'userProfile.label', default: 'UserProfile')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
    %{--<g:javascript src="sport_functions.js"/>--}%
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
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>

    <g:hasErrors bean="${userProfileInstance}">
        <div class="errors">
            <g:renderErrors bean="${userProfileInstance}" as="list"/>
        </div>
    </g:hasErrors>

    <div class="dialog">
        <table>
            <th>Name</th>
            <th>Period</th>
            <th>Price</th>
            <th>Description</th>
            <th>Action</th>
            <g:each in="${com.sp.profiles.PayProfile.findAllByIsActive(Boolean.TRUE)}"
                    var="payProfile">
                <tr class="prop">
                    <td valign="top">${payProfile.name}</td>
                    <td valign="top">${payProfile.period} ${payProfile.periodType}</td>
                    <td valign="top">${payProfile.price} ${payProfile.priceType}</td>
                    <td valign="top">${payProfile.description}</td>
                    <td valign="top" id="${payProfile.id}">
                        <paypal:button
                                itemName="${payProfile.name}"
                                itemNumber="${payProfile.id}"
                                buyerId="${userProfileInstance.id}"
                                amount="${(payProfile.price<=0?0.01:payProfile.price)}"
                                discountAmount="0"
                                transactionId="${params?.transactionId}"
                                returnAction="buy"
                                returnController="userProfile"
                                buttonSrc="https://www.paypal.com/en_US/i/btn/btn_subscribe_LG.gif"
                                buttonAlt="Subscribe to ${payProfile.name}"
                        />
                    </td>
                </tr>
            </g:each>
        </table>
    </div>
</body>
</html>
