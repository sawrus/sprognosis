<%@ page import="com.sp.auth.Role; com.sp.enums.Language; com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

<head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.autocomplete.css')}" />
    <g:javascript library="prototype"/>

    <title>Register</title>
    <style type='text/css' media='screen'>
    #login {
        margin:15px 0px; padding:0px;
        text-align:center;
    }
    #login .inner {
        width:340px;
        margin:0px auto;
        text-align:left;
        padding:10px;
        border-top:1px dashed #499ede;
        border-bottom:1px dashed #499ede;
        background-color:#EEF;
    }
    #login .inner .fheader {
        padding:4px;margin:3px 0px 3px 0;color:#2e3741;font-size:14px;font-weight:bold;
    }
    #login .inner .cssform p {
        clear: left;
        margin: 0;
        padding: 5px 0 8px 0;
        padding-left: 105px;
        border-top: 1px dashed gray;
        margin-bottom: 10px;
        height: 1%;
    }
    #login .inner .cssform input[type='text'] {
        width: 120px;
    }
    #login .inner .cssform label {
        font-weight: bold;
        float: left;
        margin-left: -105px;
        width: 100px;
    }
    #login .inner .login_message {color:red;}
    #login .inner .text_ {width:120px;}
    #login .inner .chk {height:12px;}
    </style>
</head>

<body>
<div id='login'>
    <div class='inner'>
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${person}">
            <div class="errors">
                <g:renderErrors bean="${person}" as="list"/>
            </div>
        </g:hasErrors>

        <div class='fheader'>Please Register..</div>
        <table>
            %{--<g:form action="save">--}%
            <g:uploadForm action="save" method="post">
                <tr>
                    <td><label for='username'>Login Name:</label></td>
                    <td><input type="text" name='username' value="${person?.username?.encodeAsHTML()}"/></td>
                </tr>

                <tr>
                    <td><label for='userRealName'>Full Name:</label></td>
                    <td><input type="text" name='userRealName' value="${person?.userRealName?.encodeAsHTML()}"/></td>
                </tr>

                <tr>
                    <td><label for='passwd'>Password:</label></td>
                    <td><input type="password" name='passwd' value="${person?.passwd?.encodeAsHTML()}"/></td>
                </tr>

                <tr>
                    <td><label for='enabled'>Confirm Password:</label></td>
                    <td><input type="password" name='repasswd' value="${person?.passwd?.encodeAsHTML()}"/></td>
                </tr>

                <tr>
                    <td><label for='email'>Email:</label></td>
                    <td><input type="text" name='email' value="${person?.email?.encodeAsHTML()}"/></td>
                </tr>

                <tr>
                    <td><label for='code'>Enter Code: </label></td>
                    <td>
                        <input type="text" name="captcha" size="8"/>
                        <img src="${createLink(controller:'captcha', action:'index')}" align="absmiddle"/>
                    </td>
                </tr>

                <tr>
                    <td><label for='code'>Enter Invite: </label></td>
                    <td>
                        <input type="password" name='invite'/>
                    </td>
                </tr>

                <tr>
                    <td><label for='code'>Role: </label></td>
                    <td>
                        <select name="role" id="role" >
                            <option value="${Role.ROLE_USER.authority}" >User</option>
                            <option value="${Role.ROLE_PROGNOSTICATOR.authority}" >Handicapper</option>
                        </select>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">Image: </td>
                    <td valign="top" class="value"><input type="file" id="site_image" name="site_image"/></td>
                </tr>

                <tr>
                    <td><g:submitButton name="create" class="button2" value="Register"/></td>
                </tr>
            %{--</g:form>--}%
            </g:uploadForm>
        </table>
    </div>
</div>
<script type='text/javascript'>
    <!--
    (function(){
        document.forms['loginForm'].elements['username'].focus();
    })();
    // -->
</script>
</body></html>