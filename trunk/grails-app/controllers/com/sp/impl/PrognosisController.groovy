package com.sp.impl

import com.sp.profiles.UserProfile
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.web.servlet.FlashScope
import org.apache.commons.logging.LogFactory

class PrognosisController extends VoteSubscriptionController
{
    PayService payService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    private static final log = LogFactory.getLog(this);
    EmailService emailService


    private static final COUNT_PROGNOSTICATOR_TEST_PASSED = 10;

    /////////////////////////////////////////// Prognosis: custom actions

	@Secured(['ROLE_USER'])
	def search = {
		if (params.category)
		{
			String result = "<table><thead><tr>"
			result += "<th>Description</th>"
			result += "<th>Vote</th>"
			result += "<th>Action</th>"
			result += "<th>First/Second</th>"
			result += "<th>Points</th>"
			result += "</tr></thead><tbody>";			
			def prognosisList = Prognosis.findAllByCategory(Category.findByName(params.category))
			for (Prognosis prognosis: prognosisList)
			{
				result += "<tr>"
				result += "<td>" + prognosis.description + "</td>"
				result += "<td>" + prognosis.vote + "</td>"
				result += "<td><a href=/Test/prognosis/show/"+ prognosis.id +">Show</a></td>"
				result += "<td>" + prognosis.first.name + " / " + prognosis.second.name + "</td>"
				result += "<td>" + prognosis.firstPoints + " : " + prognosis.secondPoints + "</td>"
				result += "</tr>"
			}
			result += "</tbody></table>"
			render result
		}		

	}

    /////////////////////////////////////////// Prognosis: base actions


    @Secured(['ROLE_PROGNOSTICATOR','ROLE_ADMIN'])
    def create = {
        [prognosisInstance: new Prognosis()]
    }

    @Secured(['ROLE_PROGNOSTICATOR','ROLE_ADMIN'])
    def save = {
        Prognosis prognosis = new Prognosis()
        prognosis.properties = params
        prognosis.prognosticator = userService.getUser()
		setParameters(prognosis, params)

        if (prognosis.save(flush: true))
		{
		    flash.message = "${message(code: 'default.created.message', args: [message(code: 'prognosis.label', default: 'Prognosis'), prognosis.id])}"
            list()
        }
		else
		{
            render view: 'edit', model: [prognosisInstance: prognosis]
		}
        def message = "save:prognosis=" + prognosis + "; prognosticator=" + prognosis.prognosticator
        log.debug(message)

        String emailContent = """Hi, man!
        Here are the details of new prognosis:
        Prognosticator: ${prognosis.prognosticator}
        New Prognose: ${prognosis}
        """

        emailService.sendEmail("New prognosis", emailContent)
    }

    @Secured(['ROLE_ADMIN'])
    def index = {
        redirect(action: "list", params: params)
    }

