package com.sp.impl

import com.sp.AbstractDomain
import grails.plugins.countries.Country

class Command extends AbstractDomain
{
    Category category
    Country country

    static constraints =
    {
        category(nullable:true)
        country(nullable:true)
    }

    @Override
    boolean equals(o)
    {
        if (this.is(o)) return true;
        if (!(o instanceof Command)) return false;

        Command command = (Command) o;

        if (!category.equals(command.category)) return false;
        if (!country.equals(command.country)) return false;

        return true;
    }
}
