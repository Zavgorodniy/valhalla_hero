// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class L10nPl extends L10n {
  L10nPl([String locale = 'pl']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Łupy';

  @override
  String get signIn => 'Zaloguj się';

  @override
  String get signUp => 'Zarejestruj się';

  @override
  String get signOut => 'Wyloguj się';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Hasło';

  @override
  String get nickname => 'Pseudonim';

  @override
  String get birthDate => 'Data urodzenia';

  @override
  String get ageGateError => 'Musisz mieć co najmniej 18 lat.';

  @override
  String get continueWithApple => 'Kontynuuj z Apple';

  @override
  String get alreadyHaveAccount => 'Masz już konto?';

  @override
  String get termsAccept => 'Akceptuję warunki udziału i politykę prywatności.';

  @override
  String get createAccount => 'Utwórz konto';

  @override
  String get completeProfile => 'Uzupełnij profil';

  @override
  String authError(String message) {
    return 'Logowanie nie powiodło się: $message';
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
  String get onBoard => 'Na pokładzie';

  @override
  String visitsCount(int count) {
    return 'Wizyty: $count';
  }

  @override
  String get claimVisit => 'Zgłoś wizytę';

  @override
  String get claimVisitTitle => 'Zgłoś wizytę';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Masz zbyt wiele oczekujących zgłoszeń.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Moje zgłoszenia';

  @override
  String get achievements => 'Osiągnięcia';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return 'Odblokowano $unlocked z $total';
  }

  @override
  String get locked => 'Zablokowane';

  @override
  String get rewards => 'Nagrody';

  @override
  String get gear => 'Ekwipunek';

  @override
  String get myVouchers => 'Moje vouchery';

  @override
  String get redeemed => 'Gotowe! Pokaż ten kod przy barze.';

  @override
  String get insufficientCoins => 'Za mało monet.';

  @override
  String get outOfStock => 'Wyprzedane';

  @override
  String stockLeft(int count) {
    return 'Zostało: $count';
  }

  @override
  String validUntil(String date) {
    return 'Ważny do $date';
  }

  @override
  String get voucherActive => 'Aktywny';

  @override
  String get voucherRedeemed => 'Wykorzystany';

  @override
  String get voucherExpired => 'Wygasły';

  @override
  String get voucherCancelled => 'Anulowany';

  @override
  String get rewardTypeMerch => 'Merch';

  @override
  String get rewardTypeDrink => 'Napój';

  @override
  String get rewardTypeDiscount => 'Rabat';

  @override
  String get rewardTypePriorityBooking => 'Rezerwacja';

  @override
  String get rewardTypeEventAccess => 'Wydarzenie';

  @override
  String get owned => 'Posiadane';

  @override
  String get equip => 'Załóż';

  @override
  String get equipped => 'Założone';

  @override
  String get unequip => 'Zdejmij';

  @override
  String get purchaseDone => 'Kupione. Możesz to od razu założyć.';

  @override
  String unlockAtLevel(int level) {
    return 'Od poziomu $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Osiągnięcie: $name';
  }

  @override
  String get unlockByEvent => 'Tylko na wydarzeniach';

  @override
  String get slotHeadgear => 'Głowa';

  @override
  String get slotHandItem => 'Dłoń';

  @override
  String get slotCape => 'Peleryna';

  @override
  String get slotCompanion => 'Towarzysz';

  @override
  String get slotFrame => 'Ramka';

  @override
  String get rarityCommon => 'Zwykły';

  @override
  String get rarityRare => 'Rzadki';

  @override
  String get rarityLegendary => 'Legendarny';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Ty';

  @override
  String get leaderboardHidden => 'Twój profil jest ukryty w rankingu.';

  @override
  String get postTypeNews => 'Aktualności';

  @override
  String get postTypeEvent => 'Wydarzenie';

  @override
  String get notifications => 'Wiadomości';

  @override
  String get notificationsEmpty => 'Brak wiadomości.';

  @override
  String get settings => 'Ustawienia';

  @override
  String get language => 'Język';

  @override
  String get leaderboardVisible => 'Widoczność w rankingu';

  @override
  String get privacy => 'Prywatność';

  @override
  String get exportData => 'Eksportuj moje dane';

  @override
  String get exportDataDone => 'Eksport utworzony.';

  @override
  String get deleteAccount => 'Usuń konto';

  @override
  String get deleteAccountTitle => 'Na pewno usunąć konto?';

  @override
  String deleteAccountBody(int coins) {
    return 'Wszystkie dane, XP i monety ($coins) zostaną trwale usunięte.';
  }

  @override
  String get delete => 'Usuń';

  @override
  String get cancel => 'Anuluj';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get save => 'Zapisz';

  @override
  String get close => 'Zamknij';

  @override
  String get gotIt => 'Rozumiem';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get staffClaimsEmpty => 'Brak zgłoszeń do sprawdzenia.';

  @override
  String get staffApprove => 'Potwierdź';

  @override
  String get staffReject => 'Odrzuć';

  @override
  String get staffRejectReason => 'Powód (opcjonalnie)';

  @override
  String get staffVoucherConfirm => 'Oznacz jako wykorzystany';

  @override
  String get staffVoucherNotFound => 'Nie znaleziono vouchera o tym kodzie.';

  @override
  String get staffVoucherDone => 'Voucher wykorzystany.';

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
  String get coinReasonVisit => 'Wizyta';

  @override
  String get coinReasonAchievement => 'Osiągnięcie';

  @override
  String get coinReasonManual => 'Przyznane przez zespół';

  @override
  String get coinReasonReward => 'Nagroda';

  @override
  String get coinReasonItem => 'Ekwipunek';

  @override
  String get coinReasonExpiry => 'Wygaśnięcie';

  @override
  String get coinReasonRefund => 'Zwrot';

  @override
  String get tabHero => 'Bohater';

  @override
  String get heroPath => 'Ścieżka bohatera';

  @override
  String get statStreak => 'Seria';

  @override
  String get statOnBoard => 'Na pokładzie';

  @override
  String get statVisits => 'Wizyty';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks tygodnia',
      many: '$weeks tygodni',
      few: '$weeks tygodnie',
      one: '$weeks tydzień',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dnia',
      many: '$days dni',
      few: '$days dni',
      one: '$days dzień',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'W tym tygodniu';

  @override
  String get all => 'Wszystkie';

  @override
  String get claimSheetSub => 'Zespół baru potwierdzi Twoją wizytę.';

  @override
  String get claimWhere => 'Gdzie jesteś?';

  @override
  String get change => 'Zmień';

  @override
  String get claimAmountLabel => 'Kwota rachunku';

  @override
  String get claimAmountHint =>
      'Wpływa tylko na monety. XP jest za wizytę – nigdy za euro.';

  @override
  String get claimNoteLabel => 'Notatka dla zespołu (opcjonalnie)';

  @override
  String get claimNoteHint => 'np. stolik 7';

  @override
  String get claimPreview => 'Po potwierdzeniu otrzymasz';

  @override
  String streakBonus(int xp) {
    return '+$xp bonus za serię';
  }

  @override
  String get claimSentTitle => 'Wizyta zgłoszona';

  @override
  String get claimSentBody => 'Pokaż ten kod zespołowi – tak jest najszybciej.';

  @override
  String get yourVisitCode => 'Twój kod wizyty';

  @override
  String get stepReported => 'Zgłoszono';

  @override
  String get stepChecking => 'Sprawdzanie';

  @override
  String get stepCheckingSub => 'Zwykle poniżej 5 minut';

  @override
  String get stepCredited => 'Zaksięgowano';

  @override
  String get stepCreditedSub => 'XP, bonus za serię i monety';

  @override
  String get hornWillCall => 'Zadmiemy w róg, gdy będzie gotowe.';

  @override
  String get toHall => 'Wróć do sali';

  @override
  String get claimRejectedTitle => 'Wizyta odrzucona';

  @override
  String get claimRejectedBody => 'Zamień krótko słowo z zespołem przy barze.';

  @override
  String get visitConfirmed => 'Wizyta potwierdzona';

  @override
  String hallHonours(String name) {
    return 'Sala oddaje Ci cześć, $name';
  }

  @override
  String get experience => 'Doświadczenie';

  @override
  String get coinsWord => 'Monety';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks tygodnia na pokładzie!',
      many: '$weeks tygodni na pokładzie!',
      few: '$weeks tygodnie na pokładzie!',
      one: '$weeks tydzień na pokładzie!',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Seria trwa – tak trzymaj.';

  @override
  String get achievementUnlocked => 'Osiągnięcie odblokowane';

  @override
  String get continueLabel => 'Dalej';

  @override
  String levelReached(String level) {
    return 'Poziom $level osiągnięty!';
  }

  @override
  String coinBonus(String mult) {
    return 'Bonus monet ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Wcześniej ×$mult – przy każdej wizycie';
  }

  @override
  String get newGear => 'Nowość w ekwipunku';

  @override
  String get newBackdrop => 'Nowe tło';

  @override
  String equipItem(String item) {
    return 'Załóż: $item';
  }

  @override
  String get later => 'Później';

  @override
  String get shareLevel => 'Udostępnij awans';

  @override
  String shareLevelText(String level) {
    return 'Mój nowy poziom w Valhalla Hero: $level!';
  }

  @override
  String ownedOf(int owned, int total) {
    return 'Posiadane: $owned z $total';
  }

  @override
  String get cosmeticOnly => 'Tylko wygląd – bez wpływu na grę';

  @override
  String get heroForm => 'Postać';

  @override
  String get heroFormHero => 'Bohater';

  @override
  String get heroFormHeroine => 'Bohaterka';

  @override
  String get heroFormHint => 'Bohater czy bohaterka – postęp zostaje';

  @override
  String levelOfEight(String roman) {
    return 'Poziom $roman z VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp z $max XP do Valhalli';
  }

  @override
  String get yourLevel => 'Twój poziom';

  @override
  String get nextUp => 'Następny';

  @override
  String fromXp(String xp) {
    return 'od $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return 'jeszcze $xp XP';
  }

  @override
  String get reached => 'Odblokowane';

  @override
  String almostThere(String name) {
    return 'Prawie: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Rekord: $weeks';
  }

  @override
  String get rewardsRedeemed => 'Odebrane nagrody';

  @override
  String get itemsOwned => 'Ekwipunek';

  @override
  String get yourBalance => 'Twoje saldo';

  @override
  String get coinPurse => 'Sakiewka';

  @override
  String coinsExpireSoon(int coins, String date) {
    return 'Monety ($coins) wygasną $date';
  }

  @override
  String get redeemBeforeExpiry => 'Wydaj je wcześniej w sklepie.';

  @override
  String get segVouchers => 'Vouchery';

  @override
  String get allRewards => 'Wszystkie nagrody';

  @override
  String missingCoins(String coins) {
    return 'Brakuje $coins';
  }

  @override
  String get holdToRedeem => 'Przytrzymaj, aby odebrać';

  @override
  String get holdHint =>
      'Bez przypadkowych wydatków – potwierdzenie tylko przytrzymaniem.';

  @override
  String get priceLabel => 'Cena';

  @override
  String get balanceAfter => 'Saldo po';

  @override
  String get validLabel => 'Ważność';

  @override
  String validDays(int days) {
    return '$days dni od odebrania';
  }

  @override
  String get redeemHow => 'Jak odebrać';

  @override
  String get showCodeAtBar => 'Pokaż kod przy barze';

  @override
  String get noVouchers => 'Brak voucherów. Wymień monety na łupy.';

  @override
  String get showThisCode => 'Pokaż ten kod przy barze';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'zostało $days dnia',
      many: 'zostało $days dni',
      few: 'zostały $days dni',
      one: 'został $days dzień',
    );
    return 'Ważny do $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Wykorzystano $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Odebrano $date · monety: $coins';
  }

  @override
  String get stepShowCode => 'Pokaż kod';

  @override
  String get stepTeamConfirms => 'Zespół potwierdza';

  @override
  String get stepEnjoy => 'Ciesz się';

  @override
  String get voucherLiveNote =>
      'Status zaktualizuje się, gdy tylko zespół potwierdzi.';

  @override
  String expiryInfo(int months) {
    return 'Monety wygasają po $months mies.';
  }

  @override
  String get xpNeverExpires => 'XP nigdy nie wygasa';

  @override
  String get coinsNoCash =>
      'Monety to dobrowolny bonus lojalnościowy bez wartości pieniężnej i nigdy nie są wypłacane.';

  @override
  String get toShop => 'Do sklepu';

  @override
  String get fameTitle => 'Galeria sław';

  @override
  String get allHeroes => 'Wszyscy bohaterowie';

  @override
  String get rankHeader => 'MIEJSCE · BOHATER';

  @override
  String get yourPosition => 'Twoje miejsce';

  @override
  String xpToRank(String xp, int rank) {
    return '$xp XP do miejsca $rank';
  }

  @override
  String get alleyTitle => 'Aleja Nieśmiertelnych';

  @override
  String get alleyBody =>
      'Osiągnij poziom VIII – jako Einherjar lub Walkiria – a Twój posąg stanie tu na zawsze.';

  @override
  String get alleyFree => 'Jeszcze wolne';

  @override
  String rankInFame(int rank) {
    return 'Miejsce $rank w Galerii sław';
  }

  @override
  String get reportName => 'Zgłoś imię bohatera';

  @override
  String get reportThanks => 'Dzięki – sprawdzimy to.';

  @override
  String get share => 'Udostępnij';

  @override
  String get directions => 'Trasa';

  @override
  String get eventsNews => 'Wydarzenia i aktualności';

  @override
  String get optionalRevocable =>
      'Opcjonalnie · możesz wyłączyć w każdej chwili';

  @override
  String get personalOffers => 'Oferty osobiste';

  @override
  String get personalOffersCaption => 'Opcjonalnie · na podstawie Twoich wizyt';

  @override
  String get serviceNotifications => 'Wizyty i nagrody';

  @override
  String get serviceNotificationsCaption =>
      'Potwierdzenia, awanse, wygasające monety';

  @override
  String get alwaysOn => 'Zawsze wł.';

  @override
  String get showInFame => 'Pokazuj w Galerii sław';

  @override
  String get showInFameCaption =>
      'Tylko imię i postać bohatera – nigdy Twoje prawdziwe imię';

  @override
  String get account => 'Konto';

  @override
  String get heroName => 'Imię bohatera';

  @override
  String get editHeroName => 'Zmień imię bohatera';

  @override
  String get teamGroup => 'Zespół';

  @override
  String get teamMode => 'Otwórz tryb zespołu';

  @override
  String get teamModeCaption =>
      'Potwierdzaj wizyty, sprawdzaj zdjęcia i vouchery';

  @override
  String get legal => 'Informacje prawne';

  @override
  String get terms => 'Warunki udziału';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get imprint => 'Nota prawna (Impressum)';

  @override
  String get myData => 'Moje dane';

  @override
  String get exportCaption => 'Plik JSON ze wszystkimi Twoimi danymi';

  @override
  String get deleteCaption => 'Twoje monety i vouchery przepadną.';

  @override
  String get hornCalls => 'Zew rogu';

  @override
  String get markAllRead => 'Oznacz wszystkie jako przeczytane';

  @override
  String get today => 'Dziś';

  @override
  String get earlier => 'Wcześniej';

  @override
  String get counter => 'Bar';

  @override
  String get teamModeBadge => 'TRYB ZESPOŁU';

  @override
  String get exitTeam => 'Wyjdź';

  @override
  String claimsTab(int count) {
    return 'Wizyty · $count';
  }

  @override
  String get voucherCheckTab => 'Sprawdź voucher';

  @override
  String get highAmount => 'Wysoka kwota – sprawdź rachunek';

  @override
  String get voucherCodeLabel => 'Kod vouchera gościa';

  @override
  String get voucherValid => 'Ważny';

  @override
  String get voucherUsedHint =>
      'Potem kod jest wykorzystany. Cofnąć to może tylko admin.';

  @override
  String get welcomeHeadline => 'Każda wizyta pisze Twoją sagę.';

  @override
  String get welcomeBody =>
      'Skanuj rachunki, dziel się chwilami z sali i wymieniaj monety na merch i wyjątkowe przeżycia.';

  @override
  String get continueWithEmail => 'E-mail';

  @override
  String get adultsOnlyFooter => 'Tylko dla gości 18+';

  @override
  String get emailSignInTitle => 'Logowanie e-mailem';

  @override
  String get newHereCreate => 'Pierwszy raz tutaj? Utwórz konto';

  @override
  String get beforeYouEnter => 'Zanim wejdziesz do sali';

  @override
  String get ageBody =>
      'Valhalla Hero jest tylko dla gości od 18 lat. Twoja data urodzenia pozostaje prywatna.';

  @override
  String get ageOk => 'Wszystko gra – witaj.';

  @override
  String get consentsTitle => 'Zgody';

  @override
  String get eventsNewsConsentCaption =>
      'Powiadomienia push, gdy w sali coś się dzieje.';

  @override
  String get offersConsentCaption => 'Oferty na podstawie Twoich wizyt.';

  @override
  String get consentsFootnote =>
      'Obie są opcjonalne i możesz je zmienić w ustawieniach. Potwierdzenia wizyt dostajesz zawsze.';

  @override
  String stepOf(int step, int total) {
    return 'Krok $step z $total';
  }

  @override
  String get heroAwakes => 'Twój bohater się budzi';

  @override
  String get chooseForm =>
      'Wybierz postać. Możesz ją zmienić w każdej chwili – postęp zostaje.';

  @override
  String get heroNameLabel => 'Imię Twojego bohatera';

  @override
  String get heroNameHint =>
      'Widoczne w Galerii sław. Prosimy bez prawdziwych imion.';

  @override
  String get startJourney => 'Rozpocznij podróż';

  @override
  String get eightLevels => '8 poziomów';

  @override
  String get appTagline => 'Twoje wizyty. Twoja legenda.';

  @override
  String get dayMon => 'PN';

  @override
  String get dayTue => 'WT';

  @override
  String get dayWed => 'ŚR';

  @override
  String get dayThu => 'CZW';

  @override
  String get dayFri => 'PT';

  @override
  String get daySat => 'SOB';

  @override
  String get daySun => 'ND';

  @override
  String get comingSoon => 'Wkrótce';

  @override
  String get tabEvents => 'Wydarzenia';

  @override
  String get tabSaga => 'Saga';

  @override
  String get tabScan => 'Skanuj';

  @override
  String get tonight => 'Dziś wieczorem';

  @override
  String get tomorrow => 'Jutro';

  @override
  String get liveNow => 'Trwa teraz';

  @override
  String get eventsEmpty => 'Obecnie brak zaplanowanych wydarzeń.';

  @override
  String get catMatch => 'Sport na żywo';

  @override
  String get catLive => 'Muzyka na żywo';

  @override
  String get catQuiz => 'Quiz';

  @override
  String get catParty => 'Impreza';

  @override
  String get catSpecial => 'Specjalne';

  @override
  String get scanTitle => 'Skanuj rachunek';

  @override
  String get scanHint => 'Skieruj aparat na kod QR na rachunku.';

  @override
  String get scanFromPhotos => 'Ze zdjęć';

  @override
  String get scanEnterCode => 'Wpisz kod';

  @override
  String get scanCodeHint => 'Wydrukowany pod kodem QR na rachunku.';

  @override
  String get scanNoQr => 'Bez kodu QR';

  @override
  String get scanDemo => 'Rachunek demo';

  @override
  String get scanChecking => 'Sprawdzanie rachunku …';

  @override
  String get torch => 'Latarka';

  @override
  String get scanNoCamera =>
      'Aparat niedostępny. Wybierz zdjęcie lub wpisz kod.';

  @override
  String get scanNothingInImage => 'Na zdjęciu nie znaleziono kodu QR.';

  @override
  String get scanOnce =>
      'Każdy rachunek liczy się raz – XP za wizytę, monety według kwoty.';

  @override
  String get receiptErrUsed => 'Ten rachunek został już wykorzystany.';

  @override
  String get receiptErrInvalid => 'To nie jest rachunek Valhalla.';

  @override
  String get receiptErrTooOld => 'Ten rachunek jest za stary.';

  @override
  String get receiptErrUnknownVenue =>
      'Ten rachunek nie pochodzi z baru Valhalla.';

  @override
  String get receiptErrDailyLimit =>
      'Dziś już zaliczono tu Twój rachunek. Do jutra!';

  @override
  String get sagaComposerTitle => 'Podziel się chwilą';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Zdjęcie z sali lub z merchem Valhalla · +$xp XP · monety +$coins';
  }

  @override
  String get checkinNewTitle => 'Udostępnij zdjęcie';

  @override
  String get takePhoto => 'Aparat';

  @override
  String get pickPhoto => 'Galeria';

  @override
  String get captionHint => 'Co się dzieje w sali?';

  @override
  String get tagEvent => 'Oznacz wydarzenie';

  @override
  String get noEvent => 'Bez wydarzenia';

  @override
  String get checkinRules =>
      'Tylko zdjęcia z sali lub z merchem Valhalla. Zespół sprawdza każde zdjęcie, zanim pojawi się w sadze.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · monety +$coins po akceptacji (raz dziennie)';
  }

  @override
  String get checkinSubmit => 'Wyślij do sprawdzenia';

  @override
  String get checkinPendingTitle => 'Twoje zdjęcie jest sprawdzane';

  @override
  String get checkinPendingBody =>
      'Gdy tylko zespół je zaakceptuje, pojawi się w sadze. Do tego czasu nie możesz wysłać kolejnego.';

  @override
  String get checkinWithdraw => 'Wycofaj';

  @override
  String get checkinRejectedTitle => 'Zdjęcie nie zostało zaakceptowane';

  @override
  String get checkinErrPending => 'Masz już zdjęcie w trakcie sprawdzania.';

  @override
  String get sagaEmpty => 'Jeszcze brak zdjęć – rozpocznij sagę!';

  @override
  String get justNow => 'przed chwilą';

  @override
  String agoMinutes(int minutes) {
    return '$minutes min temu';
  }

  @override
  String agoHours(int hours) {
    return '$hours godz. temu';
  }

  @override
  String get photosInSaga => 'Zdjęcia w sadze';

  @override
  String teamPhotosTab(int count) {
    return 'Zdjęcia · $count';
  }

  @override
  String get teamPhotosEmpty => 'Brak zdjęć do sprawdzenia.';

  @override
  String get approvePhoto => 'Akceptuj';

  @override
  String get helpFeedback => 'Pomoc i opinie';

  @override
  String get reportBug => 'Zgłoś błąd';

  @override
  String get reportBugCaption => 'Coś nie działa? Daj nam znać.';

  @override
  String get bugDescribe => 'Co się stało?';

  @override
  String get bugHint => 'Krótko opisz, co robiłeś/aś i co poszło nie tak.';

  @override
  String get bugIncludeInfo => 'Dołącz informacje o aplikacji i urządzeniu';

  @override
  String get bugSend => 'Wyślij';

  @override
  String get bugThanks => 'Dzięki! Zajmujemy się tym.';

  @override
  String get chooseLanguage => 'Wybierz język';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count polubienia',
      many: '$count polubień',
      few: '$count polubienia',
      one: '$count polubienie',
      zero: 'Brak polubień',
    );
    return '$_temp0';
  }
}