    @Secured(['ROLE_ADMIN'])
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [prognosisInstanceList: Prognosis.list(params), prognosisInstanceTotal: Prognosis.count()]
    }

    @Secured(['ROLE_USER','ROLE_ADMIN','ROLE_PROGNOSTICATOR'])
    def show = {
        def prognosisInstance = Prognosis.get(params.id)
		checkPrognosticatorAccess(prognosisInstance, flash, predicted)
        if (!prognosisInstance)
        {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'prognosis.label', default: 'Prognosis'), params.id])}"
            list()
        }
        else
        {
            [prognosisInstance: prognosisInstance]
        }
    }

    @Secured(['ROLE_PROGNOSTICATOR','ROLE_ADMIN'])
    def edit = {
        def prognosisInstance = Prognosis.get(params.id)
        checkPrognosticatorAccess(prognosisInstance, flash, predicted)
        if (!prognosisInstance)
        {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'prognosis.label', default: 'Prognosis'), params.id])}"
            list()
        }
        else
        {
            return [prognosisInstance: prognosisInstance, params: getParams(prognosisInstance,params)]
        }
    }

    @Secured(['ROLE_PROGNOSTICATOR','ROLE_ADMIN'])
    def update = {
        def prognosisInstance = Prognosis.get(params.id)
        checkPrognosticatorAccess(prognosisInstance, flash, predicted)
        if (prognosisInstance)
        {
            if (params.version)
            {
                def version = params.version.toLong()
                if (prognosisInstance.version > version)
                {

                    prognosisInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'prognosis.label', default: 'Prognosis')] as Object[], "Another user has updated this Prognosis while you were editing")
                    render(view: "edit", model: [prognosisInstance: prognosisInstance])
                    return
                }
            }
            prognosisInstance.properties = params
			setParameters(prognosisInstance, params)
            if (!prognosisInstance.hasErrors() && prognosisInstance.save(flush: true))
            {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'prognosis.label', default: 'Prognosis'), prognosisInstance.id])}"
                list()
            }
            else
            {
                render(view: "edit", model: [prognosisInstance: prognosisInstance])
            }
        }
        else
        {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'prognosis.label', default: 'Prognosis'), params.id])}"
            list()
        }
    }

    @Secured(['ROLE_PROGNOSTICATOR','ROLE_ADMIN'])
    def delete = {
        def prognosisInstance = Prognosis.get(params.id)
        checkPrognosticatorAccess(prognosisInstance, flash, predicted)
        if (prognosisInstance)
        {
            try
            {
                //prognosisInstance.delete(flush: true)
				Prognosis.executeUpdate("delete Prognosis p where p.id=(:id)", [id: prognosisInstance.id])
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'prognosis.label', default: 'Prognosis'), params.id])}"
                list()
            }
            catch (org.springframework.dao.DataIntegrityViolationException e)
            {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'prognosis.label', default: 'Prognosis'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else
        {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'prognosis.label', default: 'Prognosis'), params.id])}"
            list()
        }
    }

    private list() {
        if (userService.hasPrognosticator) {
            //redirect(action: "checked")
            redirect(controller: "site", action: "checked")
        } else {
            redirect(action: "list")
        }
    }



    protected String addVote(Integer voteValue)
    {
        Prognosis domain = Prognosis.get(params.id)
        if (isVoteAllow())
        {
            domain.vote += voteValue
            domain.save()
            addVoteEntity()
        }
        return String.valueOf(domain.vote)
    }

    private def checkPrognosticatorAccess(Prognosis prognosisInstance, FlashScope flash, Closure predicted)
    {
        if (!userService.hasUser && !userService.hasAdmin)
        {
            if (userService.hasPrognosticator && prognosisInstance && !userService.getUser().equals(prognosisInstance.prognosticator))
            {
                log.debug("access_denied:prognosisInstance="+prognosisInstance)
                flash.message = "Access denied"
                redirect action: predicted
            }
        }
    }
	
	private def getParams = 
	{ Prognosis prognosis, params ->
		params.categoryName = prognosis.category.name
		params.firstName  = prognosis.first.name		
		params.secondName = prognosis.second.name		
		params.winnerName = prognosis.winner.name		
		return params
	}
	
	private def setParameters = 
	{ Prognosis prognosis, params ->
		log.debug("setParameters:")
        
		if (params.categoryName)
		{
			Category category = Category.findByName(params.categoryName)
			if (!category)
			{
				category = new Category(name: params.categoryName)
				category.save(flush: true)
                log.debug("add:category="+Category)
			}
			prognosis.category = category
		}
		
		if (params.firstName)
		{
			Command first = Command.findByName(params.firstName)
			if (!first)
			{
				first = new Command(name: params.firstName, category: prognosis.category)
				first.save(flush: true)
                log.debug("add:first_command="+first)
			}
			prognosis.first = first
		}
		
		if (params.secondName)
		{
			Command second = Command.findByName(params.secondName)
			if (!second)
			{
				second = new Command(name: params.secondName, category: prognosis.category)
				second.save(flush: true)
                log.debug("add:second_command="+second)
			}
			prognosis.second = second
		}
		
		if (params.winnerName && "0".equals(params.winnerName))
			prognosis.winner = prognosis.first
		else
			prognosis.winner = prognosis.second
			
	}
}

