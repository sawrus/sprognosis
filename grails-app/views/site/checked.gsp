<%@ page import="com.sp.enums.Language; com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="blog_main"/>
    <g:isLoggedIn>
        <g:set var="user"><g:loggedInUsername/></g:set>
        <g:set var="userProfile" value="${UserProfile.findByUser(User.findByUsername(user))}"/>
        <g:set var="language"
               value="${userProfile != null ? userProfile.language : (params.language ? Language.valueOf(Language.class, params.language) : Language.ENGLISH)}"/>
    </g:isLoggedIn>
    <g:isNotLoggedIn>
        <g:set var="language"
               value="${params.language ? Language.valueOf(Language.class, params.language) : Language.ENGLISH}"/>
    </g:isNotLoggedIn>
</head>

<body id="page1">

<!-- content -->
<section id="content">
    <div class="container_12">
        <div class="wrapper">
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${person}">
                <div class="errors">
                    <g:renderErrors bean="${person}" as="list"/>
                </div>
            </g:hasErrors>
            <a href="#anchor" id="anchor"/>
            <div class="grid_8">
                <g:link controller="prognosis" action="create" class="button">Create prognosis</g:link>
                <g:each in="${prognosisInstanceList}" var="prognosis" status="i">
                    <h2 class="ident-bot-2">Prognosis #${i}</h2>
                    <table width="100%">
                        <tr><td class="nameCountProperty2">Actual date</td><td class="valueCountProperty2">${prognosis.actualDate}</td></tr>
                        <tr><td class="nameCountProperty2">Sport event</td><td class="valueCountProperty2">${prognosis.sportEvent}</td></tr>
                        <tr><td class="nameCountProperty2">Category</td><td class="valueCountProperty2">${prognosis.category}</td></tr>
                        <tr><td class="nameCountProperty2">Bets URL</td><td class="valueCountProperty2"><a href="${prognosis.betsUrl}">link</a></td></tr>
                        <tr><td class="nameCountProperty2">Commands</td><td class="valueCountProperty2">${prognosis.first} - ${prognosis.second}</td></tr>
                        <tr><td class="nameCountProperty2">Points</td><td class="valueCountProperty2">${prognosis.firstPoints} : ${prognosis.secondPoints}</td></tr>
                        <tr><td class="nameCountProperty2">Coefficient</td><td class="valueCountProperty2">${prognosis.firstBetsCoefficient} / ${prognosis.secondBetsCoefficient}</td></tr>
                        <g:if test="${!prognosis.isValid}">
                            <tr><td class="nameCountProperty2">Actions</td><td class="valueCountProperty2">
                            <g:form controller="prognosis" method="POST">
                                <g:hiddenField name="id" value="${prognosis?.id}"/>
                                <g:actionSubmit class="button" action="edit"
                                                                     value="${message(code: 'default.button.edit.label', default: 'Edit')}"/>
                                <g:actionSubmit class="button" action="delete"
                                                                     value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                                     onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                            </g:form>
                            </td></tr>
                        </g:if>
                    </table>
                </g:each>
            </div>
            <div class="grid_4">
                <div class="block-3 ident-top-2">
                    <div class="ident-bot-4">
                        <table>
                            <tr><td class="nameCountProperty">${language.stateProfile.get(0)}</td><td
                                    class="valueCountProperty">${Command.count()}</td></tr>
                            <tr><td class="nameCountProperty">${language.stateProfile.get(1)}</td><td
                                    class="valueCountProperty">${com.sp.impl.Category.count()}</td></tr>
                            <tr><td class="nameCountProperty">${language.stateProfile.get(2)}</td><td
                                    class="valueCountProperty">${Prognosis.count()}</td></tr>
                            <tr><td class="nameCountProperty">${language.stateProfile.get(3)}</td><td
                                    class="valueCountProperty">${Post.count()}</td></tr>
                            <tr><td class="nameCountProperty">${language.stateProfile.get(4)}</td><td
                                    class="valueCountProperty">${User.count()}</td></tr>
                        </table>

                        <div class="clear"></div>
                    </div>
                    <g:isLoggedIn><g:link controller="userProfile" action="profile" class="button">${language.edit}</g:link></g:isLoggedIn>
                </div>
            </div>
        </div>
    </div>
</section><!-- end content -->
</body></html>