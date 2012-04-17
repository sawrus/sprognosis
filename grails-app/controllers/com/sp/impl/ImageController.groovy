package com.sp.impl

import org.apache.commons.lang.StringUtils
import com.sp.site.Image
import org.apache.commons.logging.LogFactory
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import javax.imageio.ImageIO
import com.sp.site.Post
import com.sp.site.Banner

class ImageController {

    private static final String SITE_IMAGE = 'site_image'
    private static final String IMAGE_PATH = "/images"
    private static final log = LogFactory.getLog(this);

    def save = {
        def imageInstance = new Image(params)

        def imageFile = request.getFile(SITE_IMAGE)
        if (!imageFile.empty){
            saveFileAndFillEntity(imageFile, imageInstance)
        } else {
            flash.message = "Please, chooise imageFile"
            render(view: "create", model: [imageInstance: imageInstance])
        }

        def DEFAULT_EMPTY_SYMBOL = ","
        def isNameEmpty = StringUtils.isEmpty(imageInstance.name) || DEFAULT_EMPTY_SYMBOL.equals(imageInstance.name)
        if (imageInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'image.label', default: 'Image'), imageInstance.id])}"
            if (isNameEmpty){
                imageInstance.name = ""
                imageInstance.save(flush: true)
            }
            log.debug("imageInstance.name="+imageInstance.name)
            redirect(action: "show", id: imageInstance.id)
        }
        else {
            render(view: "create", model: [imageInstance: imageInstance])
        }
    }

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [imageInstanceList: Image.list(params), imageInstanceTotal: Image.count()]
    }

    def create = {
        def imageInstance = new Image()
        imageInstance.properties = params
        return [imageInstance: imageInstance]
    }

    def saveFileAndFillEntity(def imageFile, def imageInstance) {
        log.debug("saveFileAndFillEntity:")

        def webRootDir = servletContext.getRealPath("/")
        def fullImagePath = IMAGE_PATH + (!StringUtils.isEmpty(imageInstance.path) ? imageInstance.path : "")
        def imageDir = new File(webRootDir, fullImagePath)

        imageDir.mkdirs()
        File targetImageFile = new File(imageDir, imageFile.originalFilename)
        imageFile.transferTo(targetImageFile)
        imageInstance.absolutePath = targetImageFile.absolutePath
        imageInstance.fileName = imageFile.originalFilename
        imageInstance.webRootDir = File.separator + grailsApplication.metadata['app.name'] + fullImagePath
        log.debug("imageInstance.absolutePath="+imageInstance.absolutePath)
        log.debug("imageInstance.fileName="+imageInstance.fileName)
        log.debug("imageInstance.webRootDir="+imageInstance.webRootDir)

        def image = ImageIO.read(targetImageFile)
        log.debug("width=" + image.getWidth() + "; height=" + image.getHeight());
        imageInstance.width = image.getWidth()
        imageInstance.height = image.getHeight()

    }

    def show = {
        def imageInstance = Image.get(params.id)
        if (!imageInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'image.label', default: 'Image'), params.id])}"
            redirect(action: "list")
        }
        else {
            [imageInstance: imageInstance]
        }
    }

    def edit = {
        def imageInstance = Image.get(params.id)
        if (!imageInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'image.label', default: 'Image'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [imageInstance: imageInstance]
        }
    }

    def update = {
        def imageInstance = Image.get(params.id)
        String oldAbsolutePath = imageInstance.absolutePath
        def imageFile = request.getFile(SITE_IMAGE)

        if (imageInstance) {
            if (StringUtils.isEmpty(imageInstance.fileName)){
                flash.message = "New file name is empty"
                render(view: "edit", model: [imageInstance: imageInstance])
            }

            if (params.version) {
                def version = params.version.toLong()
                if (imageInstance.version > version) {
                    
                    imageInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'image.label', default: 'Image')] as Object[], "Another user has updated this Image while you were editing")
                    render(view: "edit", model: [imageInstance: imageInstance])
                    return
                }
            }
            imageInstance.properties = params
            if (!imageInstance.hasErrors() && imageInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'image.label', default: 'Image'), imageInstance.id])}"
                redirect(action: "show", id: imageInstance.id)
            }
            else {
                render(view: "edit", model: [imageInstance: imageInstance])
            }

            int lastSeparator = oldAbsolutePath.lastIndexOf(File.separator)
            String newAbsolutePath = oldAbsolutePath.substring(0, lastSeparator+1) + imageInstance.fileName

            log.debug("oldAbsolutePath="+oldAbsolutePath)
            log.debug("newAbsolutePath="+newAbsolutePath)

            File oldImageFile = new File(oldAbsolutePath)

            if (!imageFile.empty){
                oldImageFile.delete()
                saveFileAndFillEntity(imageFile, imageInstance)
                log.debug("delete_and_add")
            } else {
                oldImageFile.renameTo(new File(newAbsolutePath))
                imageInstance.absolutePath = newAbsolutePath
                log.debug("rename")
            }

            imageInstance.save(flush: true)
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'image.label', default: 'Image'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN'])
    def deleteAll = {
        for (Post post: Post.list()){
            for (Image image: post.images){
                post.removeFromImages(image)
            }
            log.debug("clear images to post="+post)
            post.save(flush: true)
        }

        Image.executeUpdate("delete Image");
        redirect(action: "list")
    }

    def delete = {
        def imageInstance = Image.get(params.id)
        final String imagePath = imageInstance.absolutePath
        if (imageInstance) {
            try {
                imageInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'image.label', default: 'Image'), params.id])}"
                redirect(action: "list")

            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'image.label', default: 'Image'), params.id])}"
                redirect(action: "show", id: params.id)
            }

            File file = new File(imagePath)
            file.delete()
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'image.label', default: 'Image'), params.id])}"
            redirect(action: "list")
        }
    }
}
