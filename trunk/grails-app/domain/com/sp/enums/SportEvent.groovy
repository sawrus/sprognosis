package com.sp.enums

public enum SportEvent {
    INVITATIONALS("invitationals"),
    LEAGUE_MEETS("league meets"),
    PRE_REGIONAL_CHAMPIONSHIPS("pre-regional championships"),
    REGIONAL_CHAMPIONSHIPS("regional championships"),
    NATIONAL_CHAMPIONSHIPS("national championships"),
    WORLD_CHAMPIONSHIP("world championship")

    String name

    SportEvent(name)
    {
        this.name = name
    }

    public String toString ( )
    {
        return name;
    }
}