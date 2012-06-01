<%@ page import="com.sp.site.Banner; com.sp.site.PostCategory" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mobile_main"/>
</head>

<body>
<div data-role="content">
    <g:if test="${flash.message}"><h2 class="ident-bot-2">${flash.message}</h2></g:if>
    <g:if test="${postInstance?.images == null || postInstance?.images.isEmpty()}">
        <g:each in="${Banner.findByVisible(true)}" var="banner" status="b">
            <g:if test="${banner?.image?.visible}">
                ${banner?.image.toHtmlTagWithResize(50)}
            </g:if>
        </g:each>
    </g:if>
    <g:else>
        <g:each in="${postInstance?.images}" var="image">${image.toHtmlTag()}</g:each>
    </g:else>
    <div data-role="collapsible" data-collapsed="false" data-theme="a">
        <h3>${postInstance.title}</h3>
        ${postInstance.content}
    </div>

    <div data-role="collapsible-set" data-theme="a">
        <g:each in="${postInstance?.comments}" var="comment">
            <g:if test="${comment?.visible}">
                <div data-role="collapsible" data-theme="a" data-mini="true">
                    <h3>Comment (${comment?.author}):</h3>
                    ${comment?.content}
                </div>
            </g:if>
        </g:each>
    </div>
</div><!-- /content -->
</body>
</html>