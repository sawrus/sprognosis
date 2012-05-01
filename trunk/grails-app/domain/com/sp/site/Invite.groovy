package com.sp.site

class Invite {
    String key
    Boolean used = false

    private static final String SOURCECHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

    static constraints = {
    }

    public static Integer COUNT_INVITES = 3

    public static String generateKey()
    {
        // Generate and remember the Source Character string (6 characters)
        int l = SOURCECHARS.length()
        StringBuilder b = new StringBuilder()
        6.times {
            int r = (int)(Math.random() * l)
            b.append(SOURCECHARS.charAt(r))
        }

        Invite invite = new Invite()
        def KEY = b.toString()

        invite.key = KEY

        invite.save(flush: true)

        return KEY
    }
}
