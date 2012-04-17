package com.sp.site

import com.sp.enums.Language

class Banner {
    Image image
    String content
    boolean visible = false

    Language language = Language.ENGLISH

    static mapping = {
        content type: 'text'
    }

    static constraints = {
        content(maxSize:1000)
        image(nullable: true)
    }

    @Override
    public String toString() {
        return "Banner #" + image
    }


}
