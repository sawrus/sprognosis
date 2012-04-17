package com.sp.auth

/**
 * Authority domain class.
 */
class Role {

	static hasMany = [people: User]

	/** description */
	String description
	/** ROLE String */
	String authority

	static constraints = {
		authority(blank: false, unique: true)
		description()
	}
    
    public static final transient Map<String,String> ROLES=new HashMap<String,String>();
    {
        ROLES.put("ROLE_ADMIN","Administrator");
        ROLES.put("ROLE_USER","User");
        ROLES.put("ROLE_PROGNOSTICATOR","Handicapper");
    }

    public String toString ( )
    {
        return ROLES.get(authority)
    }

    static final transient ROLE_ADMIN = new Role(authority: "ROLE_ADMIN", description: "Administrator")
    static final transient ROLE_USER = new Role(authority: "ROLE_USER", description: "User")
    static final transient ROLE_PROGNOSTICATOR = new Role(authority: "ROLE_PROGNOSTICATOR", description: "Handicapper")

    public static def getPublicRoles = {
        List<Role> roles = new ArrayList<Role>()
        for (Role role: Role.list())
        {
            if (!"ROLE_ADMIN".equals(role.authority))
            {
                roles.add(role)
            }
        }
        return roles;
    }
}