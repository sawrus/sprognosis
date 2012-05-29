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
<div class="grid_8">
    <g:if test="${flash.message}"><h2 class="ident-bot-2">${flash.message}</h2></g:if>
    <g:if test="${postInstance != null}">
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
    </g:if>
    <g:link controller="prognosis" action="create" class="button">${language.createPrognosis}</g:link>
    <g:each in="${prognosisInstanceList}" var="prognosis" status="i">
        <g:hasErrors bean="${prognosis}"><h2 class="ident-bot-2"><g:renderErrors bean="${prognosis}" as="list"/></h2></g:hasErrors>
        <h2 class="ident-bot-2">${language.prognosis} #${i}</h2>
        <table width="100%">
            <tr><td class="prognosisp">${language.prognosisFields.get(0)}</td><td
                    class="prognosisv">${prognosis.actualDate}</td></tr>
            <tr><td class="prognosisp">${language.prognosisFields.get(1)}</td><td
                    class="prognosisv">${prognosis.sportEvent}</td></tr>
            <tr><td class="prognosisp">${language.prognosisFields.get(2)}</td><td
                    class="prognosisv">${prognosis.category}</td></tr>
            <tr><td class="prognosisp">${language.prognosisFields.get(3)}</td><td class="prognosisv"><a
                    href="${prognosis.betsUrl}">link</a></td></tr>
            <tr><td class="prognosisp">${language.prognosisFields.get(4)}</td><td
                    class="prognosisv">${prognosis.first} - ${prognosis.second}</td></tr>
            <tr><td class="prognosisp">${language.prognosisFields.get(5)}</td><td
                    class="prognosisv">${prognosis.firstPoints} : ${prognosis.secondPoints}</td>
            </tr>
            <tr><td class="prognosisp">${language.prognosisFields.get(6)}</td><td
                    class="prognosisv">${prognosis.firstBetsCoefficient} / ${prognosis.secondBetsCoefficient}</td>
            </tr>
            <g:if test="${!prognosis.isValid}">
                <tr><td class="prognosisp">${language.prognosisFields.get(7)}</td><td class="prognosisv">
                    <g:form controller="prognosis" method="POST">
                        <g:hiddenField name="id" value="${prognosis?.id}"/>
                        <g:actionSubmit class="button" action="edit"
                                        value="${language.editCommand}"/>
                        <g:actionSubmit class="button" action="delete"
                                        value="${language.deleteCommand}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                    </g:form>
                </td></tr>
            </g:if>
        </table>
    </g:each>
</div>
</body></html>