package com.sp.impl

import com.sp.AbstractDomain

class Category extends AbstractDomain
{
    Category parent

    static constraints =
    {
        parent(nullable:true)
    }
}
