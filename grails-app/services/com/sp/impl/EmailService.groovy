package com.sp.impl

import org.grails.mail.MailService
import org.apache.commons.logging.LogFactory

class EmailService {

    static transactional = true

    MailService mailService

    public static final String DEFAULT_EMAIL = "101bettingtips@gmail.com"
    public static final String DEFAULT_SUBJECT = "[101bettingtips]: "
    private static final log = LogFactory.getLog(this);


    def sendEmail(String emailSubject, String emailBody) {
        try {
            mailService.sendMail {
                to DEFAULT_EMAIL
                subject DEFAULT_SUBJECT+ emailSubject
                body emailBody
            }
        } catch (Exception e) {
            log.debug("sendEmail:"+e)
        }
    }
}
