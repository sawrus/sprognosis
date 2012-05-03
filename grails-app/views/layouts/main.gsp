<%@ page import="org.springframework.security.AuthenticationTrustResolverImpl; com.sp.auth.User" %>
<!DOCTYPE html>
<html>
<head>
    <title><g:layoutTitle default="sPrognosis"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.autocomplete.css')}" />
    <g:layoutHead/>
    <g:javascript library="prototype"/>
</head>

<body>
<%--
<div class="userBar">
    <g:isLoggedIn>
        <p>Welcome <g:link action="index" controller="register"><g:loggedInUsername/></g:link>!</p>
        <g:link controller="logout" action="index">Logout</g:link>
    </g:isLoggedIn>
    <g:isNotLoggedIn>
        <g:link controller="login">Login</g:link>
    </g:isNotLoggedIn>
</div>
--%>
<g:layoutBody/>
</body>
</html>