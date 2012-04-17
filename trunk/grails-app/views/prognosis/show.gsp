<%@ page import="com.sp.impl.Prognosis" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'prognosis.label', default: 'Prognosis')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
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
                    <td valign="top" class="name"><g:message code="prognosis.id.label" default="Id"/></td>
                    <td valign="top" class="value">${fieldValue(bean: prognosisInstance, field: "id")}</td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="prognosis.real.label" default="Real"/></td>
                    <td valign="top" class="value"><g:link controller="prognosis" action="show"
                                                           id="${prognosisInstance?.real?.id}">${prognosisInstance?.real?.encodeAsHTML()}</g:link></td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="prognosis.prognosticator.label"
                                                             default="Prognosticator"/></td>
                    <td valign="top" class="value"><g:link controller="user" action="show"
                                                           id="${prognosisInstance?.prognosticator?.id}">${prognosisInstance?.prognosticator?.encodeAsHTML()}</g:link></td>

                </tr>
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="prognosis.actual.label" default="Actual"/></td>
                    <td valign="top" class="value"><g:formatBoolean boolean="${prognosisInstance?.actual}"/></td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="prognosis.isValid.label" default="Is Valid"/></td>
                    <td valign="top" class="value"><g:formatBoolean boolean="${prognosisInstance?.isValid}"/></td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="prognosis.dateCreated.label"
                                                             default="Date Created"/></td>
                    <td valign="top" class="value"><g:formatDate date="${prognosisInstance?.dateCreated}"/></td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="prognosis.lastUpdated.label"
                                                             default="Last Updated"/></td>
                    <td valign="top" class="value"><g:formatDate date="${prognosisInstance?.lastUpdated}"/></td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="prognosis.type.label" default="Type"/></td>
                    <td valign="top" class="value">${prognosisInstance?.type?.encodeAsHTML()}</td>
                </tr>

            </g:ifAnyGranted>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.description.label" default="Description"/></td>
                
				<td class="value"><g:textArea name="description">
                        ${fieldValue(bean: prognosisInstance, field: "description")}</g:textArea></td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.vote.label" default="Vote"/></td>
                <td valign="top" class="value">${fieldValue(bean: prognosisInstance, field: "vote")}</td>
            </tr>            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.actualDate.label" default="Actual Date"/></td>
                <td valign="top" class="value"><g:formatDate date="${prognosisInstance?.actualDate}"/></td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.sportEvent.label" default="Sport Event"/></td>
                <td valign="top" class="value">${prognosisInstance?.sportEvent?.encodeAsHTML()}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.first.label" default="First"/></td>
                <td valign="top" class="value">${prognosisInstance?.first?.encodeAsHTML()}
                    %{--<g:link controller="command" action="show"--}%
                                                       %{--id="${prognosisInstance?.first?.id}">${prognosisInstance?.first?.encodeAsHTML()}</g:link>--}%
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.second.label" default="Second"/></td>
                <td valign="top" class="value">${prognosisInstance?.second?.encodeAsHTML()}
                    %{--<g:link controller="command" action="show"--}%
                                                       %{--id="${prognosisInstance?.second?.id}">${prognosisInstance?.second?.encodeAsHTML()}</g:link>--}%
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.firstPoints.label"
                                                         default="First Points"/></td>

                <td valign="top" class="value">${fieldValue(bean: prognosisInstance, field: "firstPoints")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.secondPoints.label"
                                                         default="Second Points"/></td>

                <td valign="top" class="value">${fieldValue(bean: prognosisInstance, field: "secondPoints")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.differentPoints.label"
                                                         default="Different Points"/></td>

                <td valign="top" class="value">${fieldValue(bean: prognosisInstance, field: "differentPoints")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.betsUrl.label" default="Bets Url"/></td>

                <td valign="top" class="value"><a href="${fieldValue(bean: prognosisInstance, field: "betsUrl")}">Link</a></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.firstBetsCoefficient.label"
                                                         default="First Bets Coefficient"/></td>

                <td valign="top"
                    class="value">${fieldValue(bean: prognosisInstance, field: "firstBetsCoefficient")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.secondBetsCoefficient.label"
                                                         default="Second Bets Coefficient"/></td>

                <td valign="top"
                    class="value">${fieldValue(bean: prognosisInstance, field: "secondBetsCoefficient")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.category.label" default="Category"/></td>
                <td valign="top" class="value">${prognosisInstance?.category?.encodeAsHTML()}
                    %{--<g:link controller="category" action="show"--}%
                                                       %{--id="${prognosisInstance?.category?.id}">${prognosisInstance?.category?.encodeAsHTML()}</g:link>--}%
                </td>
            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="prognosis.winner.label" default="Winner"/></td>

                <td valign="top" class="value">${prognosisInstance?.winner?.encodeAsHTML()}
                    %{--<g:link controller="command" action="show"--}%
                                                       %{--id="${prognosisInstance?.winner?.id}">${prognosisInstance?.winner?.encodeAsHTML()}</g:link>--}%
                </td>

            </tr>

            </tbody>
        </table>
    </div>

	<g:ifNotGranted role="ROLE_USER">
    <div class="buttons">
        <g:form>
            <g:hiddenField name="id" value="${prognosisInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="edit"
                                                 value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete"
                                                 value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </g:form>
    </div>
	</g:ifNotGranted>
</div>
</body>
</html>
