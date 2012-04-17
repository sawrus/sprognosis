security {

    // see DefaultSecurityConfig.groovy for all settable/overridable properties

    active = true

    useRequestMapDomainClass = false
    useControllerAnnotations = true

    loginUserDomainClass = "com.sp.auth.User"
    authorityDomainClass = "com.sp.auth.Role"
    requestMapClass = "com.sp.auth.RequestMap"

//    controllerAnnotationStaticRules = [
//        '/paypal/buy/**': ['ROLE_USER']
//    ]
}
