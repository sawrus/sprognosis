package com.sp.impl

import com.sp.auth.User
import com.sp.auth.Role

class UserService
{
    def authenticateService

    protected BigInteger getUserId()
    {
        BigInteger userId = BigInteger.ZERO
        if (authenticateService.isLoggedIn())
        {
            userId = authenticateService.userDomain().id
        }
        return userId
    }

    public User getUser()
    {
        return User.findById(getUserId())
    }

    public def hasPrognosticator =
    {
        isUserInRole(Role.findByAuthority(Role.ROLE_PROGNOSTICATOR.authority))
    }

    public def hasUser =
    {
        isUserInRole(Role.findByAuthority(Role.ROLE_USER.authority))
    }

	public def hasAdmin =
    {
        isUserInRole(Role.findByAuthority(Role.ROLE_ADMIN.authority))
    }

    private boolean isUserInRole(Role role)
    {
        boolean result = false
        if (authenticateService.isLoggedIn())
        {
            result = User.findById(getUserId()).authorities.contains(role)
        }
        return result
    }
}
