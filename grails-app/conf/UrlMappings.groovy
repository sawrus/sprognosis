import com.sp.impl.UserService

class UrlMappings {


	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {

			}
		}

        "/" { controller = "site" }
		"500"(view:'/error')
	}
}
