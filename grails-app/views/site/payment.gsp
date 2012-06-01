<%@ page import="com.sp.enums.PaymentType; com.sp.enums.Language; com.sp.impl.Prognosis; com.sp.impl.Command; com.sp.site.Banner; com.sp.site.Image; com.sp.site.SiteController; com.sp.profiles.UserProfile; com.sp.auth.User; com.sp.profiles.PayProfile; com.sp.site.PostCategory; com.sp.site.Post; com.sp.site.Comment" contentType="text/html;charset=UTF-8" %>

<html lang="en">
<head>
    <meta name="layout" content="blog_main"/>
    <g:isLoggedIn>
        <g:set var="user"><g:loggedInUsername/></g:set>
        <g:set var="userProfile" value="${UserProfile.findByUser(User.findByUsername(user))}"/>
        <g:set var="language" value="${userProfile != null ? userProfile.language : (params.language ? Language.parseLanguageByName(params.language) : Language.ENGLISH)}"/>
    </g:isLoggedIn>
    <g:isNotLoggedIn>
        <g:set var="language" value="${params.language ? Language.parseLanguageByName(params.language) : Language.ENGLISH}"/>
    </g:isNotLoggedIn>
</head>

<body id="page1">
<g:if test="${postInstance != null}">
    <div class="grid_8">
        <h2 class="ident-bot-2">${postInstance?.title}</h2>
        <g:form method="post" controller="site">
            <g:hiddenField name="id" value="${paymentInformationInstance?.id}"/>
            <g:hiddenField name="version" value="${paymentInformationInstance?.version}"/>
            <table width="100%">
            <tr><td class="paymentp2">Payment Type*</td><td
                    class="paymentv">
            <g:select name="paymentType" from="${PaymentType?.values()}"
                      keys="${PaymentType?.values()*.name()}"
                      value="${paymentInformationInstance?.paymentType?.name()}"/></td>
            </tr>
            </table>
            <br/><h4 class="ident-bot-2">PayPal</h4>
            <table width="100%">
            <tr><td class="paymentp">PayPal Account*</td><td
                    class="paymentv"><g:textField name="PayPalAccount" size="50" value="${paymentInformationInstance?.PayPalAccount}"/></td>
            </tr>
            </table>
            <br/><h4 class="ident-bot-2">US Wire</h4>
            <table width="100%">
            <tr><td class="paymentp">Account Holder Name*</td><td
                    class="paymentv"><g:textField name="USWireAccountHolderName" size="50" value="${paymentInformationInstance?.USWireAccountHolderName}"/></td>
            </tr>
            <tr><td class="paymentp">Account Number</td><td
                    class="paymentv"><g:textField name="USWireAccountNumber" size="50" value="${paymentInformationInstance?.USWireAccountNumber}"/></td>
            </tr>
            <tr><td class="paymentp">Routing Number</td><td
                    class="paymentv"><g:textField name="USWireRoutingNumber" size="50" value="${paymentInformationInstance?.USWireRoutingNumber}"/></td>
            </tr>
            <tr><td class="paymentp">Bank Name</td><td
                    class="paymentv"><g:textField name="USWireBankName" size="50" value="${paymentInformationInstance?.USWireBankName}"/></td>
            </tr>
            <tr><td class="paymentp">Bank Address 1</td><td
                    class="paymentv"><g:textField name="USWireBankAddress1" size="50" value="${paymentInformationInstance?.USWireBankAddress1}"/></td>
            </tr>
            <tr><td class="paymentp">Bank Address 2</td><td
                class="paymentv"><g:textField name="USWireBankAddress1" size="50" value="${paymentInformationInstance?.USWireBankAddress2}"/></td>
            </tr>
            <tr><td class="paymentp">Bank ZIP/Postal Code</td><td
                    class="paymentv"><g:textField name="USWireBankZIPPostalCode" size="50" value="${paymentInformationInstance?.USWireBankZIPPostalCode}"/></td>
            </tr>
            <tr><td class="paymentp">Bank City</td><td
                    class="paymentv"><g:textField name="USWireBankCity" size="50" value="${paymentInformationInstance?.USWireBankCity}"/></td>
            </tr>
            <tr><td class="paymentp">Bank State</td><td
                    class="paymentv"><g:textField name="USWireBankState" size="50" value="${paymentInformationInstance?.USWireBankState}"/></td>
            </tr>
            </table>
            <br/><h4 class="ident-bot-2">International Wire</h4>
            <table width="100%">
            <tr><td class="paymentp">Account Holder Name*</td><td
                    class="paymentv"><g:textField name="IWireAccountHolderName" size="50" value="${paymentInformationInstance?.IWireAccountHolderName}"/></td>
            </tr>
            <tr><td class="paymentp">Account Number IBAN</td><td
                    class="paymentv"><g:textField name="IWireAccountNumberIBAN" size="50" value="${paymentInformationInstance?.IWireAccountNumberIBAN}"/></td>
            </tr>
            <tr><td class="paymentp">SWIFT Code</td><td
                    class="paymentv"><g:textField name="IWireSWIFTCode" size="50" value="${paymentInformationInstance?.IWireSWIFTCode}"/></td>
            </tr>
            <tr><td class="paymentp">Bank Name</td><td
                    class="paymentv"><g:textField name="IWireBankName" size="50" value="${paymentInformationInstance?.IWireBankName}"/></td>
            </tr>
            <tr><td class="paymentp">Bank Address1</td><td
                    class="paymentv"><g:textField name="IWireBankAddress1" size="50" value="${paymentInformationInstance?.IWireBankAddress1}"/></td>
            </tr>
            <tr><td class="paymentp">Bank Address2</td><td
                    class="paymentv"><g:textField name="IWireBankAddress2" size="50" value="${paymentInformationInstance?.IWireBankAddress2}"/></td>
            </tr>
            <tr><td class="paymentp">Bank ZIP/Postal Code</td><td
                    class="paymentv"><g:textField name="IWireBankZIPPostalCode" size="50" value="${paymentInformationInstance?.IWireBankZIPPostalCode}"/></td>
            </tr>
            <tr><td class="paymentp">Bank City</td><td
                    class="paymentv"><g:textField name="IWireBankCity" size="50" value="${paymentInformationInstance?.IWireBankCity}"/></td>
            </tr>
            <tr><td class="paymentp">Bank Prov Region</td><td
                    class="paymentv"><g:textField name="IWireBankProvRegion" size="50" value="${paymentInformationInstance?.IWireBankProvRegion}"/></td>
            </tr>
            <tr><td class="paymentp">Bank Country</td><td
                    class="paymentv"><g:textField name="IWireBankCountry" size="50" value="${paymentInformationInstance?.IWireBankCountry}"/></td>
            </tr>
            </table>
            <br/><h4 class="ident-bot-2">Beneficiary Information</h4>
            <table width="100%">
            <tr><td class="paymentp">BeneficiaryName*</td><td
                    class="paymentv"><g:textField name="BeneficiaryName" size="50" value="${paymentInformationInstance?.BeneficiaryName}"/></td>
            </tr>
            <tr><td class="paymentp">Address1</td><td
                    class="paymentv"><g:textField name="Address1" size="50" value="${paymentInformationInstance?.Address1}"/></td>
            </tr>
            <tr><td class="paymentp">Address2</td><td
                    class="paymentv"><g:textField name="Address2" size="50" value="${paymentInformationInstance?.Address2}"/></td>
            </tr>
            <tr><td class="paymentp">ZIPPostalCode</td><td
                    class="paymentv"><g:textField name="ZIPPostalCode" size="50" value="${paymentInformationInstance?.ZIPPostalCode}"/></td>
            </tr>
            <tr><td class="paymentp">City</td><td
                    class="paymentv"><g:textField name="City" size="50" value="${paymentInformationInstance?.City}"/></td>
            </tr>
            <tr><td class="paymentp">ProvRegion</td><td
                    class="paymentv"><g:textField name="ProvRegion" size="50" value="${paymentInformationInstance?.ProvRegion}"/></td>
            </tr>
            <tr><td class="paymentp">Country</td><td
                    class="paymentv"><g:textField name="Country" size="50" value="${paymentInformationInstance?.Country}"/></td>
            </tr>
            </table>
            <br/><g:actionSubmit class="button" action="updatePayment" value="${language.edit}"/>
        </g:form>
    </div>
</g:if>
</body></html>