package com.sp.site

import com.sp.AbstractDomain
import com.sp.auth.User

abstract class Content extends AbstractDomain {
    String content
    User author
    boolean visible = false

    static constraints = {
        content(blank: false)
    }

    static mapping = {
        content type: 'text'
    }
}
