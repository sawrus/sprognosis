<%@ page import="com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.mobile-1.0a1.min.css')}"/>
    <g:javascript src="jquery-1.7.1.min.js"/>
    <g:javascript src="jquery.mobile-1.0a1.min.js"/>
    <g:if test="${postInstance == null}">
        <title>Sport Prognosis (mobile)</title>
    </g:if>
    <g:else>
        <title>Sport Prognosis #${postInstance?.title} (mobile)</title>
    </g:else>
    <g:layoutHead/>
</head>

<body>
<div data-role="page">
    <div data-role="header">
        <g:link controller="site" action="mobile" data-role="button" data-icon="home">Home</g:link>
        <g:if test="${postInstance == null}">
            <h1>Sport Prognosis</h1>
        </g:if>
        <g:else>
            <h1>Sport Prognosis #${postInstance.title}</h1>
        </g:else>
        <g:isNotLoggedIn>
            <g:link controller="login" data-role="button" class="ui-btn-right">Login</g:link>
        </g:isNotLoggedIn>
        <g:isLoggedIn>
            <g:link controller="logout" action="index" data-role="button" class="ui-btn-right">Logout</g:link>
        </g:isLoggedIn>
    </div><!-- /header -->

    <div data-role="navbar" data-theme="a">
        <ul>
            <g:each in="${PostCategory.list()}" var="category">
                <g:if test="${category?.visible}">
                    <g:each in="${category?.posts}" var="post">
                        <li>
                            <g:link controller="site" action="mobile"
                                    params="[post: post?.id]">
                                <g:if test="${category.posts.size() == 1}">${category?.name}</g:if>
                                <g:else>${category?.name} -> ${post?.name}</g:else>
                            </g:link>
                        </li>
                    </g:each>
                </g:if>
            </g:each>
        </ul>
    </div>
    <g:layoutBody/>
    <div data-role="footer">
        <div data-role="controlgroup" data-type="horizontal">
            <g:link controller="site" action="mobile" data-role="button" data-icon="home">Home</g:link>
            <g:isNotLoggedIn>
                <g:link controller="login" data-role="button" class="ui-btn-right">Login</g:link>
                <g:link controller="site" action="register" data-role="button" class="ui-btn-right">Register</g:link>
            </g:isNotLoggedIn>
            <g:isLoggedIn>
                <g:link controller="logout" action="index" data-role="button" class="ui-btn-right">Logout</g:link>
            </g:isLoggedIn>
        </div>
    </div><!-- /header -->
</div><!-- /page -->
</body>
</html>