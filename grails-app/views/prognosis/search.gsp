<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Search prognosis</title>

    <g:javascript src="jquery.js"/>
    <g:javascript>
        jQuery.noConflict();
    </g:javascript>
    <g:javascript src="jquery-jtemplates.js"/>
    <g:javascript library="prototype"/>
    <resource:autoComplete skin="default"/>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
</div>

<div class="body">
    <h1>Search prognosis</h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:formRemote name="searchFriendsForm" url="[controller:'prognosis',action:'search']"
                  update="resultDiv"
                  onSuccess="showResult(e)" onFailure="showError()">
        <div class="dialog">
            <label for="category">Category</label>
            <richui:autoComplete name="category" action="${createLinkTo('dir': 'category/searchAJAX')}"/>
            <span class="searchButton"><input type="submit" value="Search"/></span>
        </div>
    </g:formRemote>
    <div id="resultDiv"></div>
</div>
</body>
</html>
