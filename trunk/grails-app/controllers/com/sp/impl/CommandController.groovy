package com.sp.impl

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_USER','ROLE_PROGNOSTICATOR','ROLE_ADMIN'])
class CommandController
{
    @Secured(['ROLE_ADMIN'])
    def index = {
        redirect uri: '/'
    }

	def searchAJAX = { 
		def commands = Command.findAllByNameLike("%${params.query}%")

		render(contentType: "text/xml") 
		{ 
			results(){ 
				commands.each { 
					command -> result(){ 
						name(command.name) 
						id(command.id) 
					} 
				} 
			} 
		} 
	}	        
}
