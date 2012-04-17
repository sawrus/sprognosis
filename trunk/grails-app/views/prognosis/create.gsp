<%@ page import="com.sp.enums.SportEvent; com.sp.enums.PrognosisType; com.sp.impl.Prognosis" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'prognosis.label', default: 'Prognosis')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <g:javascript src="sport_functions.js"/>
	<resource:autoComplete skin="default" />
	<resource:dateChooser />
    <resource:richTextEditor type="full"/>

</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="predicted"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${prognosisInstance}">
        <div class="errors">
            <g:renderErrors bean="${prognosisInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="description"><g:message code="prognosis.description.label"
                                                            default="Description"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: prognosisInstance, field: 'description', 'errors')}">
						<richui:richTextEditor name="description" value="${prognosisInstance?.description}"  width="640" height="360" />
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
								<richui:autoComplete name="firstName" id="firstName" action="${createLinkTo('dir': 'command/searchAJAX')}" style="width: 480px" minQueryLength="3"/>
							</td>
							<td valign="top" class="value ${hasErrors(bean: prognosisInstance, field: 'firstPoints', 'errors')}">
								<g:textField name="firstPoints" value="${fieldValue(bean: prognosisInstance, field: 'firstPoints')}"/>
							</td>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="value"><g:radio name="winnerName" value="1"/></td>
							<td valign="top" class="value">
								<richui:autoComplete id="secondName" name="secondName" action="${createLinkTo('dir': 'command/searchAJAX')}" style="width: 480px" minQueryLength="3"/>
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
            <span class="button"><g:submitButton name="create" class="save"
                                                 value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
