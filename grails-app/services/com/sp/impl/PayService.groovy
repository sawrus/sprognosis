package com.sp.impl

import com.sp.profiles.UserProfile
import org.apache.commons.logging.LogFactory

class PayService {
    def payPalProService
    EmailService emailService

    private static final log = LogFactory.getLog(this)


    static transactional = true

    public static boolean checkPreviousSell(UserProfile profile) {
        log.debug("checkPreviousSell.profile=" + profile)
        boolean result = false

        if (profile.payDate && profile.payProfile) {
            Date payDate = profile.payDate
            if (payDate.plus(profile.payProfile.period).before(new Date()))
                result = true
        }

        log.debug("result=" + result)
        return result
    }

    protected def buyPrognosis =
        { UserProfile profile, Prognosis prognosis ->
            log.debug("buyPrognosis.profile=" + profile + "; prognosis=" + prognosis)
            profile.addToPrognosisList(prognosis)
            String emailContent = """Hi, man!
            Here are the details of buy prognose:
            Profile: ${profile}
            Prognose: ${prognosis}"""
            emailService.sendEmail("Buy prognose", emailContent)
            saveInTransaction(profile)
        }

    public def monthlySubscription =
        { UserProfile profile ->
            log.debug("monthlySubscription.profile=" + profile)

            profile.payDate = new Date()

            String emailContent = """Hi, man!
            Here are the details of monthly subscription:
            User profile: ${profile}
            Pay profile: ${profile.payProfile}"""
            emailService.sendEmail("Monthly subscription", emailContent)
            saveInTransaction(profile)
        }

    protected def saveInTransaction =
        { UserProfile profile ->
            log.debug("saveInTransaction.profile=" + profile)
            Command.withTransaction() {
                if (!profile.save(flash: true)) {
                    profile.errors.each {
                        log.debug(it)
                        System.err.println(it)
                    }
                }
            }
        }
}
