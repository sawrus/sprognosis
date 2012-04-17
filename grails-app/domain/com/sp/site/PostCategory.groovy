package com.sp.site

import com.sp.AbstractDomain
import com.sp.auth.User

class PostCategory extends AbstractDomain{
    PostCategory parent
    User author
    boolean visible = false

    static hasMany = [posts: Post, children: PostCategory]
    static hasOne = [parent: PostCategory]
    static belongsTo = [PostCategory]

    static constraints = {
        parent(nullable: true)
    }

    Post firstPost(){
        return posts.iterator().next();
    }
}
