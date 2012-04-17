
<%@ page import="com.sp.site.Image" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'image.label', default: 'Image')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${imageInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: imageInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: imageInstance, field: "description")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">HTML</td>
                            <td valign="top" class="value">${imageInstance?.toHtmlPseudoTag()}</td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.fileName.label" default="File Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: imageInstance, field: "fileName")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.webRootDir.label" default="Web Root Dir" /></td>

                            <td valign="top" class="value">${fieldValue(bean: imageInstance, field: "webRootDir")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.lastUpdated.label" default="Last Updated" /></td>

                            <td valign="top" class="value"><g:formatDate date="${imageInstance?.lastUpdated}" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.dateCreated.label" default="Date Created" /></td>

                            <td valign="top" class="value"><g:formatDate date="${imageInstance?.dateCreated}" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.visible.label" default="Visible" /></td>

                            <td valign="top" class="value"><g:formatBoolean boolean="${imageInstance?.visible}" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.style.label"
                                                                     default="Style"/></td>
                            <td valign="top" class="value">${fieldValue(bean: imageInstance, field: "style")}</td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.width.label"
                                                                     default="Width"/></td>
                            <td valign="top" class="value">${fieldValue(bean: imageInstance, field: "width")}</td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="image.height.label"
                                                                     default="Height"/></td>
                            <td valign="top" class="value">${fieldValue(bean: imageInstance, field: "height")}</td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Image</td>
                            <td valign="top" class="value">${imageInstance?.toHtmlTag()}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
