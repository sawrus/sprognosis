package com.sp

import com.sp.enums.Language

abstract class AbstractDomain
{
    String name
	String description

    Date dateCreated
    Date lastUpdated

    Language language = Language.ENGLISH;

    @Override
    String toString()
    {
        "${name}"
    }
	
	static constraints = 
	{
		name(maxSize:100)
		description(maxSize:1000)
	}
}
