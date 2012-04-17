

<%@ page import="com.sp.site.Image" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'image.label', default: 'Image')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${imageInstance}">
            <div class="errors">
                <g:renderErrors bean="${imageInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:uploadForm action="save" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="image.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: imageInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${imageInstance?.name}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="path"><g:message code="image.path.label" default="Path" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: imageInstance, field: 'path', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${imageInstance?.path}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="image.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: imageInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${imageInstance?.description}" />
                                </td>
                            </tr>


                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="style"><g:message code="image.style.label" default="Style" /> [height:10; width:10]</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: imageInstance, field: 'style', 'errors')}">
                                    <g:textField name="style" value="${imageInstance?.style}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="visible"><g:message code="image.visible.label" default="Visible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: imageInstance, field: 'visible', 'errors')}">
                                    <g:checkBox name="visible" value="${imageInstance?.visible}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">Image</td>
                                <td valign="top" class="value"><input type="file" id="site_image" name="site_image"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:uploadForm>
        </div>
    </body>
</html>
