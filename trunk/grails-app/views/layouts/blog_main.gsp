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
    <!--[if lt IE 8]>
    <div style='clear: both; text-align: center; position: relative;'>
    <a href="http://windows.microsoft.com/en-US/internet-explorer/products/ie/home?ocid=ie6_countdown_bannercode">
    <img src="http://storage.ie6countdown.com/assets/100/images/banners/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." />
    </a>
    </div><![endif]-->
    <!--[if lt IE 9]>
    <script type="text/javascript" src="js/html5.js"></script>
    <link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <g:layoutHead/>
    <g:isLoggedIn>
    <g:set var="user"><g:loggedInUsername/></g:set>
    <g:set var="userProfile" value="${UserProfile.findByUser(User.findByUsername(user))}"/>
    <g:set var="language" value="${userProfile != null ? userProfile.language : (params.language ? Language.parseLanguageByName(params.language) : Language.ENGLISH)}"/>
    </g:isLoggedIn>
    <g:isNotLoggedIn><g:set var="language" value="${params.language ? Language.parseLanguageByName(params.language) : Language.ENGLISH}"/>
    </g:isNotLoggedIn>
    <title>${language.siteName} #${postInstance?.title}</title>
</head>
<body id="page1">
<div class="main">
    <header>
        <div class="wrapper">
            <div class="fl-l ident-top-1 ident-bot-18"><div class="slogan fl-l">${language.siteName}</div></div>
        </div>
    </header>
