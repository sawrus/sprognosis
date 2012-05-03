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
            <a href="#anchor" id="anchor"/>
            <div class="grid_8">
                <g:if test="${'Default'.equals(userProfile.payProfile.name)}">
                    <g:link controller="site" action="actual" class="button">Buy prognosis</g:link>
                </g:if>
                <g:each in="${prognosisInstanceList}" var="prognosis" status="i">
                    <h2 class="ident-bot-2">Prognosis #${i}</h2>
                    <table width="100%">
                        <tr><td class="nameCountProperty2">Actual date</td><td class="valueCountProperty2">${prognosis.actualDate}</td></tr>
                        <tr><td class="nameCountProperty2">Sport event</td><td class="valueCountProperty2">${prognosis.sportEvent}</td></tr>
                        <tr><td class="nameCountProperty2">Category</td><td class="valueCountProperty2">${prognosis.category}</td></tr>
                        %{--<tr><td class="nameCountProperty">Description</td><td class="valueCountProperty">${prognosis.description}</td></tr>--}%
                        <tr><td class="nameCountProperty2">Bets URL</td><td class="valueCountProperty2"><a href="${prognosis.betsUrl}">link</a></td></tr>
                        <tr><td class="nameCountProperty2">Commands</td><td class="valueCountProperty2">${prognosis.first} - ${prognosis.second}</td></tr>
                        <tr><td class="nameCountProperty2">Points</td><td class="valueCountProperty2">${prognosis.firstPoints} : ${prognosis.secondPoints}</td></tr>
                        <tr><td class="nameCountProperty2">Coefficient</td><td class="valueCountProperty2">${prognosis.firstBetsCoefficient} / ${prognosis.secondBetsCoefficient}</td></tr>
                    </table>
                </g:each>
            </div>
            <div class="grid_4">
                <div class="block-3 ident-top-2">
                    <g:ifAnyGranted role="ROLE_USER">
                        <h3 class="ident-bot-2">Profile</h3>
                        <g:if test="${userProfile?.userImage}">
                            <div class="ident-bot-6">
                                ${userProfile?.userImage?.toHtmlTagWithResize(150, 150)}
                            </div>

                            <div class="line ident-bot-5"></div>
                        </g:if>

                        <g:set var="payProfile"
                               value="${userProfile?.payProfile ? userProfile.payProfile : PayProfile.findByPeriod(0)}"/>
                        <div class="ident-bot-6">
                            <table>
                                <tr><td class="nameProfileProperty">${language.payProfile.get(0)}</td><td
                                        class="valueProfileProperty">${payProfile?.name}</td></tr>
                                <tr><td class="nameProfileProperty">${language.payProfile.get(1)}</td><td
                                        class="valueProfileProperty">${payProfile.price}${payProfile.priceType}</td>
                                </tr>
                                <tr><td class="nameProfileProperty">${language.payProfile.get(2)}</td><td
                                        class="valueProfileProperty">${payProfile.period}${payProfile.periodType}</td>
                                </tr>
                                <tr><td class="nameProfileProperty">${language.payProfile.get(3)}</td><td
                                        class="valueProfileProperty">${payProfile.description}</td></tr>
                            </table>

                            <div class="clear"></div>
                        </div>

                        <div class="line ident-bot-5"></div>
                    </g:ifAnyGranted>
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