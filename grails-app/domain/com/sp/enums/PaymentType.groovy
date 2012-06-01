package com.sp.enums

public enum PaymentType {
    PAYPAL("Pay Pal"),
    US_WIRE("Us Wire"),
    INTERNATIONAL_WIRE("International Wire")

    String name

    PaymentType(name)
    {
        this.name = name
    }

    public String toString ( )
    {
        return name;
    }
}