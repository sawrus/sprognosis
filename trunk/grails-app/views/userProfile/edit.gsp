<%@ page import="com.sp.enums.Language; com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

<html lang="en">
<head>
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
<div class="grid_8">
    <h2 class="ident-bot-2">Choose your profile below:</h2>
    <g:each in="${PayProfile.list()}" var="payProfile">
        <table width="100%">
            <tr><td class="nameProfileProperty">Name</td><td
                    class="valueProfileProperty">${payProfile.name}</td></tr>
            <tr><td class="nameProfileProperty">Period</td><td
                    class="valueProfileProperty">${payProfile.period} ${payProfile.periodType}</td></tr>
            <tr><td class="nameProfileProperty">Price</td><td
                    class="valueProfileProperty">${payProfile.price} ${payProfile.priceType}</td></tr>
            <tr><td class="nameProfileProperty">Description</td><td
                    class="valueProfileProperty">${payProfile.description}</td></tr>
            <tr><td class="nameProfileProperty">Action</td><td
                    class="valueProfileProperty">
                <paypal:button
                        itemName="${payProfile.name}"
                        itemNumber="${payProfile.id}"
                        buyerId="${userProfileInstance.id}"
                        amount="${(payProfile.price<=0?0.01:payProfile.price)}"
                        discountAmount="0"
                        transactionId="${params?.transactionId}"
                        returnAction="buy"
                        returnController="userProfile"
                        buttonSrc="https://www.paypal.com/en_US/i/btn/btn_subscribe_LG.gif"
                        buttonAlt="Subscribe to ${payProfile.name}"/>
            </td></tr>
        </table><br>
    </g:each>
</div>
</body></html>