</div>
<div class="main shadow extra-10">
    <nav>
        <ul class="sf-menu sf-js-enabled sf-shadow">
            <g:ifAnyGranted role="ROLE_ADMIN"><li class="active"><a href="#">Manage</a>
                <ul style="display: none; visibility: hidden">
                    <li><g:link controller="userProfileAdmin">User profiles</g:link></li>
                    <li><g:link controller="postCategoryAdmin">Post categories</g:link></li>
                    <li><g:link controller="post">Posts</g:link></li>
                    <li><g:link controller="commentAdmin">Comments</g:link></li>
                    <li><g:link controller="tagAdmin">Tags</g:link></li>
                    <li><g:link controller="bannerAdmin">Banners</g:link></li>
                    <li><g:link controller="voteAdmin">Votes</g:link></li>
                    <li><g:link controller="image">Images</g:link></li>
                    <li><g:link controller="categoryAdmin">Sport categories</g:link></li>
                    <li><g:link controller="commandAdmin">Sport commands</g:link></li>
                    <li><g:link controller="prognosis">Sport prognosis</g:link></li>
                </ul>
            </li>
            </g:ifAnyGranted><g:ifNotGranted role="ROLE_ADMIN">
            <li class="active"><a href="${g.createLink(controller: 'site', action: 'index')}#p">${language.homeName}</a></li>
            </g:ifNotGranted>
            <g:each in="${PostCategory.findAllByLanguage(language)}" var="category"><g:if test="${category?.visible}"><g:set var="posts" value="${Post.findAllByCategoryAndLanguage(category, language)}"/><g:if test="${posts.size() == 1}">
            <li><a href="/s/${category.firstPost().name.replaceAll(" ","_").toLowerCase()}#p">${category?.name}</a></g:if><g:else>
            <li><a href="/s/${category.name.replaceAll(" ","_").toLowerCase()}#p">${category?.name}</a>
                <ul style="display: none; visibility: hidden">
                    <g:each in="${posts}" var="post">
                    <li><a href="/s/${post.name.replaceAll(" ","_").toLowerCase()}#p">${post?.title}</a></li>
                    </g:each>
                    <g:if test="${category.name=='Participate'}">
                    <g:isNotLoggedIn>
                    <li><g:link controller="login">Login</g:link></li>
                    <li><g:link controller="site" action="register">Register</g:link></li>
                    </g:isNotLoggedIn>
                    <g:isLoggedIn>
                    <li><g:link controller="logout" action="index">Logout</g:link></li>
                    </g:isLoggedIn>
                    </g:if>
                </ul>
            </g:else></g:if></li></g:each>
        </ul>

        <div class="clear"></div>
    </nav>

    <div class="slider-holder">
        <div class="slider">
            <ul class="items"><g:each in="${Banner.findAllByVisibleAndLanguage(true, language)}" var="banner" status="b">
                <li><g:if test="${banner?.image?.visible}">${banner?.image.toHtmlTag()}</g:if>${banner?.content}</li></g:each>
            </ul>
        </div>
    </div>
    <section id="content">
        <div class="container_12">
            <div class="wrapper">
                <a href="#p" id="p"/>
                <g:layoutBody/>
                <div class="grid_4">
                    <div class="block-3 ident-top-2"><g:ifAnyGranted role="ROLE_USER">
                        <h3 class="ident-bot-2">${language.profile}</h3><g:if test="${userProfile?.userImage}">
                        <div class="ident-bot-6">${userProfile?.userImage?.toHtmlTagWithResize(150, 150)}</div>
                        <div class="line ident-bot-5"></div></g:if><g:set var="payProfile"
                           value="${userProfile?.payProfile ? userProfile.payProfile : PayProfile.findByPeriod(0)}"/>
                        <div class="ident-bot-6">
                            <table>
                                <tr><td class="profilep">${language.payProfile.get(0)}</td><td
                                        class="profilev">${payProfile?.name}</td></tr>
                                <tr><td class="profilep">${language.payProfile.get(1)}</td><td
                                        class="profilev">${payProfile.price}${payProfile.priceType}</td>
                                </tr>
                                <tr><td class="profilep">${language.payProfile.get(2)}</td><td
                                        class="profilev">${payProfile.period}${payProfile.periodType}</td>
                                </tr>
                                <tr><td class="profilep">${language.payProfile.get(3)}</td><td
                                        class="profilev">${payProfile.description}</td></tr>
                            </table>
                            <div class="clear"></div>
                        </div>
                        <div class="line ident-bot-5"></div></g:ifAnyGranted>
                        <div class="ident-bot-4">
                            <table>
                                <tr><td class="spanelp">${language.stateProfile.get(0)}</td><td
                                        class="spanelv">${Command.count()}</td></tr>
                                <tr><td class="spanelp">${language.stateProfile.get(1)}</td><td
                                        class="spanelv">${com.sp.impl.Category.count()}</td></tr>
                                <tr><td class="spanelp">${language.stateProfile.get(2)}</td><td
                                        class="spanelv">${Prognosis.count()}</td></tr>
                                <tr><td class="spanelp">${language.stateProfile.get(3)}</td><td
                                        class="spanelv">${Post.count()}</td></tr>
                                <tr><td class="spanelp">${language.stateProfile.get(4)}</td><td
                                        class="spanelv">${User.count()}</td></tr>
                            </table>
                            <div class="clear"></div>
                        </div>
                        <g:isLoggedIn><g:ifNotGranted role="ROLE_ADMIN">
                        <a href="${g.createLink(controller: 'userProfile', action: 'profile')}#p" class="button">${language.edit}</a>
                        </g:ifNotGranted></g:isLoggedIn>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <footer>
        <div class="container_12">
            <div class="wrapper">
                <div class="grid_12">
                    <div class="line-2 ident-bot-3"></div>
                    <div class="fl-l">
                        <ul class="list-1">
                            <g:each in="${Post.findAllByMainPageVisibleAndLanguage(true, language)}" var="post"
                                    status="i"><g:if test="${i == 0}">
                            <li class="active-2"><a href="/s/${post.name.replaceAll(" ","_").toLowerCase()}#p">${post?.title}</a></li></g:if><g:else>
                            <li><a href="/s/${post.name.replaceAll(" ","_").toLowerCase()}#p">${post?.title}</a></li></g:else></g:each>
                        </ul>
                    </div>
                    <div class="fl-r policy">${language.siteName} © ${java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)}</div>
                    <div class="clear"></div>
                    <div class="fl-r"></div>
                </div>
            </div>
        </div>
    </footer>
</div>
</body></html>