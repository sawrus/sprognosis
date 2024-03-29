package com.sp.profiles

import com.sp.auth.User
import com.sp.impl.PayService
import com.sp.impl.Prognosis
import com.sp.enums.Language
import com.sp.site.Image

class UserProfile
{
    User user
    PayProfile payProfile
    Image userImage

    String address1=""
    String address2=""
    String zip_postal_code=""
    String city=""
    String state_province=""
    String country=""
    String telephone=""
    String twitter_name=""
    String facebook_profile=""
    String site_url=""

    static hasMany = [prognosisList: Prognosis]

    Date payDate

    Language language = Language.ENGLISH

    static constraints = {
        user(nullable: false)
        payDate(nullable: true)
        userImage(nullable: true)
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