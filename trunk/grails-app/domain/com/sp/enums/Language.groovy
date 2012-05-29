package com.sp.enums

public enum Language {
    ENGLISH(
            "English",
            "Home",
            "Profile",
            "Sport Prognosis",
            "READ MODE",
            "Edit profile",
            "Edit pay profile",
            "Create comment",
            "Create prognosis",
            "Please authorize your user to leave a comment",
            "Please, send your comment",
            "Prognosis",
            "Edit",
            "Delete",
            "Buy prognosis",
            "Enter your invite code",
            "Be with us!",
            Arrays.asList("Name","Price","Period","Description"),
            Arrays.asList("Commands","Categories","Prognosis","Posts","Active users"),
            Arrays.asList("Actual date","Sport event","Category","Bets URL","Commands","Points","Coefficient","Actions")
    ),
    RUSSIAN(
            "Русский",
            "Главная",
            "Профиль",
            "Спортивные прогнозы",
            "Подробнее",
            "Изменить профиль",
            "Изменить профиль оплаты",
            "Создать комментарий",
            "Создать прогноз",
            "Авторизуйтесь, чтобы оставить свой комментарий",
            "Оставьте ниже свой комментарий",
            "Прогноз",
            "Изменить",
            "Удалить",
            "Купить прогноз",
            "Введите код приглашения",
            "Будьте с нами!",
            Arrays.asList("Имя","Цена","Период","Подробности"),
            Arrays.asList("Команд","Категорий","Прогнозов","Статей","Пользователей"),
            Arrays.asList("Дата события","Тип события","Категория","Ссылка на сервер","Команды","Очки","Коэффициенты","Действия")
    )
    
    String name
    String homeName
    String profile
    String siteName
    String readMore
    String edit
    String editPay
    String createComment
    String createPrognosis
    String authComment
    String makeComment
    String prognosis
    String editCommand
    String deleteCommand
    String buyPrognosis
    String inviteMessage
    String inviteButton
    List<String> payProfile
    List<String> stateProfile
    List<String> prognosisFields

    Language(String name
             , String homeName
             , String profile
             , String siteName
             , String readMore
             , String edit
             , String editPay
             , String createComment
             , String createPrognosis
             , String authComment
             , String makeComment
             , String prognosis
             , String editCommand
             , String deleteCommand
             , String buyPrognosis
             , String inviteMessage
             , String inviteButton
             , List<String> payProfile
             , List<String> stateProfile
             , List<String> prognosisFields
    ) {
        this.name = name
        this.homeName = homeName
        this.profile = profile
        this.siteName = siteName
        this.readMore = readMore
        this.edit = edit
        this.editPay = editPay
        this.createComment = createComment
        this.createPrognosis = createPrognosis
        this.authComment = authComment
        this.makeComment = makeComment
        this.prognosis = prognosis
        this.editCommand = editCommand
        this.deleteCommand = deleteCommand
        this.buyPrognosis = buyPrognosis
        this.inviteMessage = inviteMessage
        this.inviteButton = inviteButton
        this.payProfile = payProfile
        this.stateProfile = stateProfile
        this.prognosisFields = prognosisFields
    }

    @Override
    public String toString() {
        return name;
    }

    public static Language parseLanguageByName(String name){
        Language language = Language.ENGLISH

        for (Language lang: Language.values()){
            if (lang.name().equals(name)){
                language = lang
            }
        }

        return language
    }
}