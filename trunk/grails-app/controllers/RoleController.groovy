import com.sp.auth.Role
import com.sp.auth.RequestMap
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.auth.User

/**
 * Authority Controller.
 */
class RoleController
{

    // the delete, save and update actions only accept POST requests
    static Map allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def authenticateService

    @Secured(['ROLE_ADMIN'])
    def index = {
        redirect action: list, params: params
    }

    /**
     * Display the list authority page.
     */
    @Secured(['ROLE_ADMIN'])
    def list = {
        if (!params.max)
        {
            params.max = 10
        }
        [authorityList: Role.list(params)]
    }

    /**
     * Display the show authority page.
     */
    @Secured(['ROLE_ADMIN'])
    def show = {
        def authority = Role.get(params.id)
        if (!authority)
        {
            flash.message = "Role not found with id $params.id"
            redirect action: list
            return
        }

        [authority: authority]
    }

    /**
     * Delete an authority.
     */
    @Secured(['ROLE_ADMIN'])
    def delete = {
        def authority = Role.get(params.id)
        if (!authority)
        {
            flash.message = "Role not found with id $params.id"
            redirect action: list
            return
        }

        authenticateService.deleteRole(authority)

        flash.message = "Role $params.id deleted."
        redirect action: list
    }

    /**
     * Display the edit authority page.
     */
    @Secured(['ROLE_ADMIN'])
    def edit = {
        def authority = Role.get(params.id)
        if (!authority)
        {
            flash.message = "Role not found with id $params.id"
            redirect action: list
            return
        }

        [authority: authority]
    }

    /**
     * Authority update action.
     */
    @Secured(['ROLE_ADMIN'])
    def update = {

        def authority = Role.get(params.id)
        if (!authority)
        {
            flash.message = "Role not found with id $params.id"
            redirect action: edit, id: params.id
            return
        }

        long version = params.version.toLong()
        if (authority.version > version)
        {
            authority.errors.rejectValue 'version', 'authority.optimistic.locking.failure',
                    'Another user has updated this Role while you were editing.'
            render view: 'edit', model: [authority: authority]
            return
        }

        if (authenticateService.updateRole(authority, params))
        {
            authenticateService.clearCachedRequestmaps()
            redirect action: show, id: authority.id
        }
        else
        {
            render view: 'edit', model: [authority: authority]
        }
    }

    /**
     * Display the create new authority page.
     */
    @Secured(['ROLE_ADMIN'])
    def create = {
        [authority: new Role()]
    }

    /**
     * Save a new authority.
     */
    @Secured(['ROLE_ADMIN'])
    def save = {

        def authority = new Role()
        authority.properties = params
        if (authority.save())
        {
            redirect action: show, id: authority.id
        }
        else
        {
            render view: 'create', model: [authority: authority]
        }
    }

    def load = {
        def roles = Arrays.asList(
                new Role(authority: "ROLE_ADMIN", description: "admin role"),
                new Role(authority: "ROLE_USER", description: "user role"),
                new Role(authority: "ROLE_PROGNOSTICATOR", description: "prognosticator role")
        )
        for (Role role: roles)
        {
            if (!Role.list().contains(role))
            {
                role.save(flush: true)
            }
        }

        User admin = new User(username: "admin", userRealName: "admin", passwd: "admin", enabled: true)
        admin.addToAuthorities(roles.get(0))
        if (!User.list().contains(admin))
        {
            admin.save(flush: true)
        }

        redirect action: index
    }
}
