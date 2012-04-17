package com.sp.site

class Comment extends Content {
    static belongsTo = [post: Post, comment:Comment]
    static hasMany = [comments : Comment]

    static constraints = {
        content(size:0..2147483646)
    }

    static mapping = {
        content type: 'text'
    }
}
