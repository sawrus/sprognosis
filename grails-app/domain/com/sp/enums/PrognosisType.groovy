package com.sp.enums

public enum PrognosisType {
    COUNT("Select count points"),
    RANGE("Select range points")

    String name

    PrognosisType(name)
    {
        this.name = name
    }

    public String toString ( )
    {
        return name;
    }
}