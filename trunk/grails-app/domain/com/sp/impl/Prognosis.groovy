package com.sp.impl

import com.sp.auth.User
import com.sp.enums.PrognosisType
import com.sp.enums.SportEvent

class Prognosis
{
    static final Integer MAX_POINTS = 50
    static final Integer START_POINTS = 0
    static final Double MIN_BETS_COEFFICIENT = 1.50
    static final Double MAX_BETS_COEFFICIENT = MIN_BETS_COEFFICIENT * 3

    String description
    User prognosticator

    Prognosis real
    Boolean actual = Boolean.FALSE
    Boolean isValid = Boolean.FALSE

    Date actualDate
    Date dateCreated
    Date lastUpdated

    Category category
    SportEvent sportEvent

    Command first
    Command second
    Command winner
    transient PrognosisType type = PrognosisType.COUNT

    Integer firstPoints = START_POINTS
    Integer secondPoints = START_POINTS
    Integer differentPoints = START_POINTS

    URL betsUrl
    Double firstBetsCoefficient = MIN_BETS_COEFFICIENT
    Double secondBetsCoefficient = MIN_BETS_COEFFICIENT

    Integer vote = new Integer(0)

    static constraints = {
        description(blank: false)

        real(nullable: true, display: false)
        prognosticator(display: false)
        vote(display: false)
        actual(display: false)
        isValid(display: false)
		
        sportEvent(nullable: false)
        second(validator: { val, obj->
            if (val.equals(obj.first))
            {
                return false
            }
        })

        firstPoints(min: START_POINTS)
        secondPoints(min: START_POINTS)
        differentPoints(min: START_POINTS)

        betsUrl(blank: false, url: true)
        firstBetsCoefficient(blank: false, min: MIN_BETS_COEFFICIENT)
        secondBetsCoefficient(blank: false, min: MIN_BETS_COEFFICIENT)
    }

    @Override
    public String toString() {
        return "Prognosis #" + id;
    }


}

