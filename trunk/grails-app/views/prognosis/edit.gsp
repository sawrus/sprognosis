<%@ page import="com.sp.enums.SportEvent; com.sp.enums.PrognosisType; com.sp.impl.Prognosis" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'prognosis.label', default: 'Prognosis')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
	<resource:autoComplete skin="default" />
	<resource:dateChooser />
    <resource:richTextEditor type="full"/>

	<g:javascript src="sport_functions.js"/>
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
<g:hasErrors bean="${prognosisInstance}">
    <div class="errors">
        <g:renderErrors bean="${prognosisInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form method="post">
<g:hiddenField name="id" value="${prognosisInstance?.id}"/>
<g:hiddenField name="version" value="${prognosisInstance?.version}"/>
<div class="dialog">
    <table>
        <tbody>

        <g:ifAnyGranted role="ROLE_ADMIN">
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="real"><g:message code="prognosis.real.label" default="Real"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'real', 'errors')}">
                    <g:select name="real.id" from="${com.sp.impl.Prognosis.list()}" optionKey="id"
                              value="${prognosisInstance?.real?.id}" noSelection="['null': '']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="prognosticator"><g:message code="prognosis.prognosticator.label"
                                                           default="Prognosticator"/></label>
                </td>
                <td valign="top"
                    class="value ${hasErrors(bean: prognosisInstance, field: 'prognosticator', 'errors')}">
                    <g:select name="prognosticator.id" from="${com.sp.auth.User.list()}" optionKey="id"
                              value="${prognosisInstance?.prognosticator?.id}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="vote"><g:message code="prognosis.vote.label" default="Vote"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'vote', 'errors')}">
                    <g:textField name="vote" value="${fieldValue(bean: prognosisInstance, field: 'vote')}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="actual"><g:message code="prognosis.actual.label" default="Actual"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'actual', 'errors')}">
                    <g:checkBox name="actual" value="${prognosisInstance?.actual}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="isValid"><g:message code="prognosis.isValid.label" default="Is Valid"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'isValid', 'errors')}">
                    <g:checkBox name="isValid" value="${prognosisInstance?.isValid}"/>
                </td>
            </tr>
        </g:ifAnyGranted>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="description"><g:message code="prognosis.description.label"
                                                            default="Description"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: prognosisInstance, field: 'description', 'errors')}">
						<richui:richTextEditor name="description" value="${prognosisInstance?.description}"  width="640" height="360"  />
                    </td>
                </tr>
				<tr class="prop">
                    <td valign="top" class="name">
                        <label for="actualDate"><g:message code="prognosis.actualDate.label"
                                                           default="Actual Date"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: prognosisInstance, field: 'actualDate', 'errors')}">
                        %{--<g:datePicker name="actualDate" precision="day" value="${prognosisInstance?.actualDate}"/>--}%
						<richui:dateChooser name="actualDate" format="dd.MM.yyyy" value="${prognosisInstance?.actualDate}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="sportEvent"><g:message code="prognosis.sportEvent.label"
                                                           default="Sport Event"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: prognosisInstance, field: 'sportEvent', 'errors')}">
                        <g:select name="sportEvent" from="${SportEvent?.values()}"
                                  keys="${SportEvent?.values()*.name()}"
                                  value="${prognosisInstance?.sportEvent?.name()}"/>
                    </td>
                </tr>

                <!--First block-->
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="category"><g:message code="prognosis.category.label" default="Category"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'category', 'errors')}">
						<richui:autoComplete name="categoryName" action="${createLinkTo('dir': 'category/searchAJAX')}" 
							minQueryLength="1"
						/>		  
                    </td>
                </tr>
				
				<tr class="prop">
                    <td valign="top" class="name">
                        <label for="type"><g:message code="prognosis.type.label" default="Type"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'type', 'errors')}">
                        <g:select name="type" from="${PrognosisType?.values()}"
                                  keys="${PrognosisType?.values()*.name()}"
                                  value="${prognosisInstance?.type?.name()}" onchange="updateSubTypeDiv()"/>
                    </td>
                </tr>

                <tr class="prop" id="differentPoints">
                    <td valign="top" class="name">
                        <label for="differentPoints"><g:message code="prognosis.differentPoints.label"
                                                                default="Different Points"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: prognosisInstance, field: 'differentPoints', 'errors')}">
                        <g:textField name="differentPoints"
                                  value="${fieldValue(bean: prognosisInstance, field: 'differentPoints')}"/>
                    </td>
                </tr>


                <tr class="prop">
                    <td valign="top" class="name">Stage</td>
                    <td class="value"><table>
                        <thead>
                        <th>Winner</th>
                        <th>Name</th>
                        <th>Points</th>
                        </thead>
					<tbody>
						<tr class="prop">
							<td valign="top" class="value"><g:radio name="winnerName" value="0" checked="true"/></td>
							<td valign="top" class="value">
								<richui:autoComplete name="firstName" action="${createLinkTo('dir': 'command/searchAJAX')}" style="width: 480px" minQueryLength="3" value="${prognosisInstance?.first?.name}"/>
							</td>
							<td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'firstPoints', 'errors')}">
								<g:textField name="firstPoints" value="${fieldValue(bean: prognosisInstance, field: 'firstPoints')}"/>
							</td>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="value"><g:radio name="winnerName" value="1"/></td>
							<td valign="top" class="value">
								<richui:autoComplete name="secondName" action="${createLinkTo('dir': 'command/searchAJAX')}" style="width: 480px" minQueryLength="3" value="${prognosisInstance?.second?.name}"/>
							</td>
							<td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'secondPoints', 'errors')}">
								<g:textField name="secondPoints" value="${fieldValue(bean: prognosisInstance, field: 'secondPoints')}"/>
							</td>
						</tr>
					</tbody>
				</table></td>
				</tr>	
				
                <!--Third block-->
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="betsUrl"><g:message code="prognosis.betsUrl.label" default="Bets Url"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: prognosisInstance, field: 'betsUrl', 'errors')}">
                        <g:textField name="betsUrl" value="${prognosisInstance?.betsUrl}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="firstBetsCoefficient"><g:message code="prognosis.firstBetsCoefficient.label"
                                                                     default="First Bets Coefficient"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: prognosisInstance, field: 'firstBetsCoefficient', 'errors')}">
                        <g:textField name="firstBetsCoefficient"
                                     value="${fieldValue(bean: prognosisInstance, field: 'firstBetsCoefficient')}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="secondBetsCoefficient"><g:message code="prognosis.secondBetsCoefficient.label"
                                                                      default="Second Bets Coefficient"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: prognosisInstance, field: 'secondBetsCoefficient', 'errors')}">
                        <g:textField name="secondBetsCoefficient"
                                     value="${fieldValue(bean: prognosisInstance, field: 'secondBetsCoefficient')}"/>
                    </td>
                </tr>
        </tbody>
    </table>
</div>

<div class="buttons">
    <span class="button"><g:actionSubmit class="save" action="update"
                                         value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
    <span class="button"><g:actionSubmit class="delete" action="delete"
                                         value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
</div>
</g:form>
</div>
</body>
</html>
