package com.sp.site

class Invite {
    String invite_key
    Boolean invite_used = false

    private static final String SOURCECHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    private static Integer KEY_LENGTH = 10
    private static Integer COUNT_INVITES = 10

    public static String generateKey()
    {
        // Generate and remember the Source Character string (6 characters)
        int l = SOURCECHARS.length()
        StringBuilder b = new StringBuilder()
        KEY_LENGTH.times {
            int r = (int)(Math.random() * l)
            b.append(SOURCECHARS.charAt(r))
        }

        Invite invite = new Invite()
        def KEY = b.toString()

        invite.invite_key = KEY

        invite.save(flush: true)

        return KEY
    }

    static constraints = {
    }
}
