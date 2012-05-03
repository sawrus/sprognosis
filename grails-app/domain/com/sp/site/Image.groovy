package com.sp.site

import com.sp.AbstractDomain
import org.apache.commons.lang.StringUtils

class Image extends AbstractDomain{
    String fileName
    String absolutePath
    String webRootDir
    String style
    String path = ""
    
    Integer width
    Integer height

    boolean visible = false
    boolean general = false

    static constraints = {
        style(nullable: true)
        path(nullable: true)
    }

    public String toHtmlPseudoTag(){
        String QUOT = "&quot";
        String LT = "&lt";
        String GT = "&gt";
        return toHtml(QUOT, LT, GT)
    }

    public String toHtmlTag() {
        String QUOT = "\"";
        String LT = "<";
        String GT = ">";
        return visible? toHtml(QUOT, LT, GT) : ""
    }

    private String toHtml(String QUOT, String LT, String GT) {
        final String src = "src=${QUOT}${webRootDir + getSeparator() + fileName}${QUOT}"
        final String style = StringUtils.isEmpty(style) ? "" : "style=${QUOT}${style}${QUOT}"
        final String title = StringUtils.isEmpty(name) ? "" : "title=${QUOT}$name${QUOT}"
        final String alt = StringUtils.isEmpty(description) ? "" : "alt=${QUOT}$name${QUOT}"
        return LT + "img ${src} ${style} ${alt} ${title}/" + GT
    }

    public String toHtmlTagWithResize(int percentOfOriginal) {
        if (percentOfOriginal < 0 || percentOfOriginal > 100) {
            percentOfOriginal = 100
        }
        int height = Math.round(percentOfOriginal * height / 100)
        int width = Math.round(percentOfOriginal * width / 100)
        return resizeImage(height, width)
    }

    public String toHtmlTagWithResize(int newWidth, int newHeight) {

        int decreasePercent = width > newWidth ?
            Math.round(newWidth / Math.round(width / 100)):
            height > newHeight ?
                Math.round(newHeight / Math.round(height / 100)):
                100

        int width = width <= newWidth ? width : Math.round(decreasePercent * width/100)
        int height = height <= newHeight ? height : Math.round(decreasePercent * height/100)

        return resizeImage(height, width)
    }

    private String resizeImage(int height, int width) {
        String QUOT = "\"";
        String LT = "<";
        String GT = ">";
        String src = "src=${QUOT}${webRootDir + getSeparator() + fileName}${QUOT}"
        String style = StringUtils.isEmpty(style) ? "" : "style=${QUOT}${style}${QUOT}"
        String title = StringUtils.isEmpty(name) ? "" : "title=${QUOT}$name${QUOT}"
        String alt = StringUtils.isEmpty(description) ? "" : "alt=${QUOT}$name${QUOT}"
        String heightProperty = "height=${QUOT}$height${QUOT}"
        String widthProperty = "width=${QUOT}$width${QUOT}"
        return LT + "img ${src} ${style} ${alt} ${title} ${heightProperty} ${widthProperty}/" + GT
    }

    private String getSeparator() {
        return "/"
    }

    public String toPath(){
        return webRootDir + File.separator + fileName
    }

    @Override
    String toString() {
        return "Image #"+fileName
    }


}
