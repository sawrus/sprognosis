import com.sp.impl.UserService

class UrlMappings {


	static mappings = {
		"/$controller/$action?/$id?"{ constraints { } }

        "/"(controller = "site", action: "index")

        "/s/$search"(controller: "site", action: "search")

		"500"(controller = "site", action: "error")
    }
}
