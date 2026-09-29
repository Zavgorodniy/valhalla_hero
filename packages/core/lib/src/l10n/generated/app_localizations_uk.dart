// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class L10nUk extends L10n {
  L10nUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Здобич';

  @override
  String get signIn => 'Увійти';

  @override
  String get signUp => 'Реєстрація';

  @override
  String get signOut => 'Вийти';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Пароль';

  @override
  String get nickname => 'Нікнейм';

  @override
  String get birthDate => 'Дата народження';

  @override
  String get ageGateError => 'Тобі має бути щонайменше 18 років.';

  @override
  String get continueWithApple => 'Продовжити з Apple';

  @override
  String get alreadyHaveAccount => 'Вже маєш акаунт?';

  @override
  String get termsAccept =>
      'Я приймаю умови участі та політику конфіденційності.';

  @override
  String get createAccount => 'Створити акаунт';

  @override
  String get signupConfirmTitle => 'Підтверди e-mail';

  @override
  String signupConfirmBody(String email) {
    return 'Ми надіслали посилання на $email. Відкрий його, а потім увійди тут.';
  }

  @override
  String get completeProfile => 'Заповнити профіль';

  @override
  String authError(String message) {
    return 'Не вдалося увійти: $message';
  }

  @override
  String xpLabel(int xp) {
    final intl.NumberFormat xpNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String xpString = xpNumberFormat.format(xp);

    return '$xpString XP';
  }

  @override
  String get onBoard => 'На борту';

  @override
  String visitsCount(int count) {
    return 'Візитів: $count';
  }

  @override
  String get claimVisit => 'Відмітити візит';

  @override
  String get claimVisitTitle => 'Відмітити візит';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Забагато заявок чекають на перевірку.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Мої заявки';

  @override
  String get achievements => 'Досягнення';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return 'Відкрито $unlocked з $total';
  }

  @override
  String get locked => 'Закрито';

  @override
  String get rewards => 'Нагороди';

  @override
  String get gear => 'Спорядження';

  @override
  String get myVouchers => 'Мої ваучери';

  @override
  String get redeemed => 'Готово! Покажи цей код біля стійки.';

  @override
  String get insufficientCoins => 'Недостатньо монет.';

  @override
  String get outOfStock => 'Немає в наявності';

  @override
  String stockLeft(int count) {
    return 'Залишилось: $count';
  }

  @override
  String validUntil(String date) {
    return 'Діє до $date';
  }

  @override
  String get voucherActive => 'Активний';

  @override
  String get voucherRedeemed => 'Використаний';

  @override
  String get voucherExpired => 'Прострочений';

  @override
  String get voucherCancelled => 'Скасований';

  @override
  String get rewardTypeMerch => 'Мерч';

  @override
  String get rewardTypeDrink => 'Напій';

  @override
  String get rewardTypeDiscount => 'Знижка';

  @override
  String get rewardTypePriorityBooking => 'Бронь';

  @override
  String get rewardTypeEventAccess => 'Подія';

  @override
  String get owned => 'Є';

  @override
  String get equip => 'Одягнути';

  @override
  String get equipped => 'Одягнено';

  @override
  String get unequip => 'Зняти';

  @override
  String get purchaseDone => 'Куплено. Можна одразу одягнути.';

  @override
  String unlockAtLevel(int level) {
    return 'З рівня $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Досягнення: $name';
  }

  @override
  String get unlockByEvent => 'Лише на подіях';

  @override
  String get slotHeadgear => 'Голова';

  @override
  String get slotHandItem => 'Рука';

  @override
  String get slotCape => 'Плащ';

  @override
  String get slotCompanion => 'Супутник';

  @override
  String get slotFrame => 'Рамка';

  @override
  String get rarityCommon => 'Звичайний';

  @override
  String get rarityRare => 'Рідкісний';

  @override
  String get rarityLegendary => 'Легендарний';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Ти';

  @override
  String get leaderboardHidden => 'Твій профіль приховано в рейтингу.';

  @override
  String get postTypeNews => 'Новини';

  @override
  String get postTypeEvent => 'Подія';

  @override
  String get notifications => 'Повідомлення';

  @override
  String get notificationsEmpty => 'Повідомлень немає.';

  @override
  String get settings => 'Налаштування';

  @override
  String get language => 'Мова';

  @override
  String get leaderboardVisible => 'Показувати в рейтингу';

  @override
  String get privacy => 'Конфіденційність';

  @override
  String get exportData => 'Експорт моїх даних';

  @override
  String get exportDataDone => 'Експорт створено.';

  @override
  String get deleteAccount => 'Видалити акаунт';

  @override
  String get deleteAccountTitle => 'Справді видалити акаунт?';

  @override
  String deleteAccountBody(int coins) {
    return 'Усі дані, XP і монети ($coins) буде видалено назавжди.';
  }

  @override
  String get delete => 'Видалити';

  @override
  String get cancel => 'Скасувати';

  @override
  String get confirm => 'Підтвердити';

  @override
  String get save => 'Зберегти';

  @override
  String get close => 'Закрити';

  @override
  String get gotIt => 'Зрозуміло';

  @override
  String get retry => 'Повторити';

  @override
  String get staffClaimsEmpty => 'Немає заявок на перевірку.';

  @override
  String get staffApprove => 'Підтвердити';

  @override
  String get staffReject => 'Відхилити';

  @override
  String get staffRejectReason => 'Причина (необов’язково)';

  @override
  String get staffVoucherConfirm => 'Позначити як використаний';

  @override
  String get staffVoucherNotFound => 'Ваучер із таким кодом не знайдено.';

  @override
  String get staffVoucherDone => 'Ваучер використано.';

  @override
  String get staffCredit => 'Besuch manuell gutschreiben';

  @override
  String get adminDashboard => 'Übersicht';

  @override
  String get adminUsers => 'Gäste';

  @override
  String get adminClaims => 'Meldungen';

  @override
  String get adminRewards => 'Belohnungen';

  @override
  String get adminItems => 'Ausrüstung';

  @override
  String get adminPosts => 'Saga';

  @override
  String get adminVenues => 'Bars';

  @override
  String get adminEconomy => 'Ökonomie';

  @override
  String get adminStatUsers => 'Gäste';

  @override
  String get adminStatOnBoard => 'An Bord';

  @override
  String get adminStatVisits30 => 'Besuche (30 Tage)';

  @override
  String get adminStatRevenue30 => 'Umsatz (30 Tage)';

  @override
  String get adminStatPending => 'Offene Meldungen';

  @override
  String get adminStatCoins => 'Münzen im Umlauf';

  @override
  String get adminStatVouchersActive => 'Aktive Gutscheine';

  @override
  String get adminStatVouchersRedeemed30 => 'Eingelöst (30 Tage)';

  @override
  String get adminNewPost => 'Neuer Beitrag';

  @override
  String get adminPublish => 'Veröffentlichen';

  @override
  String get adminDraft => 'Entwurf';

  @override
  String get adminTitle => 'Titel';

  @override
  String get adminBody => 'Text';

  @override
  String get adminImageUrl => 'Bild-URL';

  @override
  String get adminStartsAt => 'Beginn';

  @override
  String get adminEndsAt => 'Ende (optional)';

  @override
  String get adminCategory => 'Kategorie';

  @override
  String get adminPrice => 'Preis (Münzen)';

  @override
  String get adminStock => 'Bestand (leer = unbegrenzt)';

  @override
  String get adminValidityDays => 'Gültigkeit (Tage)';

  @override
  String get adminActive => 'Aktiv';

  @override
  String get adminRole => 'Rolle';

  @override
  String get adminSearch => 'Suchen';

  @override
  String get adminEconomyXpPerVisit => 'XP pro Besuch';

  @override
  String get adminEconomyCoinsPerEuro => 'Münzen pro Euro';

  @override
  String get adminEconomyDailyCap => 'Tageslimit Münzen';

  @override
  String get adminEconomyExpiryMonths => 'Verfall (Monate)';

  @override
  String get adminEconomyOnboardDays => 'An Bord (Tage)';

  @override
  String get adminEconomyStreakBonus => 'Streak-Bonus XP';

  @override
  String get adminLevels => 'Stufen';

  @override
  String get adminLevelThreshold => 'XP-Schwelle';

  @override
  String get adminLevelMultiplier => 'Münz-Multiplikator';

  @override
  String get adminSaved => 'Gespeichert.';

  @override
  String get adminNotAllowed => 'Nur für Administratoren.';

  @override
  String get coinReasonVisit => 'Візит';

  @override
  String get coinReasonAchievement => 'Досягнення';

  @override
  String get coinReasonManual => 'Нарахування командою';

  @override
  String get coinReasonReward => 'Нагорода';

  @override
  String get coinReasonItem => 'Спорядження';

  @override
  String get coinReasonExpiry => 'Згоряння';

  @override
  String get coinReasonRefund => 'Повернення';

  @override
  String get coinReasonCheckin => 'Фото в сазі';

  @override
  String get tabHero => 'Герой';

  @override
  String get heroPath => 'Шлях героя';

  @override
  String get statStreak => 'Серія';

  @override
  String get statOnBoard => 'На борту';

  @override
  String get statVisits => 'Візити';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks тижня',
      many: '$weeks тижнів',
      few: '$weeks тижні',
      one: '$weeks тиждень',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дня',
      many: '$days днів',
      few: '$days дні',
      one: '$days день',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'Цього тижня';

  @override
  String get all => 'Усі';

  @override
  String get claimSheetSub => 'Команда бару підтвердить твій візит.';

  @override
  String get claimWhere => 'Де ти?';

  @override
  String get change => 'Змінити';

  @override
  String get claimAmountLabel => 'Сума чека';

  @override
  String get claimAmountHint =>
      'Впливає лише на монети. XP нараховується за візит – не за євро.';

  @override
  String get claimNoteLabel => 'Нотатка для команди (необов’язково)';

  @override
  String get claimNoteHint => 'напр. стіл 7';

  @override
  String get claimPreview => 'Після підтвердження ти отримаєш';

  @override
  String streakBonus(int xp) {
    return '+$xp бонус за серію';
  }

  @override
  String get claimSentTitle => 'Візит відмічено';

  @override
  String get claimSentBody => 'Покажи цей код команді – так найшвидше.';

  @override
  String get yourVisitCode => 'Твій код візиту';

  @override
  String get stepReported => 'Надіслано';

  @override
  String get stepChecking => 'Перевіряється';

  @override
  String get stepCheckingSub => 'Зазвичай менше 5 хвилин';

  @override
  String get stepCredited => 'Нараховано';

  @override
  String get stepCreditedSub => 'XP, бонус за серію та монети';

  @override
  String get hornWillCall => 'Ми засурмимо в ріг, коли все буде готово.';

  @override
  String get toHall => 'Назад до зали';

  @override
  String get claimRejectedTitle => 'Візит відхилено';

  @override
  String get claimRejectedBody => 'Коротко поговори з командою біля стійки.';

  @override
  String get visitConfirmed => 'Візит підтверджено';

  @override
  String hallHonours(String name) {
    return 'Зала вшановує тебе, $name';
  }

  @override
  String get experience => 'Досвід';

  @override
  String get coinsWord => 'Монети';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks тижня на борту!',
      many: '$weeks тижнів на борту!',
      few: '$weeks тижні на борту!',
      one: '$weeks тиждень на борту!',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Серія триває – так тримати.';

  @override
  String get achievementUnlocked => 'Досягнення відкрито';

  @override
  String get continueLabel => 'Далі';

  @override
  String levelReached(String level) {
    return 'Рівень $level досягнуто!';
  }

  @override
  String coinBonus(String mult) {
    return 'Бонус монет ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Було ×$mult – на кожен візит';
  }

  @override
  String get newGear => 'Нове у спорядженні';

  @override
  String get newBackdrop => 'Нове тло';

  @override
  String equipItem(String item) {
    return 'Одягнути: $item';
  }

  @override
  String get later => 'Пізніше';

  @override
  String get shareLevel => 'Поділитися рівнем';

  @override
  String shareLevelText(String level) {
    return 'Мій новий рівень у Valhalla Hero: $level!';
  }

  @override
  String ownedOf(int owned, int total) {
    return 'Є $owned з $total';
  }

  @override
  String get cosmeticOnly => 'Лише вигляд – на гру не впливає';

  @override
  String get heroForm => 'Образ героя';

  @override
  String get heroFormHero => 'Герой';

  @override
  String get heroFormHeroine => 'Героїня';

  @override
  String get heroFormHint => 'Герой чи героїня – прогрес зберігається';

  @override
  String levelOfEight(String roman) {
    return 'Рівень $roman з VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp з $max XP до Вальгалли';
  }

  @override
  String get yourLevel => 'Твій рівень';

  @override
  String get nextUp => 'Далі';

  @override
  String fromXp(String xp) {
    return 'від $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return 'ще $xp XP';
  }

  @override
  String get reached => 'Відкрито';

  @override
  String almostThere(String name) {
    return 'Майже: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Рекорд: $weeks';
  }

  @override
  String get rewardsRedeemed => 'Отримано нагород';

  @override
  String get itemsOwned => 'Спорядження';

  @override
  String get yourBalance => 'Твій баланс';

  @override
  String get coinPurse => 'Гаманець';

  @override
  String coinsExpireSoon(int coins, String date) {
    return 'Монети ($coins) згорять $date';
  }

  @override
  String get redeemBeforeExpiry => 'Витрать їх у магазині до цього.';

  @override
  String get segVouchers => 'Ваучери';

  @override
  String get allRewards => 'Усі нагороди';

  @override
  String missingCoins(String coins) {
    return 'Бракує $coins';
  }

  @override
  String get holdToRedeem => 'Утримуй, щоб отримати';

  @override
  String get holdHint =>
      'Жодних випадкових витрат – підтвердження лише утриманням.';

  @override
  String get priceLabel => 'Ціна';

  @override
  String get balanceAfter => 'Баланс після';

  @override
  String get validLabel => 'Діє';

  @override
  String validDays(int days) {
    return '$days дн. після отримання';
  }

  @override
  String get redeemHow => 'Як отримати';

  @override
  String get showCodeAtBar => 'Покажи код біля стійки';

  @override
  String get noVouchers => 'Поки що немає ваучерів. Обміняй монети на здобич.';

  @override
  String get showThisCode => 'Покажи цей код біля стійки';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'залишилось $days дня',
      many: 'залишилось $days днів',
      few: 'залишилось $days дні',
      one: 'залишився $days день',
    );
    return 'Діє до $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Використано $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Отримано $date · монети: $coins';
  }

  @override
  String get stepShowCode => 'Покажи код';

  @override
  String get stepTeamConfirms => 'Команда підтверджує';

  @override
  String get stepEnjoy => 'Насолоджуйся';

  @override
  String get voucherLiveNote =>
      'Статус оновиться одразу після підтвердження командою.';

  @override
  String expiryInfo(int months) {
    return 'Монети згоряють через $months міс.';
  }

  @override
  String get xpNeverExpires => 'XP не згоряє ніколи';

  @override
  String get coinsNoCash =>
      'Монети – добровільний бонус лояльності без грошової вартості, їх не виплачують.';

  @override
  String get toShop => 'До магазину';

  @override
  String get fameTitle => 'Зала слави';

  @override
  String get allHeroes => 'Усі герої';

  @override
  String get rankHeader => 'МІСЦЕ · ГЕРОЙ';

  @override
  String get yourPosition => 'Твоє місце';

  @override
  String xpToRank(String xp, int rank) {
    return '$xp XP до $rank-го місця';
  }

  @override
  String get alleyTitle => 'Алея безсмертних';

  @override
  String get alleyBody =>
      'Досягни рівня VIII – як Ейнхерій чи Валькірія – і твоя статуя стоятиме тут вічно.';

  @override
  String get alleyFree => 'Поки вільно';

  @override
  String rankInFame(int rank) {
    return '$rank-е місце в Залі слави';
  }

  @override
  String get reportName => 'Поскаржитися на ім’я';

  @override
  String get reportThanks => 'Дякуємо – ми перевіримо.';

  @override
  String get share => 'Поділитися';

  @override
  String get directions => 'Маршрут';

  @override
  String get eventsNews => 'Події та новини';

  @override
  String get optionalRevocable => 'Необов’язково · можна вимкнути будь-коли';

  @override
  String get personalOffers => 'Персональні пропозиції';

  @override
  String get personalOffersCaption => 'Необов’язково · на основі твоїх візитів';

  @override
  String get serviceNotifications => 'Візити та нагороди';

  @override
  String get serviceNotificationsCaption =>
      'Підтвердження, нові рівні, монети, що згоряють';

  @override
  String get alwaysOn => 'Завжди увімк.';

  @override
  String get showInFame => 'Показувати в Залі слави';

  @override
  String get showInFameCaption =>
      'Лише ім’я та образ героя – ніколи твоє справжнє ім’я';

  @override
  String get account => 'Акаунт';

  @override
  String get heroName => 'Ім’я героя';

  @override
  String get editHeroName => 'Змінити ім’я героя';

  @override
  String get teamGroup => 'Команда';

  @override
  String get teamMode => 'Відкрити режим команди';

  @override
  String get teamModeCaption =>
      'Підтверджувати візити, перевіряти фото та ваучери';

  @override
  String get legal => 'Правова інформація';

  @override
  String get terms => 'Умови участі';

  @override
  String get privacyPolicy => 'Політика конфіденційності';

  @override
  String get imprint => 'Вихідні дані (Impressum)';

  @override
  String get myData => 'Мої дані';

  @override
  String get exportCaption => 'JSON-файл з усіма твоїми даними';

  @override
  String get deleteCaption => 'Твої монети та ваучери зникнуть.';

  @override
  String get hornCalls => 'Поклик рогу';

  @override
  String get markAllRead => 'Прочитати всі';

  @override
  String get today => 'Сьогодні';

  @override
  String get earlier => 'Раніше';

  @override
  String get counter => 'Стійка';

  @override
  String get teamModeBadge => 'РЕЖИМ КОМАНДИ';

  @override
  String get exitTeam => 'Вийти';

  @override
  String claimsTab(int count) {
    return 'Візити · $count';
  }

  @override
  String get voucherCheckTab => 'Перевірити ваучер';

  @override
  String get highAmount => 'Велика сума – перевір чек';

  @override
  String get voucherCodeLabel => 'Код ваучера гостя';

  @override
  String get voucherValid => 'Діє';

  @override
  String get voucherUsedHint =>
      'Після цього код використано. Скасувати може лише адмін.';

  @override
  String get welcomeHeadline => 'Кожен візит пише твою сагу.';

  @override
  String get welcomeBody =>
      'Скануй чеки, ділися моментами із зали та обмінюй монети на мерч і ексклюзивні враження.';

  @override
  String get continueWithEmail => 'E-mail';

  @override
  String get adultsOnlyFooter => 'Лише для гостей 18+';

  @override
  String get emailSignInTitle => 'Вхід через e-mail';

  @override
  String get newHereCreate => 'Вперше тут? Створити акаунт';

  @override
  String get beforeYouEnter => 'Перш ніж увійти до зали';

  @override
  String get ageBody =>
      'Valhalla Hero – лише для гостей від 18 років. Дата народження залишається приватною.';

  @override
  String get ageOk => 'Усе гаразд – ласкаво просимо.';

  @override
  String get consentsTitle => 'Згоди';

  @override
  String get eventsNewsConsentCaption =>
      'Push-сповіщення, коли в залі щось відбувається.';

  @override
  String get offersConsentCaption => 'Пропозиції на основі твоїх візитів.';

  @override
  String get consentsFootnote =>
      'Обидва пункти необов’язкові й змінюються в налаштуваннях. Підтвердження візитів приходять завжди.';

  @override
  String stepOf(int step, int total) {
    return 'Крок $step з $total';
  }

  @override
  String get heroAwakes => 'Твій герой прокидається';

  @override
  String get chooseForm =>
      'Обери образ героя. Його можна змінити будь-коли – прогрес збережеться.';

  @override
  String get heroNameLabel => 'Ім’я твого героя';

  @override
  String get heroNameHint =>
      'Видно в Залі слави. Будь ласка, без справжніх імен.';

  @override
  String get startJourney => 'Почати шлях';

  @override
  String get eightLevels => '8 рівнів';

  @override
  String get appTagline => 'Твої візити. Твоя легенда.';

  @override
  String get dayMon => 'ПН';

  @override
  String get dayTue => 'ВТ';

  @override
  String get dayWed => 'СР';

  @override
  String get dayThu => 'ЧТ';

  @override
  String get dayFri => 'ПТ';

  @override
  String get daySat => 'СБ';

  @override
  String get daySun => 'НД';

  @override
  String get comingSoon => 'Незабаром';

  @override
  String get tabEvents => 'Події';

  @override
  String get tabSaga => 'Сага';

  @override
  String get tabScan => 'Додати';

  @override
  String get tonight => 'Сьогодні ввечері';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get liveNow => 'Триває зараз';

  @override
  String get eventsEmpty => 'Поки що подій не заплановано.';

  @override
  String get eventsPast => 'Минулі події';

  @override
  String get catMatch => 'Трансляції';

  @override
  String get catLive => 'Жива музика';

  @override
  String get catQuiz => 'Квіз';

  @override
  String get catParty => 'Вечірка';

  @override
  String get catSpecial => 'Особливе';

  @override
  String get scanTitle => 'Сканувати чек';

  @override
  String get scanHint => 'Наведи камеру на QR-код на чеку.';

  @override
  String get scanFromPhotos => 'З фото';

  @override
  String get scanEnterCode => 'Ввести код';

  @override
  String get scanCodeHint => 'Надрукований під QR-кодом на чеку.';

  @override
  String get scanNoQr => 'Без QR-коду';

  @override
  String get scanDemo => 'Демо-чек';

  @override
  String get scanChecking => 'Перевіряємо чек …';

  @override
  String get torch => 'Світло';

  @override
  String get scanNoCamera => 'Камера недоступна. Обери фото або введи код.';

  @override
  String get scanNothingInImage => 'На зображенні немає QR-коду.';

  @override
  String get scanOnce =>
      'Кожен чек зараховується один раз – XP за візит, монети за сумою.';

  @override
  String get receiptErrUsed => 'Цей чек уже використано.';

  @override
  String get receiptErrInvalid => 'Це не чек Valhalla.';

  @override
  String get receiptErrTooOld => 'Цей чек занадто старий.';

  @override
  String get receiptErrUnknownVenue => 'Цей чек не з бару Valhalla.';

  @override
  String get receiptErrDailyLimit => 'Денний ліміт чеків вичерпано. До завтра!';

  @override
  String get receiptAdded => 'Чек додано';

  @override
  String get receiptAddedHint =>
      'XP нараховується за візит – наступні чеки за день приносять монети.';

  @override
  String get sagaComposerTitle => 'Поділися моментом';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Фото із зали або з мерчем Valhalla · +$xp XP · монети +$coins';
  }

  @override
  String get checkinNewTitle => 'Поділитися фото';

  @override
  String get takePhoto => 'Камера';

  @override
  String get pickPhoto => 'Галерея';

  @override
  String get captionHint => 'Що відбувається в залі?';

  @override
  String get tagEvent => 'Відмітити подію';

  @override
  String get noEvent => 'Без події';

  @override
  String get checkinRules =>
      'Лише фото із зали або з мерчем Valhalla. Команда перевіряє кожне фото, перш ніж воно з’явиться в сазі.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · монети +$coins після схвалення (раз на день)';
  }

  @override
  String get checkinSubmit => 'Надіслати на перевірку';

  @override
  String get checkinPendingTitle => 'Твоє фото на перевірці';

  @override
  String get checkinPendingBody =>
      'Щойно команда його схвалить, воно з’явиться в сазі. До того часу не можна надіслати інше фото.';

  @override
  String get checkinWithdraw => 'Відкликати';

  @override
  String get checkinRejectedTitle => 'Фото не схвалено';

  @override
  String get checkinErrPending => 'У тебе вже є фото на перевірці.';

  @override
  String get sagaEmpty => 'Фото ще немає – почни сагу першим!';

  @override
  String get justNow => 'щойно';

  @override
  String agoMinutes(int minutes) {
    return '$minutes хв тому';
  }

  @override
  String agoHours(int hours) {
    return '$hours год тому';
  }

  @override
  String get photosInSaga => 'Фото в сазі';

  @override
  String teamPhotosTab(int count) {
    return 'Фото · $count';
  }

  @override
  String get teamPhotosEmpty => 'Немає фото на перевірку.';

  @override
  String get approvePhoto => 'Схвалити';

  @override
  String get helpFeedback => 'Допомога та відгуки';

  @override
  String get reportBug => 'Повідомити про помилку';

  @override
  String get reportBugCaption => 'Щось не працює? Напиши нам.';

  @override
  String get bugDescribe => 'Що сталося?';

  @override
  String get bugHint => 'Коротко опиши свої дії та що пішло не так.';

  @override
  String get bugIncludeInfo => 'Додати дані про застосунок і пристрій';

  @override
  String get bugSend => 'Надіслати';

  @override
  String get bugThanks => 'Дякуємо! Вже розбираємося.';

  @override
  String get chooseLanguage => 'Обери мову';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count вподобання',
      many: '$count вподобань',
      few: '$count вподобання',
      one: '$count вподобання',
      zero: 'Ще немає вподобань',
    );
    return '$_temp0';
  }
}
