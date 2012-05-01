<%@ page import="org.apache.commons.lang.StringUtils; com.sp.enums.Language; com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:700italic,700,600' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'reset.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'grid.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'prettyPhoto.css')}"/>
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.lightbox-0.5.css')}"/>

    <g:javascript src="jquery-1.7.1.min.js"/>
    <g:javascript src="jquery.prettyPhoto.js"/>
    <g:javascript src="jquery.easing.1.3.js"/>
    <g:javascript src="jquery.color.js"/>
    <g:javascript src="FF-cash.js"/>
    <g:javascript src="superfish.js"/>
    <g:javascript src="hover-image.js"/>
    <g:javascript src="slider.js"/>
    <g:javascript src="script.js"/>
    <g:javascript src="tms-0.3.js"/>
    <g:javascript src="tms_presets.js"/>
    <g:javascript src="jquery.lightbox-0.5.js"/>

    <script type="text/javascript">
        $(function() {
            $('#gallery a').lightBox({fixedNavigation:true});
        });
    </script>


    %{--<resource:richTextEditor />--}%
    <!--[if lt IE 8]>
    <div style='clear: both; text-align: center; position: relative;'>
        <a href="http://windows.microsoft.com/en-US/internet-explorer/products/ie/home?ocid=ie6_countdown_bannercode">
            <img src="http://storage.ie6countdown.com/assets/100/images/banners/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." />
        </a>
    </div>
            <![endif]-->
    <!--[if lt IE 9]>
    <script type="text/javascript" src="js/html5.js"></script>
    <link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" />
        <![endif]-->


    <g:isLoggedIn>
        <g:set var="user"><g:loggedInUsername/></g:set>
        <g:set var="userProfile" value="${UserProfile.findByUser(User.findByUsername(user))}"/>
        <g:set var="language" value="${userProfile != null ? userProfile.language : (params.language ? Language.valueOf(Language.class, params.language) : Language.ENGLISH)}"/>
    </g:isLoggedIn>
    <g:isNotLoggedIn>
        <g:set var="language" value="${params.language ? Language.valueOf(Language.class, params.language) : Language.ENGLISH}"/>
    </g:isNotLoggedIn>
    <title>${language.siteName} #${postInstance?.title}</title>

    <g:layoutHead/>

</head>
<body id="page1">
<div class="main">
    <!-- header -->
    <header>
        <div class="wrapper">
            <div class="fl-l ident-top-1 ident-bot-18">
                %{--<h1 class="fl-l"><a href="#">sPrognosis</a></h1>--}%
                <div class="slogan fl-l">${language.siteName}</div>
            </div>
            <div class="block-2">
                <div class="fl-l"><a href="#"><img src="images/icon-1.png" alt="" height="29" width="29"></a></div>
                <div class="extra-wrap block-1">
                    <p>Join us on <a href="#">Facebook</a> and keep the news</p>
                </div>
                <div class="extra-wrap block-1">
                    <p>Manage your profile <g:isLoggedIn>(<g:loggedInUsername/>)</g:isLoggedIn>:
                    <g:isNotLoggedIn>
                        <g:link controller="login">Login</g:link> |
                        <g:link controller="site" action="register">Register</g:link>
                    </g:isNotLoggedIn>
                    <g:isLoggedIn>
                        <g:link controller="logout" action="index">Logout</g:link>
                    </g:isLoggedIn>
                    </p>

                    <g:form controller="site" action="language">
                        <g:select name="language" from="${Language?.values()}"
                            keys="${Language?.values()*.name()}" value="${language.name()}" onchange="submit()"
                    />
                    </g:form>
                </div>
            </div>
        </div>
    </header></div>
<div class="main shadow extra-10">
    <!-- menu -->
    <nav>
        <ul class="sf-menu sf-js-enabled sf-shadow">
            <li class="active">
                <a href="${g.createLink(controller:'site',action:'index')}#anchor">
                ${language.homeName}
                </a>
            </li>
            <g:each in="${PostCategory.findAllByLanguage(language)}" var="category">
                <g:if test="${category?.visible}">
                    <g:set var="posts" value="${Post.findAllByCategoryAndLanguage(category, language)}"/>
                    <g:if test="${posts.size() == 1}">
                        <li>
                            <a href="${g.createLink(controller:'site',action:'index',params: [post: category.firstPost()?.id])}#anchor">
                                ${category?.name}
                            </a>
                    </g:if>
                    <g:else>
                        <li><a href="${g.createLink(controller: 'site', action: 'index', params: [category: category?.id])}#anchor">
                        ${category?.name}
                        </a>
                        <ul style="display: none; visibility: hidden">
                            <g:each in="${posts}" var="post">
                                <li>
                                    <g:if test="${post.name=='As User'}">
                                        <a href="${g.createLink(controller:'site',action:'prognosis')}">
                                            ${post?.name}
                                        </a>
                                    </g:if>
                                    <g:else>
                                        <a href="${g.createLink(controller:'site',action:'index',params: [post: post?.id])}#anchor">
                                            ${post?.name}
                                        </a>
                                    </g:else>
                                </li>
                            </g:each>
                        </ul>
                    </g:else>
                </g:if>
                </li>
            </g:each>
        </ul>
        <div class="clear"></div>
    </nav><!-- end menu -->
<!-- end header -->
    <div class="slider-holder">
        <div class="slider">
            <ul class="items">
                <g:each in="${Banner.findAllByVisibleAndLanguage(true, language)}" var="banner" status="b">
                    <li>
                    <g:if test="${banner?.image?.visible}">
                        ${banner?.image.toHtmlTag()}
                    </g:if>
                        ${banner?.content}
                    </li>
                </g:each>
            </ul>
        </div>
    </div><!-- end slider -->
<g:layoutBody/>
<!-- footer -->
    <footer>
        <div class="container_12">
            <div class="wrapper">
                <div class="grid_12">
                    <div class="line-2 ident-bot-3"></div>
                    <div class="fl-l">
                        <ul class="list-1">
                            <g:each in="${Post.findAllByMainPageVisibleAndLanguage(true, language)}" var="post" status="i">
                                <g:if test="${i == 0}">
                                    <li class="active-2">
                                        <a href="${g.createLink(controller:'site',action:'index',params: [post: post?.id])}#anchor">
                                            ${post?.name}
                                        </a>
                                    </li>
                                </g:if>
                                <g:else>
                                    <li>
                                        <a href="${g.createLink(controller:'site',action:'index',params: [post: post?.id])}#anchor">
                                            ${post?.name}
                                        </a>
                                    </li>
                                </g:else>
                            </g:each>
                        </ul>
                    </div>
                    <div class="fl-r policy">${language.siteName} © ${java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)}</div>
                    <div class="clear"></div>
                    <div class="fl-r"><!--{%FOOTER_LINK} --></div>
                </div>
            </div>
        </div>
    </footer><!-- end footer -->
</div>

</body></html>