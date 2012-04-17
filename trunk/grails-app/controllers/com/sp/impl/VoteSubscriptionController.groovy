package com.sp.impl

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

abstract class VoteSubscriptionController
{
    UserService userService
    protected final Integer positiveVote = 1
    protected final Integer negativeVote = -1

    public boolean isVoteAllow()
    {
        return !Vote.findByUserIdAndEntityId(userService.getUserId(), params.id)
    }

    protected def addVoteEntity()
    {
        Vote vote = new Vote(userId: userService.getUserId(), entityId: params.id)
        vote.save()
    }

    protected abstract String addVote(Integer voteValue)

    @Secured(['ROLE_USER'])
    def negative =
    {
        render addVote(negativeVote)
    }

    @Secured(['ROLE_USER'])
    def positive =
    {
        render addVote(positiveVote)
    }
}
