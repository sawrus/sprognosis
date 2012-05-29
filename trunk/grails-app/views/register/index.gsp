<%@ page import="com.sp.auth.Role; com.sp.enums.Language; com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

<html lang="en">
<head>
    <meta name="layout" content="blog_main"/>
    <g:isLoggedIn>
    <g:set var="user"><g:loggedInUsername/></g:set>
    <g:set var="userProfile" value="${UserProfile.findByUser(User.findByUsername(user))}"/>
    <g:set var="language" value="${userProfile != null ? userProfile.language : (params.language ? Language.parseLanguageByName(params.language) : Language.ENGLISH)}"/>
    </g:isLoggedIn>
    <g:isNotLoggedIn><g:set var="language" value="${params.language ? Language.parseLanguageByName(params.language) : Language.ENGLISH}"/>
    </g:isNotLoggedIn>
</head>

<body id="page1">
<div class="grid_8">
    <g:if test="${flash.message}">
    <h2 class="ident-bot-2">${flash.message}</h2></g:if>
    <g:hasErrors bean="${person}">
    <h2 class="ident-bot-2"><g:renderErrors bean="${person}" as="list"/></h2></g:hasErrors>
    <h2 class="ident-bot-2">Please Register..</h2>
    <table width="100%">
        <g:uploadForm action="save" method="post">
        <tr><td class="registerp">Login Name</td><td
                class="registerv"><input type="text" name='username' size="40%" value="${person?.username?.encodeAsHTML()}"/></td></tr>
        <tr><td class="registerp">Full Name</td><td
                class="registerv"><input type="text" name='userRealName' size="40%" value="${person?.userRealName?.encodeAsHTML()}"/></td></tr>
        <tr><td class="registerp">Password</td><td
                class="registerv"><input type="password" name='passwd' value="${person?.passwd?.encodeAsHTML()}"/></td></tr>
        <tr><td class="registerp">Confirm Password</td><td
                class="registerv"><input type="password" name='repasswd' value="${person?.passwd?.encodeAsHTML()}"/></td></tr>
        <tr><td class="registerp">Email</td><td
                class="registerv"><input type="text" name='email' size="40%" value="${person?.email?.encodeAsHTML()}"/></td></tr>
        <tr><td class="registerp">Enter Code</td><td
                class="registerv"><input type="text" name="captcha" size="8"/><img src="${createLink(controller:'captcha', action:'index')}" align="absmiddle"/></td></tr>
        <tr><td class="registerp">Participate as</td><td
                class="registerv"><select name="role" id="role" >
                <option value="${Role.ROLE_USER.authority}" >User</option>
                <option value="${Role.ROLE_PROGNOSTICATOR.authority}" >Handicapper</option>
            </select></td></tr>
        <tr><td class="registerp">Upload your photo</td><td
                class="registerv"><input type="file" id="site_image" name="site_image"/></td></tr>
        <tr><td class="registerp">Action</td><td
                class="registerv"><g:submitButton name="create" class="button2" value="Register"/></td></tr>
        </g:uploadForm>
    </table>
</div>
<script type='text/javascript'>
    <!--
    (function(){
        document.forms['loginForm'].elements['username'].focus();
    })();
    // -->
</script>
</body></html>