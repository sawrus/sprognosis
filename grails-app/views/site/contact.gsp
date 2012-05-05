<%@ page import="com.sp.enums.Language; com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

<html lang="en">
<head>
    <meta name="layout" content="blog_main"/>
</head>

<body id="page1">
<g:if test="${postInstance != null}">
    <div class="grid_8">
        <g:if test="${flash.message}"><h2 class="ident-bot-2">${flash.message}</h2></g:if>
        <g:hasErrors bean="${postInstance}"><h2 class="ident-bot-2"><g:renderErrors bean="${postInstance}" as="list"/></h2></g:hasErrors>
        <h2 class="ident-bot-2">${postInstance?.title}</h2>
        <h4 class="ident-bot-3"><a href="#">${postInstance?.announcement}</a>
        </h4>
        <g:each in="${postInstance?.images}" var="image">
            <div style="float:inherit;" id="gallery">
                <a href="${image.webRootDir + File.separator + image.fileName}">
                    ${image.toHtmlTagWithResize(300, 300)}
                </a>
            </div>
        </g:each>
        ${postInstance?.content}
        <g:if test="${postInstance?.allowComments}">
            <g:isNotLoggedIn>
                <div class="comment">
                    <b>Please authorize your user to leave a comment</b>
                </div>
            </g:isNotLoggedIn>
            <g:isLoggedIn>
                <div class="confirm">
                    Please, send your comment:
                    <g:form controller="comment" action="save">
                        <g:textArea name="content" rows="10" cols="80%"
                                    class="comments">${commentInstance?.content}</g:textArea>
                        <g:hiddenField name="id" value="${commentInstance?.id}"/>
                        <g:hiddenField name="post" value="${postInstance?.id}"/>
                        <g:submitButton name="create" class="button" value="CREATE"/>
                    </g:form>
                </div>
            </g:isLoggedIn>
        </g:if>
    </div>
</g:if>
</body></html>