package com.sp.profiles

import com.sp.auth.User
import com.sp.impl.PayService
import com.sp.impl.Prognosis
import com.sp.enums.Language

class UserProfile
{
    User user
    PayProfile payProfile

    static hasMany = [prognosisList: Prognosis]

    Date payDate

    Language language = Language.ENGLISH

    static constraints = {
        user(nullable: false)
        payDate(nullable: true)
    }

    @Override
    public String toString()
    {
        return String.valueOf(user);
    }
	
	public static boolean checkPrognosisOnPaid(BigInteger userId, Prognosis prognosisInstance)
	{
		boolean result

		User  user = User.findById(userId.toLong())
		UserProfile profile = UserProfile.findByUser(user)

        if (!"Default".equals(profile.payProfile.name))
            result = PayService.checkPreviousSell(profile)
        else
            result = profile.prognosisList.contains(prognosisInstance)

		return result
	}


}