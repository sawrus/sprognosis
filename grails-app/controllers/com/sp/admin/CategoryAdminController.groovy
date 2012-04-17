package com.sp.admin

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.sp.impl.Category


@Secured(['ROLE_ADMIN'])
class CategoryAdminController
{
    def scaffold = com.sp.impl.Category

    def load =
    {
        Set<Category> categories = new HashSet<Category>();

        categories.add(new Category(name: "Football"));
        categories.add(new Category(name: "Basketball"));
        categories.add(new Category(name: "Archery"));
        categories.add(new Category(name: "Swimming"));
        categories.add(new Category(name: "Skeet Shooting"));
        categories.add(new Category(name: "Wrestling"));
        categories.add(new Category(name: "Pool Playing"));
        categories.add(new Category(name: "Synchronized Swimming"));
        categories.add(new Category(name: "Volleyball"));
        categories.add(new Category(name: "Badminton"));
        categories.add(new Category(name: "Baseball"));
        categories.add(new Category(name: "Boxing"));
        categories.add(new Category(name: "Canoeing"));
        categories.add(new Category(name: "Cycling"));
        categories.add(new Category(name: "Tennis"));
        categories.add(new Category(name: "Gymnastics"));
        categories.add(new Category(name: "Hockey"));
        categories.add(new Category(name: "Karate"));
        categories.add(new Category(name: "Hang Gliding"));
        categories.add(new Category(name: "Parachuting"));
        categories.add(new Category(name: "Water Skiing"));
        categories.add(new Category(name: "Down Hill Skiing"));
        categories.add(new Category(name: "Cross Country Skiing"));
        categories.add(new Category(name: "Water Polo"));
        categories.add(new Category(name: "Bowling"));
        categories.add(new Category(name: "Racket ball"));
        categories.add(new Category(name: "Darts"));
        categories.add(new Category(name: "Foosball"));
        categories.add(new Category(name: "Decathlon"));
        categories.add(new Category(name: "Hunting"));
        categories.add(new Category(name: "Speed Skating"));
        categories.add(new Category(name: "Figure Skating"));
        categories.add(new Category(name: "Handball"));
        categories.add(new Category(name: "Rowing"));
        categories.add(new Category(name: "Sailing"));
        categories.add(new Category(name: "Synchronized Swimming"));
        categories.add(new Category(name: "Table Tennis"));
        categories.add(new Category(name: "Triathlon"));
        categories.add(new Category(name: "Weight Lifting"));
        categories.add(new Category(name: "Crochet"));
        categories.add(new Category(name: "Horseshoes"));
        categories.add(new Category(name: "Bocce Ball"));
        categories.add(new Category(name: "Soccer"));
        categories.add(new Category(name: "Rugby"));
        categories.add(new Category(name: "Motorcycle Racing"));
        categories.add(new Category(name: "Automobile Racing"));
        categories.add(new Category(name: "Aquatics"));
        categories.add(new Category(name: "Archery"));
        categories.add(new Category(name: "Equestrian"));
        categories.add(new Category(name: "Fencing"));
        categories.add(new Category(name: "Judo"));
        categories.add(new Category(name: "Modern Pentathlon"));
        categories.add(new Category(name: "Rowing"));
        categories.add(new Category(name: "Taekwondo"));
        categories.add(new Category(name: "Biathlon"));
        categories.add(new Category(name: "Bobsleigh"));
        categories.add(new Category(name: "Curling"));
        categories.add(new Category(name: "Ice Hockey"));
        categories.add(new Category(name: "Luge"));
        categories.add(new Category(name: "Golf"));
        categories.add(new Category(name: "Roller Skating"));
        categories.add(new Category(name: "Surfing"));
        categories.add(new Category(name: "Scuba Diving"));
        categories.add(new Category(name: "Mountaineering and Climbing"));
        categories.add(new Category(name: "Squash"));
        categories.add(new Category(name: "Sumo Wrestling"));
        categories.add(new Category(name: "Wushu"));
        categories.add(new Category(name: "Chess"));
        categories.add(new Category(name: "Netball"));
        categories.add(new Category(name: "Kayaking"));
        categories.add(new Category(name: "Snowshoeing"));
        categories.add(new Category(name: "Mountain Biking"));
        categories.add(new Category(name: "Sprint Running"));
        categories.add(new Category(name: "Cross Country Running"));
        categories.add(new Category(name: "Power Walking"));
        categories.add(new Category(name: "Snow Sledding"));
        categories.add(new Category(name: "Paint ball"));
        categories.add(new Category(name: "Rock Climbing"));
        categories.add(new Category(name: "Hiking"));
        categories.add(new Category(name: "Roller Skating"));
        categories.add(new Category(name: "Ice Skating"));
        categories.add(new Category(name: "Fishing"));
        categories.add(new Category(name: "Water Tubing"));
        categories.add(new Category(name: "Boomerang"));
        categories.add(new Category(name: "Cricket"));
        categories.add(new Category(name: "Cheerleading"));
        categories.add(new Category(name: "Jai Alai"));
        categories.add(new Category(name: "Fencing"));
        categories.add(new Category(name: "Paddle Ball"));
        categories.add(new Category(name: "Lacrosse"));
        categories.add(new Category(name: "Petanque"));
        categories.add(new Category(name: "Skateboarding"));
        categories.add(new Category(name: "Tchoukball"));
        categories.add(new Category(name: "Track and Field"));
        categories.add(new Category(name: "Bird Watching"));
        categories.add(new Category(name: "Horseback Riding"));
        categories.add(new Category(name: "Prospecting"));
        categories.add(new Category(name: "Snow Biking"));
        categories.add(new Category(name: "White Water Rafting"));
        categories.add(new Category(name: "Water Snorkling"));
        categories.add(new Category(name: "Dog Sledding"));
        categories.add(new Category(name: "Sport Fishing"));
        categories.add(new Category(name: "River Rafting"));
        categories.add(new Category(name: "Whale Watching"));
        categories.add(new Category(name: "Sky Diving"));
        categories.add(new Category(name: "Camping"));
        categories.add(new Category(name: "Inline Skating"));
        categories.add(new Category(name: "Metal Detecting"));
        categories.add(new Category(name: "Bull Fighting"));
        categories.add(new Category(name: "Falconry"));
        categories.add(new Category(name: "Dog Training"));
        categories.add(new Category(name: "Rodeo Riding"));
        categories.add(new Category(name: "Snow Boarding"));
        categories.add(new Category(name: "Shuffle Board"));
        categories.add(new Category(name: "Flag Football"));
        categories.add(new Category(name: "Fox Hunting"));
        categories.add(new Category(name: "Model Flying"));
        categories.add(new Category(name: "Remote Control Boating"));
        categories.add(new Category(name: "Medicine Ball"));
        categories.add(new Category(name: "Hot Air Ballooning"));
        categories.add(new Category(name: "Wheelchair Basketball"));
        categories.add(new Category(name: "Caving"));
        categories.add(new Category(name: "Diving"));
        categories.add(new Category(name: "Modern Dance"));
        categories.add(new Category(name: "Classical Dance"));
        categories.add(new Category(name: "Para Gliding"));
        categories.add(new Category(name: "Knee Boarding"));
        categories.add(new Category(name: "Yachting"));
        categories.add(new Category(name: "Land Sailing"));
        categories.add(new Category(name: "Jump Roping"));
        categories.add(new Category(name: "Sombo"));
        categories.add(new Category(name: "Tug of War"));
        categories.add(new Category(name: "Wind Surfing"));
        categories.add(new Category(name: "Yoga"));
        categories.add(new Category(name: "Stunt Plane Flying"));
        categories.add(new Category(name: "Train Collecting"));
        categories.add(new Category(name: "Biathlon"));
        categories.add(new Category(name: "Log Rolling"));
        categories.add(new Category(name: "Tree Topping"));
        categories.add(new Category(name: "Body Building"));
        categories.add(new Category(name: "High Jump"));
        categories.add(new Category(name: "Long Jump"));
        categories.add(new Category(name: "Snooker"));
        categories.add(new Category(name: "Shot Put"));

        for (Category category: categories)
        {
            if (!Category.list().contains(category))
            {
                category.parent = null;
                category.description = "Sport category"
                category.save(flush:true);
            }
        }

        redirect uri: '/'
    }
}
