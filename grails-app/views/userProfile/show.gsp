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
        <g:if test="${flash.message}"><h2 class="ident-bot-2">${flash.message}</h2></g:if>
        <table width="100%">
            <g:ifAnyGranted role="ROLE_USER">
            <tr><td class="prognosisp">As user</td><td
                    class="prognosisv"><g:link controller="site" action="purchased" class="button">${language.myPrognosis}</g:link> <g:link controller="site" action="sold" class="button">${language.buyPrognosis}</g:link></td>
            </tr>
            </g:ifAnyGranted>
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
                    class="prognosisv"><div style="float:inherit;" id="gallery">
            <g:set var="image" value="${userProfileInstance?.userImage}"/>
            <a href="${image.webRootDir + File.separator + image.fileName}">
                ${image.toHtmlTagWithResize(300, 300)}
            </a>
            </div>
                <g:uploadForm action="changeImage" method="post" controller="userProfile">
                    <input type="file" id="site_image" name="site_image" onchange="submit()"/>
                    <g:hiddenField name="id" value="${userProfile?.id}"/>
                </g:uploadForm>
            </td>
            <g:ifAnyGranted role="ROLE_USER">
            <tr><td class="prognosisp">Pay profile</td><td
                    class="prognosisv">${userProfileInstance?.payProfile?.encodeAsHTML()}<br/><a href="${g.createLink(controller: 'userProfile', action: 'edit')}#p" class="button">${language.editPay}</a></td></tr>
            <g:if test="${userProfileInstance?.payProfile.period>0}">
            <tr><td class="prognosisp">Period</td><td
                    class="prognosisv">from <richui:dateChooser name="startPay" format="dd.MM.yyyy"
                                                                         value="${userProfileInstance?.payDate}"/><br>
                to <richui:dateChooser name="endPay" format="dd.MM.yyyy"
                                       value="${userProfileInstance?.payDate?.plus(userProfileInstance?.payProfile?.period)}"/>
            </td></tr>
            <tr><td class="prognosisp">Price</td><td
                    class="prognosisv">${userProfileInstance?.payProfile?.price} ${userProfileInstance?.payProfile?.priceType}</td>
            </tr>
            </g:if>
            </g:ifAnyGranted>
            <g:form method="post">
                <g:hiddenField name="id" value="${userProfileInstance?.id}"/>
                <g:hiddenField name="version" value="${userProfileInstance?.version}"/>

                <tr><td class="prognosisp">Address 1*</td><td
                        class="prognosisv"><g:textField name="address1" size="50" value="${userProfileInstance?.address1}"/></td>
                </tr>
                <tr><td class="prognosisp">Address 2</td><td
                        class="prognosisv"><g:textField name="address2" size="50" value="${userProfileInstance.address2}"/></td>
                </tr>
                <tr><td class="prognosisp">Zip/Postal Code*</td><td
                        class="prognosisv"><g:textField name="zip_postal_code" size="50" value="${userProfileInstance.zip_postal_code}"/></td>
                </tr>
                <tr><td class="prognosisp">City*</td><td
                        class="prognosisv"><g:textField name="city" size="50" value="${userProfileInstance.city}"/></td>
                </tr>
                <tr><td class="prognosisp">State/Province</td><td
                        class="prognosisv"><g:textField name="state_province" size="50" value="${userProfileInstance.state_province}"/></td>
                </tr>
                <tr><td class="prognosisp">Country*</td><td
                        class="prognosisv"><g:textField name="country" size="50" value="${userProfileInstance.country}"/></td>
                </tr>
                <tr><td class="prognosisp">Telephone*</td><td
                        class="prognosisv"><g:textField name="telephone" size="50" value="${userProfileInstance.telephone}"/></td>
                </tr>
                <tr><td class="prognosisp">twitter name</td><td
                        class="prognosisv"><g:textField name="twitter_name" size="50" value="${userProfileInstance.twitter_name}"/></td>
                </tr>
                <tr><td class="prognosisp">facebook profile</td><td
                        class="prognosisv"><g:textField name="facebook_profile" size="50" value="${userProfileInstance.facebook_profile}"/></td>
                </tr>
                <tr><td class="prognosisp">site url</td><td
                        class="prognosisv"><g:textField name="site_url" size="50" value="${userProfileInstance.site_url}"/></td>
                </tr>
                <tr><td class="prognosisp">Actions</td><td
                        class="prognosisv"><g:actionSubmit class="button" action="update" value="${language.edit}"/>
                </td>
                </tr>
            </g:form>
        </table>
    </div>
</g:if>
</body></html>