// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class L10nRu extends L10n {
  L10nRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Добыча';

  @override
  String get signIn => 'Войти';

  @override
  String get signUp => 'Регистрация';

  @override
  String get signOut => 'Выйти';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Пароль';

  @override
  String get nickname => 'Никнейм';

  @override
  String get birthDate => 'Дата рождения';

  @override
  String get ageGateError => 'Тебе должно быть не меньше 18 лет.';

  @override
  String get continueWithApple => 'Продолжить с Apple';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get termsAccept =>
      'Я принимаю условия участия и политику конфиденциальности.';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get signupConfirmTitle => 'Подтверди e-mail';

  @override
  String signupConfirmBody(String email) {
    return 'Мы отправили ссылку на $email. Открой её, а затем войди здесь.';
  }

  @override
  String get completeProfile => 'Заполнить профиль';

  @override
  String authError(String message) {
    return 'Не удалось войти: $message';
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
    return 'Визитов: $count';
  }

  @override
  String get claimVisit => 'Отметить визит';

  @override
  String get claimVisitTitle => 'Отметить визит';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Слишком много заявок ждут проверки.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Мои заявки';

  @override
  String get achievements => 'Достижения';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return 'Открыто $unlocked из $total';
  }

  @override
  String get locked => 'Закрыто';

  @override
  String get rewards => 'Награды';

  @override
  String get gear => 'Снаряжение';

  @override
  String get myVouchers => 'Мои ваучеры';

  @override
  String get redeemed => 'Готово! Покажи этот код у стойки.';

  @override
  String get insufficientCoins => 'Недостаточно монет.';

  @override
  String get outOfStock => 'Нет в наличии';

  @override
  String stockLeft(int count) {
    return 'Осталось: $count';
  }

  @override
  String validUntil(String date) {
    return 'Действует до $date';
  }

  @override
  String get voucherActive => 'Активен';

  @override
  String get voucherRedeemed => 'Использован';

  @override
  String get voucherExpired => 'Истёк';

  @override
  String get voucherCancelled => 'Отменён';

  @override
  String get rewardTypeMerch => 'Мерч';

  @override
  String get rewardTypeDrink => 'Напиток';

  @override
  String get rewardTypeDiscount => 'Скидка';

  @override
  String get rewardTypePriorityBooking => 'Бронь';

  @override
  String get rewardTypeEventAccess => 'Событие';

  @override
  String get owned => 'Есть';

  @override
  String get equip => 'Надеть';

  @override
  String get equipped => 'Надето';

  @override
  String get unequip => 'Снять';

  @override
  String get purchaseDone => 'Куплено. Можно сразу надеть.';

  @override
  String unlockAtLevel(int level) {
    return 'С уровня $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Достижение: $name';
  }

  @override
  String get unlockByEvent => 'Только на событиях';

  @override
  String get slotHeadgear => 'Голова';

  @override
  String get slotHandItem => 'Рука';

  @override
  String get slotCape => 'Плащ';

  @override
  String get slotCompanion => 'Спутник';

  @override
  String get slotFrame => 'Рамка';

  @override
  String get rarityCommon => 'Обычный';

  @override
  String get rarityRare => 'Редкий';

  @override
  String get rarityLegendary => 'Легендарный';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Ты';

  @override
  String get leaderboardHidden => 'Твой профиль скрыт в рейтинге.';

  @override
  String get postTypeNews => 'Новости';

  @override
  String get postTypeEvent => 'Событие';

  @override
  String get notifications => 'Сообщения';

  @override
  String get notificationsEmpty => 'Сообщений нет.';

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get leaderboardVisible => 'Показывать в рейтинге';

  @override
  String get privacy => 'Конфиденциальность';

  @override
  String get exportData => 'Экспорт моих данных';

  @override
  String get exportDataDone => 'Экспорт создан.';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountTitle => 'Точно удалить аккаунт?';

  @override
  String deleteAccountBody(int coins) {
    return 'Все данные, XP и монеты ($coins) будут удалены безвозвратно.';
  }

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get save => 'Сохранить';

  @override
  String get close => 'Закрыть';

  @override
  String get gotIt => 'Понятно';

  @override
  String get retry => 'Повторить';

  @override
  String get staffClaimsEmpty => 'Нет заявок на проверку.';

  @override
  String get staffApprove => 'Подтвердить';

  @override
  String get staffReject => 'Отклонить';

  @override
  String get staffRejectReason => 'Причина (необязательно)';

  @override
  String get staffVoucherConfirm => 'Отметить как использованный';

  @override
  String get staffVoucherNotFound => 'Ваучер с таким кодом не найден.';

  @override
  String get staffVoucherDone => 'Ваучер использован.';

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
  String get coinReasonVisit => 'Визит';

  @override
  String get coinReasonAchievement => 'Достижение';

  @override
  String get coinReasonManual => 'Начисление командой';

  @override
  String get coinReasonReward => 'Награда';

  @override
  String get coinReasonItem => 'Снаряжение';

  @override
  String get coinReasonExpiry => 'Сгорание';

  @override
  String get coinReasonRefund => 'Возврат';

  @override
  String get coinReasonCheckin => 'Фото в саге';

  @override
  String get tabHero => 'Герой';

  @override
  String get heroPath => 'Путь героя';

  @override
  String get statStreak => 'Серия';

  @override
  String get statOnBoard => 'На борту';

  @override
  String get statVisits => 'Визиты';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks недели',
      many: '$weeks недель',
      few: '$weeks недели',
      one: '$weeks неделя',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дня',
      many: '$days дней',
      few: '$days дня',
      one: '$days день',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'На этой неделе';

  @override
  String get all => 'Все';

  @override
  String get claimSheetSub => 'Команда бара подтвердит твой визит.';

  @override
  String get claimWhere => 'Где ты?';

  @override
  String get change => 'Изменить';

  @override
  String get claimAmountLabel => 'Сумма чека';

  @override
  String get claimAmountHint =>
      'Влияет только на монеты. XP начисляется за визит – не за евро.';

  @override
  String get claimNoteLabel => 'Заметка для команды (необязательно)';

  @override
  String get claimNoteHint => 'напр. стол 7';

  @override
  String get claimPreview => 'После подтверждения ты получишь';

  @override
  String streakBonus(int xp) {
    return '+$xp бонус за серию';
  }

  @override
  String get claimSentTitle => 'Визит отмечен';

  @override
  String get claimSentBody => 'Покажи этот код команде – так быстрее всего.';

  @override
  String get yourVisitCode => 'Твой код визита';

  @override
  String get stepReported => 'Отправлено';

  @override
  String get stepChecking => 'Проверяется';

  @override
  String get stepCheckingSub => 'Обычно меньше 5 минут';

  @override
  String get stepCredited => 'Начислено';

  @override
  String get stepCreditedSub => 'XP, бонус за серию и монеты';

  @override
  String get hornWillCall => 'Мы протрубим в рог, когда всё будет готово.';

  @override
  String get toHall => 'Назад в зал';

  @override
  String get claimRejectedTitle => 'Визит отклонён';

  @override
  String get claimRejectedBody => 'Коротко поговори с командой у стойки.';

  @override
  String get visitConfirmed => 'Визит подтверждён';

  @override
  String hallHonours(String name) {
    return 'Зал чествует тебя, $name';
  }

  @override
  String get experience => 'Опыт';

  @override
  String get coinsWord => 'Монеты';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks недели на борту!',
      many: '$weeks недель на борту!',
      few: '$weeks недели на борту!',
      one: '$weeks неделя на борту!',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Серия продолжается – так держать.';

  @override
  String get achievementUnlocked => 'Достижение открыто';

  @override
  String get continueLabel => 'Дальше';

  @override
  String levelReached(String level) {
    return 'Уровень $level достигнут!';
  }

  @override
  String coinBonus(String mult) {
    return 'Бонус монет ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Было ×$mult – на каждый визит';
  }

  @override
  String get newGear => 'Новое в снаряжении';

  @override
  String get newBackdrop => 'Новый фон';

  @override
  String equipItem(String item) {
    return 'Надеть: $item';
  }

  @override
  String get later => 'Позже';

  @override
  String get shareLevel => 'Поделиться уровнем';

  @override
  String shareLevelText(String level) {
    return 'Мой новый уровень в Valhalla Hero: $level!';
  }

  @override
  String ownedOf(int owned, int total) {
    return 'Есть $owned из $total';
  }

  @override
  String get cosmeticOnly => 'Только внешний вид – на игру не влияет';

  @override
  String get heroForm => 'Облик героя';

  @override
  String get heroFormHero => 'Герой';

  @override
  String get heroFormHeroine => 'Героиня';

  @override
  String get heroFormHint => 'Герой или героиня – прогресс сохраняется';

  @override
  String levelOfEight(String roman) {
    return 'Уровень $roman из VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp из $max XP до Вальхаллы';
  }

  @override
  String get yourLevel => 'Твой уровень';

  @override
  String get nextUp => 'Далее';

  @override
  String fromXp(String xp) {
    return 'от $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return 'ещё $xp XP';
  }

  @override
  String get reached => 'Открыто';

  @override
  String almostThere(String name) {
    return 'Почти: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Рекорд: $weeks';
  }

  @override
  String get rewardsRedeemed => 'Получено наград';

  @override
  String get itemsOwned => 'Снаряжение';

  @override
  String get yourBalance => 'Твой баланс';

  @override
  String get coinPurse => 'Кошель';

  @override
  String coinsExpireSoon(int coins, String date) {
    return 'Монеты ($coins) сгорят $date';
  }

  @override
  String get redeemBeforeExpiry => 'Потрать их в магазине до этого.';

  @override
  String get segVouchers => 'Ваучеры';

  @override
  String get allRewards => 'Все награды';

  @override
  String missingCoins(String coins) {
    return 'Не хватает $coins';
  }

  @override
  String get holdToRedeem => 'Удерживай, чтобы получить';

  @override
  String get holdHint =>
      'Никаких случайных трат – подтверждение только удержанием.';

  @override
  String get priceLabel => 'Цена';

  @override
  String get balanceAfter => 'Баланс после';

  @override
  String get validLabel => 'Действует';

  @override
  String validDays(int days) {
    return '$days дн. после получения';
  }

  @override
  String get redeemHow => 'Как получить';

  @override
  String get showCodeAtBar => 'Покажи код у стойки';

  @override
  String get noVouchers => 'Пока нет ваучеров. Обменяй монеты на добычу.';

  @override
  String get showThisCode => 'Покажи этот код у стойки';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'осталось $days дня',
      many: 'осталось $days дней',
      few: 'осталось $days дня',
      one: 'остался $days день',
    );
    return 'Действует до $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Использован $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Получен $date · монеты: $coins';
  }

  @override
  String get stepShowCode => 'Покажи код';

  @override
  String get stepTeamConfirms => 'Команда подтверждает';

  @override
  String get stepEnjoy => 'Наслаждайся';

  @override
  String get voucherLiveNote =>
      'Статус обновится сразу после подтверждения командой.';

  @override
  String expiryInfo(int months) {
    return 'Монеты сгорают через $months мес.';
  }

  @override
  String get xpNeverExpires => 'XP не сгорает никогда';

  @override
  String get coinsNoCash =>
      'Монеты – добровольный бонус лояльности без денежной стоимости, они не выплачиваются.';

  @override
  String get toShop => 'В магазин';

  @override
  String get fameTitle => 'Зал славы';

  @override
  String get allHeroes => 'Все герои';

  @override
  String get rankHeader => 'МЕСТО · ГЕРОЙ';

  @override
  String get yourPosition => 'Твоё место';

  @override
  String xpToRank(String xp, int rank) {
    return '$xp XP до $rank-го места';
  }

  @override
  String get alleyTitle => 'Аллея бессмертных';

  @override
  String get alleyBody =>
      'Достигни уровня VIII – как Эйнхерий или Валькирия – и твоя статуя будет стоять здесь вечно.';

  @override
  String get alleyFree => 'Пока свободно';

  @override
  String rankInFame(int rank) {
    return '$rank-е место в Зале славы';
  }

  @override
  String get reportName => 'Пожаловаться на имя';

  @override
  String get reportThanks => 'Спасибо – мы проверим.';

  @override
  String get share => 'Поделиться';

  @override
  String get directions => 'Маршрут';

  @override
  String get eventsNews => 'События и новости';

  @override
  String get optionalRevocable =>
      'Необязательно · можно отключить в любой момент';

  @override
  String get personalOffers => 'Персональные предложения';

  @override
  String get personalOffersCaption => 'Необязательно · на основе твоих визитов';

  @override
  String get serviceNotifications => 'Визиты и награды';

  @override
  String get serviceNotificationsCaption =>
      'Подтверждения, новые уровни, сгорающие монеты';

  @override
  String get alwaysOn => 'Всегда вкл.';

  @override
  String get showInFame => 'Показывать в Зале славы';

  @override
  String get showInFameCaption =>
      'Только имя и облик героя – никогда твоё настоящее имя';

  @override
  String get account => 'Аккаунт';

  @override
  String get heroName => 'Имя героя';

  @override
  String get editHeroName => 'Изменить имя героя';

  @override
  String get teamGroup => 'Команда';

  @override
  String get teamMode => 'Открыть режим команды';

  @override
  String get teamModeCaption => 'Подтверждать визиты, проверять фото и ваучеры';

  @override
  String get legal => 'Правовая информация';

  @override
  String get terms => 'Условия участия';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get imprint => 'Выходные данные (Impressum)';

  @override
  String get myData => 'Мои данные';

  @override
  String get exportCaption => 'JSON-файл со всеми твоими данными';

  @override
  String get deleteCaption => 'Твои монеты и ваучеры пропадут.';

  @override
  String get hornCalls => 'Зов рога';

  @override
  String get markAllRead => 'Прочитать все';

  @override
  String get today => 'Сегодня';

  @override
  String get earlier => 'Ранее';

  @override
  String get counter => 'Стойка';

  @override
  String get teamModeBadge => 'РЕЖИМ КОМАНДЫ';

  @override
  String get exitTeam => 'Выйти';

  @override
  String claimsTab(int count) {
    return 'Визиты · $count';
  }

  @override
  String get voucherCheckTab => 'Проверить ваучер';

  @override
  String get highAmount => 'Большая сумма – проверь чек';

  @override
  String get voucherCodeLabel => 'Код ваучера гостя';

  @override
  String get voucherValid => 'Действует';

  @override
  String get voucherUsedHint =>
      'После этого код использован. Отменить может только админ.';

  @override
  String get welcomeHeadline => 'Каждый визит пишет твою сагу.';

  @override
  String get welcomeBody =>
      'Сканируй чеки, делись моментами из зала и обменивай монеты на мерч и эксклюзивные впечатления.';

  @override
  String get continueWithEmail => 'E-mail';

  @override
  String get adultsOnlyFooter => 'Только для гостей 18+';

  @override
  String get emailSignInTitle => 'Вход по e-mail';

  @override
  String get newHereCreate => 'Впервые здесь? Создать аккаунт';

  @override
  String get beforeYouEnter => 'Прежде чем войти в зал';

  @override
  String get ageBody =>
      'Valhalla Hero – только для гостей от 18 лет. Дата рождения остаётся приватной.';

  @override
  String get ageOk => 'Всё в порядке – добро пожаловать.';

  @override
  String get consentsTitle => 'Согласия';

  @override
  String get eventsNewsConsentCaption =>
      'Push-уведомления, когда в зале что-то происходит.';

  @override
  String get offersConsentCaption => 'Предложения на основе твоих визитов.';

  @override
  String get consentsFootnote =>
      'Оба пункта необязательны и меняются в настройках. Подтверждения визитов приходят всегда.';

  @override
  String stepOf(int step, int total) {
    return 'Шаг $step из $total';
  }

  @override
  String get heroAwakes => 'Твой герой пробуждается';

  @override
  String get chooseForm =>
      'Выбери облик героя. Его можно сменить в любой момент – прогресс сохранится.';

  @override
  String get heroNameLabel => 'Имя твоего героя';

  @override
  String get heroNameHint =>
      'Видно в Зале славы. Пожалуйста, без настоящих имён.';

  @override
  String get startJourney => 'Начать путь';

  @override
  String get eightLevels => '8 уровней';

  @override
  String get appTagline => 'Твои визиты. Твоя легенда.';

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
  String get daySun => 'ВС';

  @override
  String get comingSoon => 'Скоро';

  @override
  String get tabEvents => 'События';

  @override
  String get tabSaga => 'Сага';

  @override
  String get tabScan => 'Добавить';

  @override
  String get tonight => 'Сегодня вечером';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get liveNow => 'Идёт сейчас';

  @override
  String get eventsEmpty => 'Пока событий не запланировано.';

  @override
  String get eventsPast => 'Прошедшие события';

  @override
  String get catMatch => 'Трансляции';

  @override
  String get catLive => 'Живая музыка';

  @override
  String get catQuiz => 'Квиз';

  @override
  String get catParty => 'Вечеринка';

  @override
  String get catSpecial => 'Особое';

  @override
  String get scanTitle => 'Сканировать чек';

  @override
  String get scanHint => 'Наведи камеру на QR-код на чеке.';

  @override
  String get scanFromPhotos => 'Из фото';

  @override
  String get scanEnterCode => 'Ввести код';

  @override
  String get scanCodeHint => 'Напечатан под QR-кодом на чеке.';

  @override
  String get scanNoQr => 'Без QR-кода';

  @override
  String get scanDemo => 'Демо-чек';

  @override
  String get scanChecking => 'Проверяем чек …';

  @override
  String get torch => 'Свет';

  @override
  String get scanNoCamera => 'Камера недоступна. Выбери фото или введи код.';

  @override
  String get scanNothingInImage => 'На изображении нет QR-кода.';

  @override
  String get scanOnce =>
      'Каждый чек засчитывается один раз – XP за визит, монеты по сумме.';

  @override
  String get receiptErrUsed => 'Этот чек уже использован.';

  @override
  String get receiptErrInvalid => 'Это не чек Valhalla.';

  @override
  String get receiptErrTooOld => 'Этот чек слишком старый.';

  @override
  String get receiptErrUnknownVenue => 'Этот чек не из бара Valhalla.';

  @override
  String get receiptErrDailyLimit => 'Дневной лимит чеков исчерпан. До завтра!';

  @override
  String get receiptAdded => 'Чек добавлен';

  @override
  String get receiptAddedHint =>
      'XP начисляется за визит – следующие чеки за день приносят монеты.';

  @override
  String get sagaComposerTitle => 'Поделись моментом';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Фото из зала или с мерчем Valhalla · +$xp XP · монеты +$coins';
  }

  @override
  String get checkinNewTitle => 'Поделиться фото';

  @override
  String get takePhoto => 'Камера';

  @override
  String get pickPhoto => 'Галерея';

  @override
  String get captionHint => 'Что происходит в зале?';

  @override
  String get tagEvent => 'Отметить событие';

  @override
  String get noEvent => 'Без события';

  @override
  String get checkinRules =>
      'Только фото из зала или с мерчем Valhalla. Команда проверяет каждое фото, прежде чем оно появится в саге.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · монеты +$coins после одобрения (раз в день)';
  }

  @override
  String get checkinSubmit => 'Отправить на проверку';

  @override
  String get checkinPendingTitle => 'Твоё фото на проверке';

  @override
  String get checkinPendingBody =>
      'Как только команда его одобрит, оно появится в саге. До тех пор нельзя отправить другое фото.';

  @override
  String get checkinWithdraw => 'Отозвать';

  @override
  String get checkinRejectedTitle => 'Фото не одобрено';

  @override
  String get checkinErrPending => 'У тебя уже есть фото на проверке.';

  @override
  String get sagaEmpty => 'Фото пока нет – начни сагу первым!';

  @override
  String get justNow => 'только что';

  @override
  String agoMinutes(int minutes) {
    return '$minutes мин назад';
  }

  @override
  String agoHours(int hours) {
    return '$hours ч назад';
  }

  @override
  String get photosInSaga => 'Фото в саге';

  @override
  String teamPhotosTab(int count) {
    return 'Фото · $count';
  }

  @override
  String get teamPhotosEmpty => 'Нет фото на проверку.';

  @override
  String get approvePhoto => 'Одобрить';

  @override
  String get helpFeedback => 'Помощь и отзывы';

  @override
  String get reportBug => 'Сообщить об ошибке';

  @override
  String get reportBugCaption => 'Что-то не работает? Напиши нам.';

  @override
  String get bugDescribe => 'Что случилось?';

  @override
  String get bugHint => 'Кратко опиши свои действия и что пошло не так.';

  @override
  String get bugIncludeInfo => 'Приложить данные о приложении и устройстве';

  @override
  String get bugSend => 'Отправить';

  @override
  String get bugThanks => 'Спасибо! Уже разбираемся.';

  @override
  String get chooseLanguage => 'Выбери язык';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count лайка',
      many: '$count лайков',
      few: '$count лайка',
      one: '$count лайк',
      zero: 'Пока нет лайков',
    );
    return '$_temp0';
  }
}
