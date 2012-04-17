<%@ page import="com.sp.impl.*" %>
<html>
<head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>

    <style type="text/css" media="screen">

    #nav {
        margin-top: 20px;
        margin-left: 30px;
        width: 228px;
        float: left;

    }

    .homePagePanel * {
        margin: 0px;
    }

    .homePagePanel .panelBody ul {
        list-style-type: none;
        margin-bottom: 10px;
    }

    .homePagePanel .panelBody h1 {
        text-transform: uppercase;
        font-size: 1.1em;
        margin-bottom: 10px;
    }

    .homePagePanel .panelBody {
        background: #111;
        margin: 0px;
        padding: 15px;
        width: 300px;
    }

    .homePagePanel .panelBtm {
        background: url(images/leftnav_btm.png) no-repeat top;
        height: 20px;
        margin: 0px;
    }

    .homePagePanel .panelTop {
        background: url(images/leftnav_top.png) no-repeat top;
        height: 11px;
        margin: 0px;
    }

    h2 {
        margin-top: 15px;
        margin-bottom: 15px;
        font-size: 1.2em;
    }

    #pageBody {
        margin-left: 280px;
        margin-right: 20px;
    }
    </style>
</head>

<body>

<div id="nav">
    <div class="homePagePanel">
        <div class="panelTop"></div>

        <div class="panelBody">
            <g:isNotLoggedIn>
                <h1>Anonymous</h1>
                <ul>
                    <li><g:link action="index" controller="register">Register</g:link></li>
                </ul>
            </g:isNotLoggedIn>
            <g:ifAnyGranted role="ROLE_USER">
                <h1>User</h1>
                <ul>
                    <li><g:link action="profile" controller="userProfile">Show profile</g:link></li>
                    <li><g:link action="edit" controller="userProfile">Edit profile</g:link></li>
                    <li><g:link class="list" action="purchased" controller="prognosis">Purchased prognosis</g:link></li>
                    <li><g:link class="list" action="actual" controller="prognosis">Actual prognosis</g:link></li>
                    <li><g:link class="list" action="search" controller="prognosis">Search prognosis</g:link></li>
                </ul>
            </g:ifAnyGranted>
            <g:ifAnyGranted role="ROLE_PROGNOSTICATOR">
                <h1>Prognosticator</h1>
                <ul>
                    <li><g:link class="list" action="predicted" controller="prognosis">Predicted prognosis</g:link></li>
                    <li><g:link class="list" action="checked" controller="prognosis">Checked prognosis</g:link></li>
                    <li><g:link class="list" action="create" controller="prognosis">New prognosis</g:link></li>
                </ul>
            </g:ifAnyGranted>
            <g:ifAnyGranted role="ROLE_ADMIN">
            <h1>Console</h1>
            <ul>
                <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.shortName } }">
                    <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.shortName}</g:link></li>
                </g:each>
            </ul>
            <h1>Count</h1>
            <ul>
                <li>${Prognosis.count()} sports predictions</li>
                <li>${Command.count()} sport commands</li>
                <li>${Category.count()} sport categories</li>
            </ul>

                <h1>Application Status</h1>
                <ul>
                    <li>App version: <g:meta name="app.version"></g:meta></li>
                    <li>Grails version: <g:meta name="app.grails.version"></g:meta></li>
                    <li>Groovy version: ${org.codehaus.groovy.runtime.InvokerHelper.getVersion()}</li>
                    <li>JVM version: ${System.getProperty('java.version')}</li>
                    <li>Controllers: ${grailsApplication.controllerClasses.size()}</li>
                    <li>Domains: ${grailsApplication.domainClasses.size()}</li>
                    <li>Services: ${grailsApplication.serviceClasses.size()}</li>
                    <li>Tag Libraries: ${grailsApplication.tagLibClasses.size()}</li>
                </ul>

                <h1>Installed Plugins</h1>
                <ul>
                    <g:set var="pluginManager"
                           value="${applicationContext.getBean('pluginManager')}"></g:set>

                    <g:each var="plugin" in="${pluginManager.allPlugins}">
                        <li>${plugin.name} - ${plugin.version}</li>
                    </g:each>
                </ul>
            </g:ifAnyGranted>
        </div>

        <div class="panelBtm"></div>
    </div>
</div>

</body>
</html>