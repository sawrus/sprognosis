import org.apache.log4j.RollingFileAppender

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [html: ['text/html', 'application/xhtml+xml'],
        xml: ['text/xml', 'application/xml'],
        text: 'text/plain',
        js: 'text/javascript',
        rss: 'application/rss+xml',
        atom: 'application/atom+xml',
        css: 'text/css',
        csv: 'text/csv',
        all: '*/*',
        json: ['application/json', 'text/json'],
        form: 'application/x-www-form-urlencoded',
        multipartForm: 'multipart/form-data'
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// Application context

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://101tipsbetting.com"
        grails.paypal.server = "https://www.paypal.com/cgi-bin/webscr"
        grails.paypal.email = "101bettingtips@gmail.com"
    }
    development {
        grails.serverURL = "http://localhost"
        grails.paypal.server = "https://www.sandbox.paypal.com/cgi-bin/webscr"
        grails.paypal.email = "101bettingtips@gmail.com"
    }
    test {
        grails.serverURL = "http://localhost"
    }

}

// Logging configuration
log4j = {
    appenders {
        appender new RollingFileAppender(name:"application", layout:pattern(conversionPattern: "%d{[ dd.MM.yy HH:mm:ss.SSS]} %-5p %c %x - %m%n"), file:"logs/application.log")
        appender new RollingFileAppender(name:"project", layout:pattern(conversionPattern: "%d{[ dd.MM.yy HH:mm:ss.SSS]} %-5p %c %x - %m%n"), file:"logs/project.log")
        appender new RollingFileAppender(name:"stacktrace", layout:pattern(conversionPattern: "%d{[ dd.MM.yy HH:mm:ss.SSS]} %-5p %c %x - %m%n"), file:"logs/stacktrace.log")
    }

    debug   'project': ['grails.app.controller.com.sp','grails.app.domain.com.sp','grails.app.service.com.sp'], additivity: false

    warn    'application':   ['org.codehaus.groovy.grails.web.servlet',
            'org.codehaus.groovy.grails.web.pages',
            'org.codehaus.groovy.grails.web.sitemesh',
            'org.codehaus.groovy.grails.web.mapping.filter',
            'org.codehaus.groovy.grails.web.mapping',
            'org.codehaus.groovy.grails.commons',
            'org.codehaus.groovy.grails.plugins',
            'org.apache.shiro']

    info    'application':   [
            'grails.app.controller',
            'grails.app.domain',
            'grails.app.service',
            'grails.app.realm']
}

grails {
    mail {
        host = "smtp.gmail.com"
        port = 465
        username = "101bettingtips@gmail.com"
        password = "YMPYWrC6X8wAzQRbBApW"
        props = ["mail.smtp.auth":"true",
                "mail.smtp.socketFactory.port":"465",
                "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                "mail.smtp.socketFactory.fallback":"false"]
    }
}
