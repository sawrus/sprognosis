<%@ page import="com.sp.enums.Language; com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

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
<g:if test="${userProfileInstance != null}">
    <div class="grid_8">
        <h2 class="ident-bot-2">Profile (${userProfileInstance.user?.userRealName})</h2>
        <table width="100%">
            <tr><td class="nameCountProperty2">Site language</td><td
                    class="valueCountProperty2">${userProfileInstance.language}</td></tr>
            <tr><td class="nameCountProperty2">Email</td><td
                    class="valueCountProperty2">${userProfileInstance.user?.email ? userProfileInstance.user?.email : 'None'}</td>
            </tr>
            <tr><td class="nameCountProperty2">Pay profile</td><td
                    class="valueCountProperty2">${userProfileInstance?.payProfile?.encodeAsHTML()}</td></tr>
            <tr><td class="nameCountProperty2">Price</td><td
                    class="valueCountProperty2">${userProfileInstance?.payProfile?.price} ${userProfileInstance?.payProfile?.priceType}</td>
            </tr>
            <tr><td class="nameCountProperty2">Period</td><td
                    class="valueCountProperty2">from <richui:dateChooser name="startPay" format="dd.MM.yyyy"
                                                                         value="${userProfileInstance?.payDate}"/><br>
                to <richui:dateChooser name="endPay" format="dd.MM.yyyy"
                                       value="${userProfileInstance?.payDate?.plus(userProfileInstance?.payProfile?.period)}"/>
            </td></tr>
            <tr><td class="nameCountProperty2">User image</td><td
                    class="valueCountProperty2">${userProfileInstance?.userImage?.toHtmlTagWithResize(200, 200)}
                <g:uploadForm action="changeImage" method="post" controller="userProfile">
                    <input type="file" id="site_image" name="site_image" onchange="submit()"/>
                    <g:hiddenField name="id" value="${userProfile?.id}"/>
                </g:uploadForm>
            </td>
            <tr><td class="nameCountProperty2">Actions</td><td
                    class="valueCountProperty2"><a href="${g.createLink(controller: 'userProfile', action: 'edit')}#h" class="button">${language.editPay}</a>
            </td></tr>
        </table>
    </div>
</g:if>
</body></html>