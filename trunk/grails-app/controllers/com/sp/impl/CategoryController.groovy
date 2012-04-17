package com.sp.impl

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_USER','ROLE_PROGNOSTICATOR','ROLE_ADMIN'])
class CategoryController
{
    @Secured(['ROLE_ADMIN'])
    def index = {
        redirect uri: '/'
    }

	def searchAJAX = { 
		def categoryList = Category.findAllByNameLike("%${params.query}%")

		render(contentType: "text/xml") 
		{ 
			results(){ 
				categoryList.each { 
					category -> result(){ 
						name(category.name) 
						id(category.id) 
					} 
				} 
			} 
		} 
	}
}
