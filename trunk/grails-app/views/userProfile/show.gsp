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
        <table width="100%">
            <tr><td class="prognosisp">Site language</td><td
                    class="prognosisv">
            <g:form controller="site" action="language">
            <g:select name="language" from="${Language?.values()}" keys="${Language?.values()*.name()}" value="${language.name()}" onchange="submit()"/>
            </g:form>
            </td></tr>
            <tr><td class="prognosisp">Email</td><td
                    class="prognosisv">${userProfileInstance.user?.email ? userProfileInstance.user?.email : 'None'}</td>
            </tr>
            <tr><td class="prognosisp">User image</td><td
                    class="prognosisv">${userProfileInstance?.userImage?.toHtmlTagWithResize(200, 200)}
                <g:uploadForm action="changeImage" method="post" controller="userProfile">
                    <input type="file" id="site_image" name="site_image" onchange="submit()"/>
                    <g:hiddenField name="id" value="${userProfile?.id}"/>
                </g:uploadForm>
            </td>
            <g:ifAnyGranted role="ROLE_USER">
            <tr><td class="prognosisp">Period</td><td
                    class="prognosisv">from <richui:dateChooser name="startPay" format="dd.MM.yyyy"
                                                                         value="${userProfileInstance?.payDate}"/><br>
                to <richui:dateChooser name="endPay" format="dd.MM.yyyy"
                                       value="${userProfileInstance?.payDate?.plus(userProfileInstance?.payProfile?.period)}"/>
            </td></tr>
            <tr><td class="prognosisp">Pay profile</td><td
                    class="prognosisv">${userProfileInstance?.payProfile?.encodeAsHTML()}</td></tr>
            <tr><td class="prognosisp">Price</td><td
                    class="prognosisv">${userProfileInstance?.payProfile?.price} ${userProfileInstance?.payProfile?.priceType}</td>
            </tr>
            <tr><td class="prognosisp">Actions</td><td
                    class="prognosisv"><a href="${g.createLink(controller: 'userProfile', action: 'edit')}#p" class="button">${language.editPay}</a>
            </td></tr>
            </g:ifAnyGranted>
        </table>
    </div>
</g:if>
</body></html>