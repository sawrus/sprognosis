package com.sp.profiles

import com.sp.AbstractDomain

class PayProfile extends AbstractDomain
{
    Integer period
    Double price
    String periodType
    String priceType

    Boolean isActive = Boolean.TRUE

    static constraints = {
        period(blank: false)
        price(blank: false)
        periodType(blank: false)
        priceType(blank: false)
    }
}
