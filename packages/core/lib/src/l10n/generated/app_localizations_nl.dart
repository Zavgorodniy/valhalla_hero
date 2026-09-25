// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class L10nNl extends L10n {
  L10nNl([String locale = 'nl']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Buit';

  @override
  String get signIn => 'Inloggen';

  @override
  String get signUp => 'Registreren';

  @override
  String get signOut => 'Uitloggen';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Wachtwoord';

  @override
  String get nickname => 'Bijnaam';

  @override
  String get birthDate => 'Geboortedatum';

  @override
  String get ageGateError => 'Je moet minstens 18 jaar oud zijn.';

  @override
  String get continueWithApple => 'Doorgaan met Apple';

  @override
  String get alreadyHaveAccount => 'Heb je al een account?';

  @override
  String get termsAccept =>
      'Ik accepteer de deelnamevoorwaarden en heb het privacybeleid gelezen.';

  @override
  String get createAccount => 'Account aanmaken';

  @override
  String get completeProfile => 'Profiel aanvullen';

  @override
  String authError(String message) {
    return 'Inloggen mislukt: $message';
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
  String get onBoard => 'Aan boord';

  @override
  String visitsCount(int count) {
    return '$count bezoeken';
  }

  @override
  String get claimVisit => 'Bezoek melden';

  @override
  String get claimVisitTitle => 'Bezoek melden';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Je hebt te veel openstaande meldingen.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Mijn meldingen';

  @override
  String get achievements => 'Prestaties';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return '$unlocked van $total ontgrendeld';
  }

  @override
  String get locked => 'Vergrendeld';

  @override
  String get rewards => 'Beloningen';

  @override
  String get gear => 'Uitrusting';

  @override
  String get myVouchers => 'Mijn vouchers';

  @override
  String get redeemed => 'Ingewisseld! Laat deze code aan de bar zien.';

  @override
  String get insufficientCoins => 'Niet genoeg munten.';

  @override
  String get outOfStock => 'Uitverkocht';

  @override
  String stockLeft(int count) {
    return 'Nog $count';
  }

  @override
  String validUntil(String date) {
    return 'Geldig tot $date';
  }

  @override
  String get voucherActive => 'Actief';

  @override
  String get voucherRedeemed => 'Ingewisseld';

  @override
  String get voucherExpired => 'Verlopen';

  @override
  String get voucherCancelled => 'Geannuleerd';

  @override
  String get rewardTypeMerch => 'Merch';

  @override
  String get rewardTypeDrink => 'Drankje';

  @override
  String get rewardTypeDiscount => 'Korting';

  @override
  String get rewardTypePriorityBooking => 'Reservering';

  @override
  String get rewardTypeEventAccess => 'Event';

  @override
  String get owned => 'In bezit';

  @override
  String get equip => 'Uitrusten';

  @override
  String get equipped => 'Uitgerust';

  @override
  String get unequip => 'Afdoen';

  @override
  String get purchaseDone => 'Gekocht. Je kunt het nu uitrusten.';

  @override
  String unlockAtLevel(int level) {
    return 'Vanaf level $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Prestatie: $name';
  }

  @override
  String get unlockByEvent => 'Alleen bij events';

  @override
  String get slotHeadgear => 'Hoofd';

  @override
  String get slotHandItem => 'Hand';

  @override
  String get slotCape => 'Mantel';

  @override
  String get slotCompanion => 'Metgezel';

  @override
  String get slotFrame => 'Lijst';

  @override
  String get rarityCommon => 'Gewoon';

  @override
  String get rarityRare => 'Zeldzaam';

  @override
  String get rarityLegendary => 'Legendarisch';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Jij';

  @override
  String get leaderboardHidden => 'Je bent verborgen in de ranglijst.';

  @override
  String get postTypeNews => 'Nieuws';

  @override
  String get postTypeEvent => 'Event';

  @override
  String get notifications => 'Berichten';

  @override
  String get notificationsEmpty => 'Geen berichten.';

  @override
  String get settings => 'Instellingen';

  @override
  String get language => 'Taal';

  @override
  String get leaderboardVisible => 'Zichtbaar in de ranglijst';

  @override
  String get privacy => 'Privacy';

  @override
  String get exportData => 'Mijn gegevens exporteren';

  @override
  String get exportDataDone => 'Export aangemaakt.';

  @override
  String get deleteAccount => 'Account verwijderen';

  @override
  String get deleteAccountTitle => 'Account echt verwijderen?';

  @override
  String deleteAccountBody(int coins) {
    return 'Alle gegevens, XP en $coins munten worden definitief verwijderd.';
  }

  @override
  String get delete => 'Verwijderen';

  @override
  String get cancel => 'Annuleren';

  @override
  String get confirm => 'Bevestigen';

  @override
  String get save => 'Opslaan';

  @override
  String get close => 'Sluiten';

  @override
  String get gotIt => 'Begrepen';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get staffClaimsEmpty => 'Geen openstaande meldingen.';

  @override
  String get staffApprove => 'Bevestigen';

  @override
  String get staffReject => 'Afwijzen';

  @override
  String get staffRejectReason => 'Reden (optioneel)';

  @override
  String get staffVoucherConfirm => 'Als ingewisseld markeren';

  @override
  String get staffVoucherNotFound => 'Geen voucher met deze code.';

  @override
  String get staffVoucherDone => 'Voucher ingewisseld.';

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
  String get coinReasonVisit => 'Bezoek';

  @override
  String get coinReasonAchievement => 'Prestatie';

  @override
  String get coinReasonManual => 'Bijschrijving team';

  @override
  String get coinReasonReward => 'Beloning';

  @override
  String get coinReasonItem => 'Uitrusting';

  @override
  String get coinReasonExpiry => 'Vervallen';

  @override
  String get coinReasonRefund => 'Terugbetaling';

  @override
  String get tabHero => 'Held';

  @override
  String get heroPath => 'Heldenpad';

  @override
  String get statStreak => 'Reeks';

  @override
  String get statOnBoard => 'Aan boord';

  @override
  String get statVisits => 'Bezoeken';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks weken',
      one: '1 week',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagen',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'Deze week';

  @override
  String get all => 'Alle';

  @override
  String get claimSheetSub => 'Het team aan de bar bevestigt je bezoek.';

  @override
  String get claimWhere => 'Waar ben je?';

  @override
  String get change => 'Wijzigen';

  @override
  String get claimAmountLabel => 'Rekeningbedrag';

  @override
  String get claimAmountHint =>
      'Bepaalt alleen je munten. XP krijg je per bezoek – nooit per euro.';

  @override
  String get claimNoteLabel => 'Opmerking voor het team (optioneel)';

  @override
  String get claimNoteHint => 'bijv. tafel 7';

  @override
  String get claimPreview => 'Na bevestiging krijg je';

  @override
  String streakBonus(int xp) {
    return '+$xp reeksbonus';
  }

  @override
  String get claimSentTitle => 'Bezoek gemeld';

  @override
  String get claimSentBody =>
      'Laat het team deze code zien – dat is het snelst.';

  @override
  String get yourVisitCode => 'Je bezoekcode';

  @override
  String get stepReported => 'Gemeld';

  @override
  String get stepChecking => 'Wordt gecontroleerd';

  @override
  String get stepCheckingSub => 'Meestal binnen 5 minuten';

  @override
  String get stepCredited => 'Bijgeschreven';

  @override
  String get stepCreditedSub => 'XP, reeksbonus en munten';

  @override
  String get hornWillCall => 'We blazen op de hoorn zodra het klaar is.';

  @override
  String get toHall => 'Terug naar de hal';

  @override
  String get claimRejectedTitle => 'Bezoek afgewezen';

  @override
  String get claimRejectedBody => 'Spreek het team aan de bar even aan.';

  @override
  String get visitConfirmed => 'Bezoek bevestigd';

  @override
  String hallHonours(String name) {
    return 'De hal eert je, $name';
  }

  @override
  String get experience => 'Ervaring';

  @override
  String get coinsWord => 'Munten';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks weken aan boord!',
      one: '1 week aan boord',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Reeks behouden – ga zo door.';

  @override
  String get achievementUnlocked => 'Prestatie ontgrendeld';

  @override
  String get continueLabel => 'Verder';

  @override
  String levelReached(String level) {
    return 'Level $level bereikt!';
  }

  @override
  String coinBonus(String mult) {
    return 'Muntbonus ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Eerst ×$mult – bij elk bezoek';
  }

  @override
  String get newGear => 'Nieuw in je uitrusting';

  @override
  String get newBackdrop => 'Nieuwe achtergrond';

  @override
  String equipItem(String item) {
    return '$item uitrusten';
  }

  @override
  String get later => 'Later';

  @override
  String get shareLevel => 'Level-up delen';

  @override
  String shareLevelText(String level) {
    return 'Ik ben net $level geworden in Valhalla Hero!';
  }

  @override
  String ownedOf(int owned, int total) {
    return '$owned van $total in bezit';
  }

  @override
  String get cosmeticOnly => 'Alleen cosmetisch – geen effect op het spel';

  @override
  String get heroForm => 'Heldengedaante';

  @override
  String get heroFormHero => 'Held';

  @override
  String get heroFormHeroine => 'Heldin';

  @override
  String get heroFormHint => 'Held of heldin – je voortgang blijft';

  @override
  String levelOfEight(String roman) {
    return 'Level $roman van VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp van $max XP tot Walhalla';
  }

  @override
  String get yourLevel => 'Jouw level';

  @override
  String get nextUp => 'Hierna';

  @override
  String fromXp(String xp) {
    return 'vanaf $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return 'nog $xp XP';
  }

  @override
  String get reached => 'Ontgrendeld';

  @override
  String almostThere(String name) {
    return 'Bijna: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Record $weeks';
  }

  @override
  String get rewardsRedeemed => 'Beloningen ingewisseld';

  @override
  String get itemsOwned => 'Uitrusting in bezit';

  @override
  String get yourBalance => 'Je saldo';

  @override
  String get coinPurse => 'Muntbuidel';

  @override
  String coinsExpireSoon(int coins, String date) {
    return '$coins munten vervallen op $date';
  }

  @override
  String get redeemBeforeExpiry => 'Besteed ze vóór die tijd in de shop.';

  @override
  String get segVouchers => 'Vouchers';

  @override
  String get allRewards => 'Alle beloningen';

  @override
  String missingCoins(String coins) {
    return 'Je mist nog $coins';
  }

  @override
  String get holdToRedeem => 'Vasthouden om in te wisselen';

  @override
  String get holdHint =>
      'Geen per ongeluk uitgegeven munten – pas bevestigd na vasthouden.';

  @override
  String get priceLabel => 'Prijs';

  @override
  String get balanceAfter => 'Saldo daarna';

  @override
  String get validLabel => 'Geldig';

  @override
  String validDays(int days) {
    return '$days dagen na inwisselen';
  }

  @override
  String get redeemHow => 'Zo wissel je in';

  @override
  String get showCodeAtBar => 'Code aan de bar laten zien';

  @override
  String get noVouchers => 'Nog geen vouchers. Ruil munten voor buit.';

  @override
  String get showThisCode => 'Laat deze code aan de bar zien';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'nog $days dagen',
      one: 'nog 1 dag',
    );
    return 'Geldig tot $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Ingewisseld op $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Ingewisseld op $date · $coins munten';
  }

  @override
  String get stepShowCode => 'Code tonen';

  @override
  String get stepTeamConfirms => 'Team bevestigt';

  @override
  String get stepEnjoy => 'Genieten';

  @override
  String get voucherLiveNote =>
      'De status wordt live bijgewerkt zodra het team bevestigt.';

  @override
  String expiryInfo(int months) {
    return 'Munten vervallen na $months maanden';
  }

  @override
  String get xpNeverExpires => 'XP vervalt nooit';

  @override
  String get coinsNoCash =>
      'Munten zijn een vrijwillige loyaliteitsbonus zonder geldwaarde en worden nooit uitbetaald.';

  @override
  String get toShop => 'Naar de shop';

  @override
  String get fameTitle => 'Hal der Roem';

  @override
  String get allHeroes => 'Alle helden';

  @override
  String get rankHeader => 'RANG · HELD';

  @override
  String get yourPosition => 'Jouw positie';

  @override
  String xpToRank(String xp, int rank) {
    return '$xp XP tot rang $rank';
  }

  @override
  String get alleyTitle => 'Laan der Onsterfelijken';

  @override
  String get alleyBody =>
      'Bereik level VIII – als Einherjar of Valkyrja – en je krijgt hier voor altijd een standbeeld.';

  @override
  String get alleyFree => 'Nog vrij';

  @override
  String rankInFame(int rank) {
    return 'Rang $rank in de Hal der Roem';
  }

  @override
  String get reportName => 'Heldennaam melden';

  @override
  String get reportThanks => 'Bedankt – we kijken ernaar.';

  @override
  String get share => 'Delen';

  @override
  String get directions => 'Route';

  @override
  String get eventsNews => 'Events & nieuws';

  @override
  String get optionalRevocable => 'Optioneel · altijd intrekbaar';

  @override
  String get personalOffers => 'Persoonlijke aanbiedingen';

  @override
  String get personalOffersCaption => 'Optioneel · op basis van je bezoeken';

  @override
  String get serviceNotifications => 'Bezoeken & beloningen';

  @override
  String get serviceNotificationsCaption =>
      'Bevestigingen, level-ups, vervallende munten';

  @override
  String get alwaysOn => 'Altijd aan';

  @override
  String get showInFame => 'Tonen in de Hal der Roem';

  @override
  String get showInFameCaption =>
      'Alleen heldennaam en held – nooit je echte naam';

  @override
  String get account => 'Account';

  @override
  String get heroName => 'Heldennaam';

  @override
  String get editHeroName => 'Heldennaam wijzigen';

  @override
  String get teamGroup => 'Team';

  @override
  String get teamMode => 'Teammodus openen';

  @override
  String get teamModeCaption =>
      'Bezoeken bevestigen, foto’s controleren, vouchers checken';

  @override
  String get legal => 'Juridisch';

  @override
  String get terms => 'Deelnamevoorwaarden';

  @override
  String get privacyPolicy => 'Privacybeleid';

  @override
  String get imprint => 'Colofon (Impressum)';

  @override
  String get myData => 'Mijn gegevens';

  @override
  String get exportCaption => 'JSON-bestand met al je gegevens';

  @override
  String get deleteCaption => 'Je munten en vouchers gaan verloren.';

  @override
  String get hornCalls => 'Hoornsignalen';

  @override
  String get markAllRead => 'Alles gelezen';

  @override
  String get today => 'Vandaag';

  @override
  String get earlier => 'Eerder';

  @override
  String get counter => 'Bar';

  @override
  String get teamModeBadge => 'TEAMMODUS';

  @override
  String get exitTeam => 'Sluiten';

  @override
  String claimsTab(int count) {
    return 'Bezoeken · $count';
  }

  @override
  String get voucherCheckTab => 'Voucher controleren';

  @override
  String get highAmount => 'Hoog bedrag – controleer de bon';

  @override
  String get voucherCodeLabel => 'Vouchercode van de gast';

  @override
  String get voucherValid => 'Geldig';

  @override
  String get voucherUsedHint =>
      'Daarna is de code gebruikt. Alleen admins kunnen dit terugdraaien.';

  @override
  String get welcomeHeadline => 'Elk bezoek schrijft je saga.';

  @override
  String get welcomeBody =>
      'Scan bonnen, deel momenten uit de hal en ruil munten voor merch en exclusieve belevenissen.';

  @override
  String get continueWithEmail => 'E-mail';

  @override
  String get adultsOnlyFooter => 'Alleen voor gasten van 18+';

  @override
  String get emailSignInTitle => 'Inloggen met e-mail';

  @override
  String get newHereCreate => 'Nieuw hier? Account aanmaken';

  @override
  String get beforeYouEnter => 'Voordat je de hal betreedt';

  @override
  String get ageBody =>
      'Valhalla Hero is alleen voor gasten van 18 jaar en ouder. Je geboortedatum blijft privé.';

  @override
  String get ageOk => 'Alles in orde – welkom.';

  @override
  String get consentsTitle => 'Toestemmingen';

  @override
  String get eventsNewsConsentCaption =>
      'Pushberichten als er iets te doen is in de hal.';

  @override
  String get offersConsentCaption => 'Aanbiedingen op basis van je bezoeken.';

  @override
  String get consentsFootnote =>
      'Beide optioneel en altijd te wijzigen in de instellingen. Bevestigingen van je bezoeken krijg je altijd.';

  @override
  String stepOf(int step, int total) {
    return 'Stap $step van $total';
  }

  @override
  String get heroAwakes => 'Je held ontwaakt';

  @override
  String get chooseForm =>
      'Kies je heldengedaante. Altijd te wijzigen – je voortgang blijft.';

  @override
  String get heroNameLabel => 'Naam van je held';

  @override
  String get heroNameHint =>
      'Zichtbaar in de Hal der Roem. Graag geen echte namen.';

  @override
  String get startJourney => 'Begin de reis';

  @override
  String get eightLevels => '8 levels';

  @override
  String get appTagline => 'Jouw bezoeken. Jouw legende.';

  @override
  String get dayMon => 'MA';

  @override
  String get dayTue => 'DI';

  @override
  String get dayWed => 'WO';

  @override
  String get dayThu => 'DO';

  @override
  String get dayFri => 'VR';

  @override
  String get daySat => 'ZA';

  @override
  String get daySun => 'ZO';

  @override
  String get comingSoon => 'Binnenkort';

  @override
  String get tabEvents => 'Events';

  @override
  String get tabSaga => 'Saga';

  @override
  String get tabScan => 'Scannen';

  @override
  String get tonight => 'Vanavond';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get liveNow => 'Nu bezig';

  @override
  String get eventsEmpty => 'Er zijn momenteel geen events gepland.';

  @override
  String get catMatch => 'Live sport';

  @override
  String get catLive => 'Livemuziek';

  @override
  String get catQuiz => 'Quiz';

  @override
  String get catParty => 'Feest';

  @override
  String get catSpecial => 'Speciaal';

  @override
  String get scanTitle => 'Bon scannen';

  @override
  String get scanHint => 'Richt de camera op de QR-code op je bon.';

  @override
  String get scanFromPhotos => 'Uit foto’s';

  @override
  String get scanEnterCode => 'Code invoeren';

  @override
  String get scanCodeHint => 'Staat onder de QR-code op je bon.';

  @override
  String get scanNoQr => 'Melden zonder QR';

  @override
  String get scanDemo => 'Demobon';

  @override
  String get scanChecking => 'Bon wordt gecontroleerd …';

  @override
  String get torch => 'Lamp';

  @override
  String get scanNoCamera =>
      'Geen camera beschikbaar. Kies een foto of voer de code in.';

  @override
  String get scanNothingInImage => 'Geen QR-code gevonden in de afbeelding.';

  @override
  String get scanOnce =>
      'Elke bon telt één keer – XP per bezoek, munten naar bedrag.';

  @override
  String get receiptErrUsed => 'Deze bon is al ingewisseld.';

  @override
  String get receiptErrInvalid => 'Dit is geen geldige Valhalla-bon.';

  @override
  String get receiptErrTooOld => 'Deze bon is te oud.';

  @override
  String get receiptErrUnknownVenue =>
      'Deze bon komt niet van een Valhalla-bar.';

  @override
  String get receiptErrDailyLimit =>
      'Je hebt hier vandaag al een bon ingewisseld. Tot morgen!';

  @override
  String get sagaComposerTitle => 'Deel je moment';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Foto uit de hal of met Valhalla-merch · +$xp XP · +$coins munten';
  }

  @override
  String get checkinNewTitle => 'Foto delen';

  @override
  String get takePhoto => 'Camera';

  @override
  String get pickPhoto => 'Bibliotheek';

  @override
  String get captionHint => 'Wat gebeurt er in de hal?';

  @override
  String get tagEvent => 'Event taggen';

  @override
  String get noEvent => 'Geen event';

  @override
  String get checkinRules =>
      'Alleen foto’s uit de hal of met Valhalla-merch. Het team controleert elke foto voordat hij in de saga verschijnt.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · +$coins munten na goedkeuring (eenmaal per dag)';
  }

  @override
  String get checkinSubmit => 'Ter controle versturen';

  @override
  String get checkinPendingTitle => 'Je foto wordt gecontroleerd';

  @override
  String get checkinPendingBody =>
      'Zodra het team hem goedkeurt, verschijnt hij in de saga. Tot die tijd kun je geen andere foto versturen.';

  @override
  String get checkinWithdraw => 'Intrekken';

  @override
  String get checkinRejectedTitle => 'Foto niet goedgekeurd';

  @override
  String get checkinErrPending =>
      'Je hebt al een foto die wordt gecontroleerd.';

  @override
  String get sagaEmpty => 'Nog geen foto’s. Wees de eerste!';

  @override
  String get justNow => 'zojuist';

  @override
  String agoMinutes(int minutes) {
    return '$minutes min geleden';
  }

  @override
  String agoHours(int hours) {
    return '$hours u geleden';
  }

  @override
  String get photosInSaga => 'Foto’s in de saga';

  @override
  String teamPhotosTab(int count) {
    return 'Foto’s · $count';
  }

  @override
  String get teamPhotosEmpty => 'Geen foto’s te controleren.';

  @override
  String get approvePhoto => 'Goedkeuren';

  @override
  String get helpFeedback => 'Hulp & feedback';

  @override
  String get reportBug => 'Fout melden';

  @override
  String get reportBugCaption => 'Werkt er iets niet? Laat het ons weten.';

  @override
  String get bugDescribe => 'Wat is er gebeurd?';

  @override
  String get bugHint => 'Beschrijf kort wat je deed en wat er misging.';

  @override
  String get bugIncludeInfo => 'App- en apparaatinfo meesturen';

  @override
  String get bugSend => 'Versturen';

  @override
  String get bugThanks => 'Bedankt! We gaan ermee aan de slag.';

  @override
  String get chooseLanguage => 'Kies een taal';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count likes',
      one: '1 like',
      zero: 'Nog geen likes',
    );
    return '$_temp0';
  }
}
