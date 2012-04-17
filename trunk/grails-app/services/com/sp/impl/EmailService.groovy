package com.sp.impl

import org.grails.mail.MailService

class EmailService {

    static transactional = true

    MailService mailService

    public static final String DEFAULT_EMAIL = "sawrus@gmail.com"
    public static final String DEFAULT_SUBJECT = "[sPrognosis]: "

    def sendEmail(String emailSubject, String emailBody) {
        mailService.sendMail {
            to DEFAULT_EMAIL
            subject DEFAULT_SUBJECT+ emailSubject
            body emailBody
        }
    }
}
