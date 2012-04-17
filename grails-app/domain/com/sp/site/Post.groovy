package com.sp.site

class Post extends Content {
    String title
    String announcement
    PostCategory category

    static constraints = {
        announcement(nullable: true)
        content(nullable: true)
        announcement(size:0..2147483646)
        content(size:0..2147483646)
    }

    static mapping = {
        announcement type: 'text'
        content type: 'text'
    }


    boolean allowComments = true
    boolean RSSVisible = true
    boolean TwitterVisible = true
    boolean SocialVisible = true
    boolean MainPageVisible = true
    boolean CategoryVisible = true

    static hasMany = [comments: Comment, tags: Tag, images: Image]
}
