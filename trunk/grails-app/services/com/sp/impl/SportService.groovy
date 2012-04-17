package com.sp.impl

import grails.plugins.countries.Country
import org.apache.commons.logging.LogFactory
//import org.cyberneko.html.parsers.SAXParser
import com.sun.org.apache.xerces.internal.parsers.SAXParser
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class SportService
{
    private static final log = LogFactory.getLog(this)

    static transactional = true

    final String WIKI_URL = "http://en.wikipedia.org";
    final String WIKI_ROOT_FOOTBALL = "/wiki/List_of_association_football_clubs";
    final String WIKI_LIKE_FOOTBALL = " football clubs in ";
    final List<String> PREFIX_LIST = Arrays.asList(
            "FC",
            "F.C."
    )

    private Category category = new Category()
    private String rootUrl = WIKI_URL;
    private String titlePrefix = WIKI_LIKE_FOOTBALL;
    private String associationHref = WIKI_ROOT_FOOTBALL;

    public def init = { Category category ->
        this.category = category
    }

    public def parseClubs = {
        for (String countryLink: getCountryClubHrefs(associationHref))
        {
            String countryName = countryLink.substring(countryLink.lastIndexOf("_") + 1, countryLink.length())
            for (String clubName: getClubsNames(countryLink))
            {
                saveClub(clubName, countryName)
            }
        }
    }

    public def findCountryByName = { String name ->
        Country country = Country.list().get(0)
        Locale.setDefault(Locale.ENGLISH)
        for (Locale locale: Locale.getAvailableLocales())
        {
            if (locale.displayCountry.equals(name))
            {
                country = Country.findByKey(locale.ISO3Country)
            }
        }
        return country
    }


    private def saveClub(String clubName, String countryName)
    {
        Command command = new Command()
        if (Command.findByName(clubName))
        {
            command = Command.findByName(clubName)
        }
        command.name = !String.valueOf(clubName).isEmpty() ? clubName : System.err.println("Name is empty")
        command.category = category != null ? category : System.err.println("PostCategory is empty!")
        command.description = category.name + " category"
        command.country = findCountryByName(countryName)

        try
        {
            if (!Arrays.asList(
                    command.name, command.category, command.country
            ).contains(null))
            {
                Command.withTransaction() {
                    if (!command.save(flush: true))
                    {
                        System.err.println("This command wasn't saved!")
                        command.errors.each {
                            log.error(it)
                        }
                    }
                }
            }
        }
        catch (e)
        {
            log.debug("saveClub:clubName="+clubName+"; countryName="+countryName + "e:"+e)
            System.err.println("saveClub:" + e.getMessage())
        }
    }

    private def getClubHrefs = { String urlPostfix ->
        Set<String> result = new HashSet<String>()
        try
        {
            Node document = getPage(urlPostfix)
            def hrefs = (Set<String>) document.depthFirst().
                    A.grep { it.'@title'}.findAll {it.'@title'.contains(titlePrefix)}.'@href'
            result.addAll(hrefs)
        }
        catch (e)
        {
            log.debug("urlPostfix="+urlPostfix + "e:"+e)
            System.err.println("getClubHrefs: " + urlPostfix + e.getMessage())
        }
        return result
    }

    private def getClubsNames = { String urlPostfix ->
        Set<String> result = new HashSet<String>()
        try
        {
            Node document = getPage(urlPostfix)
            def names = (Set<String>) document.depthFirst().A.grep {it.'@title'}.findAll {
                checkTitle(it.'@title')
            }.collect {it.text()}
            result.addAll(names)
        }
        catch (e)
        {
            log.debug("urlPostfix="+urlPostfix+"e:"+e)
            System.err.println("getClubHrefs: " + urlPostfix + e.getMessage())
        }
        return result
    }

    private def getCountryClubHrefs(String associationHref)
    {
        Set<String> countryWikiLinks = new HashSet<String>()
        for (String a: getClubHrefs(associationHref))
        {
            for (String countryHref: getClubHrefs(a))
            {
                countryWikiLinks.add(countryHref)
            }
        }
        return countryWikiLinks;
    }

    private def checkTitle = { String title ->
        boolean result = false
        for (String prefix: PREFIX_LIST)
        {
            if (title.contains(prefix))
            {
                result = true
            }
        }
        return result
    }

    private Node getPage(String urlPostfix)
    {
        return new XmlParser(new SAXParser()).parse(rootUrl + urlPostfix)
    }
}

