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
    <title>101 Betting Tips #</title>
</head>

<body id="page1">
<div class="main">
    <header>
        <div class="wrapper">
            <div class="fl-l ident-top-1 ident-bot-18"><div class="slogan fl-l">101 Betting Tips</div></div>
        </div>
    </header>
</div>

<div class="main shadow extra-10">
    <nav>
        <a id="m"/>
        <ul class="sf-menu sf-js-enabled sf-shadow">
            <li class="active"><a href="/#p">Home</a></li>
            <li><a href="/s/contact_us#p">Contact us</a></li>
        </ul>

        <div class="clear"></div>
    </nav>
    <section id="content">
        <div class="container_12">
            <div class="wrapper">
                <a id="p"/>

                <div class="grid_12">
                    <h2 class="ident-bot-2">Caused by the service is temporarily unavailable</h2>

                <p class="inner-ident-1 ident-bot-4">
                    <strong>1. Describe all the actions step by step</strong><br/>
                    <strong>2. Gather information about the error</strong><br/>
                    <strong>3. Send your report to the postal address: <b>101bettingtips@gmail.com</b> given above</strong><br/>
                    <strong>4. Or go to "Contact Us" and leave it a comment on your error</strong><br/>
                    <strong>5. Attach to your application all the text, which is described below</strong><br/>
                    <g:if test="${exception}">
                        <div>
                        <strong>Error ${request.'javax.servlet.error.status_code'}:</strong> ${request.'javax.servlet.error.message'.encodeAsHTML()}<br/>
                        <strong>Servlet:</strong> ${request.'javax.servlet.error.servlet_name'}<br/>
                        <strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
                        <strong>Exception Message:</strong> ${exception.message?.encodeAsHTML()} <br/>
                        <strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()} <br/>
                        <strong>Class:</strong> ${exception.className} <br/>
                        <strong>At Line:</strong> [${exception.lineNumber}] <br/>
                        <strong>Code Snippet:</strong><br/>
                        <g:each var="cs" in="${exception.codeSnippet}">
                            ${cs?.encodeAsHTML()}<br/>
                        </g:each>
                        <pre><g:each in="${exception.stackTraceLines}">${it.encodeAsHTML()}<br/></g:each></pre>
                        </div>
                    </g:if>
                    <strong>6. Sorry for the inconvenience</strong><br/>
                </p>
                </div>
            </div>
        </div>
    </section>
</div>
</body></html>