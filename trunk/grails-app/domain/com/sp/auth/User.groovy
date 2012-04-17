package com.sp.auth

import com.sp.enums.Language

/**
 * User domain class.
 */
class User {
	static transients = ['pass']
	static hasMany = [authorities: Role]
	static belongsTo = Role

	/** Username */
	String username
	/** User Real Name*/
	String userRealName
	/** MD5 Password */
	String passwd
	/** enabled */
	boolean enabled

	String email
	boolean emailShow

	/** description */
	String description = ''

	/** plain password to create a MD5 password */
	String pass = '[secret]'

	static constraints = {
		username(blank: false, unique: true, length: 6..18)
		userRealName(blank: false, length: 3..18/*, validator: {val, obj->
            if (val.equals(obj.username)) return ['default.invalid.range.message']
        }*/)
		passwd(blank: false, length: 6..18)
		enabled()
	}

    @Override
    String toString()
    {
        "${username}"
    }
}

