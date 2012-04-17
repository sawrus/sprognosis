package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.profiles.PayProfile

@Secured(['ROLE_ADMIN'])
class PayProfileAdminController
{
    def scaffold = PayProfile

    def load = {
        String periodType = "days";
        String priceType = "evro";

        List<PayProfile> payProfiles = Arrays.asList(
            new PayProfile(period: 7,   price: 25.0,  periodType: periodType, priceType: priceType),
            new PayProfile(period: 7*2, price: 50.0,  periodType: periodType, priceType: priceType),
            new PayProfile(period: 7*3, price: 75.0,  periodType: periodType, priceType: priceType),
            new PayProfile(period: 7*4, price: 100.0, periodType: periodType, priceType: priceType),
            new PayProfile(period: 0,   price: 0.0,   periodType: periodType, priceType: priceType)
        )

        for (PayProfile profile: payProfiles)
        {
            if (!PayProfile.list().contains(profile))
            {
                profile.save(flush: true)
            }
        }

        redirect uri: '/'
    }
}
