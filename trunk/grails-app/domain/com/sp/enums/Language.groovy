package com.sp.enums

public enum Language {
    ENGLISH(
            "English",
            "Home",
            "Sport Prognosis",
            "READ MODE",
            Arrays.asList("Name","Price","Period","Description"),
            Arrays.asList("Commands","Categories","Prognosis","Posts","Active users")
    ),
    RUSSIAN(
            "Русский",
            "Главная",
            "Спортивные прогнозы",
            "Подробнее",
            Arrays.asList("Имя","Цена","Период","Подробности"),
            Arrays.asList("Команд","Категорий","Прогнозов","Статей","Пользователей")
    )
    
    String name
    String homeName
    String siteName
    String readMore
    List<String> payProfile
    List<String> stateProfile

    Language(String name, String homeName, String siteName, String readMore, List<String> payProfile, List<String> stateProfile) {
        this.name = name
        this.homeName = homeName
        this.siteName = siteName
        this.readMore = readMore
        this.payProfile = payProfile
        this.stateProfile = stateProfile
    }

    @Override
    public String toString() {
        return name;
    }
}