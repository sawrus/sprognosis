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
            <g:if test="${postInstance == null && categoryInstance == null}">
                <!-- default content -------------------------------------------->
                <div class="grid_4">
                    <h2 class="ident-bot-2">WELCOME!</h2>

                    <p class="inner-ident-1 ident-bot-5">Error. Please contact with administration of this site</p>
                </div>
                <!-- default content -------------------------------------------->
            </g:if>
            <g:else>
                <g:if test="${postInstance != null}">
                    <div class="grid_8">

                        <!-- content-------------------------------------------->
                        <h2 class="ident-bot-2">${postInstance?.title}</h2>
                        <h4 class="ident-bot-3"><a href="#">${postInstance?.announcement}</a>
                        </h4>
                        <g:each in="${postInstance?.images}" var="image">
                            <div style="float:inherit;" id="gallery">
                                <a href="${image.webRootDir + File.separator + image.fileName}">
                                    ${image.toHtmlTagWithResize(300,300)}
                                </a>
                            </div>
                        </g:each>
                        ${postInstance?.content}
                    %{--<g:link controller="site" action="index" class="button" params="[post: postInstance?.id]">${language.readMore}</g:link>--}%
                        <g:if test="${postInstance?.allowComments}">
                            <g:isNotLoggedIn>
                                <div class="comment">
                                    <b>Please authorize your user to leave a comment</b>
                                </div>
                            </g:isNotLoggedIn>
                            <g:isLoggedIn>
                                <div class="confirm">
                                    Please, send your comment:
                                    <g:form controller="comment" action="save">
                                        <g:textArea name="content" rows="5" cols="80%"
                                                    class="comments">${commentInstance?.content}</g:textArea>
                                        <g:hiddenField name="id" value="${commentInstance?.id}"/>
                                        <g:hiddenField name="post" value="${postInstance?.id}"/>
                                        <g:submitButton name="create" class="button" value="CREATE"/>
                                    </g:form>
                                </div>
                            </g:isLoggedIn>
                            <br/>
                            <g:each in="${postInstance?.comments}" var="comment">
                                <g:if test="${comment?.visible}">
                                    <div class="comment">
                                        <h4>${comment.author?.userRealName} commented : (${comment?.dateCreated}):</h4>
                                        ${UserProfile.findByUser(comment.author)?.userImage?.toHtmlTagWithResize(50, 50)}
                                        ${comment?.content}
                                    </div>

                                    <div class="line-2 ident-bot-5"></div>
                                </g:if>
                            </g:each>
                        </g:if>
                    <!-- content-------------------------------------------->
                    </div>
                </g:if>
                <g:if test="${categoryInstance != null}">
                    <g:each in="${categoryInstance.posts}" var="post" status="i">
                        <g:if test="${i < 2}">
                            <div class="grid_4">
                                <h2 class="ident-bot-2">${post.name.toUpperCase()}</h2>
                                <h4 class="ident-bot-3">
                                    <a href="${g.createLink(controller: 'site', action: 'index', params: [post: post?.id])}#anchor">
                                        ${post.title}
                                    </a>
                                </h4>
                                <g:if test="${post?.images != null && !post?.images.isEmpty()}">
                                    <g:set var="image" value="${post.images.iterator().next()}"/>
                                    <div style="float:inherit;" id="gallery">
                                        <a href="${image.webRootDir + File.separator + image.fileName}">
                                            ${image.toHtmlTagWithResize(250, 250)}
                                        </a>
                                    </div>
                                </g:if>
                                ${post.announcement}
                                <a class="button" href="${g.createLink(controller: 'site', action: 'index', params: [post: post?.id])}#anchor">
                                    ${language.readMore}
                                </a>
                            </div>
                        </g:if>
                    </g:each>
                </g:if>
            </g:else>
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