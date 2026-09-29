// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class L10nDe extends L10n {
  L10nDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Beute';

  @override
  String get signIn => 'Anmelden';

  @override
  String get signUp => 'Registrieren';

  @override
  String get signOut => 'Abmelden';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get nickname => 'Nickname';

  @override
  String get birthDate => 'Geburtsdatum';

  @override
  String get ageGateError => 'Du musst mindestens 18 Jahre alt sein.';

  @override
  String get continueWithApple => 'Mit Apple fortfahren';

  @override
  String get alreadyHaveAccount => 'Schon ein Konto?';

  @override
  String get termsAccept =>
      'Ich akzeptiere die Teilnahmebedingungen und habe die Datenschutzerklärung gelesen.';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get signupConfirmTitle => 'Bestätige deine E-Mail';

  @override
  String signupConfirmBody(String email) {
    return 'Wir haben einen Link an $email geschickt. Öffne ihn und melde dich dann hier an.';
  }

  @override
  String get completeProfile => 'Profil vervollständigen';

  @override
  String authError(String message) {
    return 'Anmeldung fehlgeschlagen: $message';
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
  String get onBoard => 'An Bord';

  @override
  String visitsCount(int count) {
    return '$count Besuche';
  }

  @override
  String get claimVisit => 'Besuch melden';

  @override
  String get claimVisitTitle => 'Besuch melden';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Du hast zu viele offene Meldungen.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Meine Meldungen';

  @override
  String get achievements => 'Erfolge';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return '$unlocked von $total freigeschaltet';
  }

  @override
  String get locked => 'Gesperrt';

  @override
  String get rewards => 'Belohnungen';

  @override
  String get gear => 'Ausrüstung';

  @override
  String get myVouchers => 'Meine Gutscheine';

  @override
  String get redeemed => 'Eingelöst! Zeige diesen Code an der Theke.';

  @override
  String get insufficientCoins => 'Nicht genug Münzen.';

  @override
  String get outOfStock => 'Ausverkauft';

  @override
  String stockLeft(int count) {
    return 'Noch $count';
  }

  @override
  String validUntil(String date) {
    return 'Gültig bis $date';
  }

  @override
  String get voucherActive => 'Aktiv';

  @override
  String get voucherRedeemed => 'Eingelöst';

  @override
  String get voucherExpired => 'Abgelaufen';

  @override
  String get voucherCancelled => 'Storniert';

  @override
  String get rewardTypeMerch => 'Merch';

  @override
  String get rewardTypeDrink => 'Getränk';

  @override
  String get rewardTypeDiscount => 'Rabatt';

  @override
  String get rewardTypePriorityBooking => 'Reservierung';

  @override
  String get rewardTypeEventAccess => 'Event';

  @override
  String get owned => 'Im Besitz';

  @override
  String get equip => 'Anlegen';

  @override
  String get equipped => 'Angelegt';

  @override
  String get unequip => 'Ablegen';

  @override
  String get purchaseDone => 'Gekauft. Du kannst es jetzt anlegen.';

  @override
  String unlockAtLevel(int level) {
    return 'Ab Stufe $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Erfolg: $name';
  }

  @override
  String get unlockByEvent => 'Nur bei Events';

  @override
  String get slotHeadgear => 'Kopf';

  @override
  String get slotHandItem => 'Hand';

  @override
  String get slotCape => 'Umhang';

  @override
  String get slotCompanion => 'Gefährte';

  @override
  String get slotFrame => 'Rahmen';

  @override
  String get rarityCommon => 'Gewöhnlich';

  @override
  String get rarityRare => 'Selten';

  @override
  String get rarityLegendary => 'Legendär';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Du';

  @override
  String get leaderboardHidden => 'Du bist in der Rangliste ausgeblendet.';

  @override
  String get postTypeNews => 'News';

  @override
  String get postTypeEvent => 'Event';

  @override
  String get notifications => 'Nachrichten';

  @override
  String get notificationsEmpty => 'Keine Nachrichten.';

  @override
  String get settings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get leaderboardVisible => 'In der Rangliste sichtbar';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get exportData => 'Meine Daten exportieren';

  @override
  String get exportDataDone => 'Export erstellt.';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get deleteAccountTitle => 'Konto wirklich löschen?';

  @override
  String deleteAccountBody(int coins) {
    return 'Alle Daten, XP und $coins Münzen werden unwiderruflich gelöscht.';
  }

  @override
  String get delete => 'Löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get save => 'Speichern';

  @override
  String get close => 'Schließen';

  @override
  String get gotIt => 'Verstanden';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get staffClaimsEmpty => 'Keine offenen Meldungen.';

  @override
  String get staffApprove => 'Bestätigen';

  @override
  String get staffReject => 'Ablehnen';

  @override
  String get staffRejectReason => 'Grund (optional)';

  @override
  String get staffVoucherConfirm => 'Als eingelöst markieren';

  @override
  String get staffVoucherNotFound => 'Kein Gutschein mit diesem Code.';

  @override
  String get staffVoucherDone => 'Gutschein eingelöst.';

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
  String get coinReasonVisit => 'Besuch';

  @override
  String get coinReasonAchievement => 'Erfolg';

  @override
  String get coinReasonManual => 'Team-Gutschrift';

  @override
  String get coinReasonReward => 'Belohnung';

  @override
  String get coinReasonItem => 'Ausrüstung';

  @override
  String get coinReasonExpiry => 'Verfall';

  @override
  String get coinReasonRefund => 'Erstattung';

  @override
  String get coinReasonCheckin => 'Foto in der Saga';

  @override
  String get tabHero => 'Held';

  @override
  String get heroPath => 'Heldenweg';

  @override
  String get statStreak => 'Serie';

  @override
  String get statOnBoard => 'An Bord';

  @override
  String get statVisits => 'Besuche';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks Wochen',
      one: '1 Woche',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'Diese Woche';

  @override
  String get all => 'Alle';

  @override
  String get claimSheetSub => 'Das Team an der Theke bestätigt deinen Besuch.';

  @override
  String get claimWhere => 'Wo bist du?';

  @override
  String get change => 'Ändern';

  @override
  String get claimAmountLabel => 'Rechnungsbetrag';

  @override
  String get claimAmountHint =>
      'Bestimmt nur deine Münzen. XP gibt es pro Besuch – nie pro Euro.';

  @override
  String get claimNoteLabel => 'Notiz fürs Team (optional)';

  @override
  String get claimNoteHint => 'z. B. Tisch 7';

  @override
  String get claimPreview => 'Nach der Bestätigung erhältst du';

  @override
  String streakBonus(int xp) {
    return '+$xp Serienbonus';
  }

  @override
  String get claimSentTitle => 'Besuch gemeldet';

  @override
  String get claimSentBody =>
      'Zeig dem Team diesen Code – dann geht’s am schnellsten.';

  @override
  String get yourVisitCode => 'Dein Besuchscode';

  @override
  String get stepReported => 'Gemeldet';

  @override
  String get stepChecking => 'Wird geprüft';

  @override
  String get stepCheckingSub => 'Meist in unter 5 Minuten';

  @override
  String get stepCredited => 'Gutgeschrieben';

  @override
  String get stepCreditedSub => 'XP, Serienbonus und Münzen';

  @override
  String get hornWillCall => 'Wir melden uns per Hornruf.';

  @override
  String get toHall => 'Zur Halle';

  @override
  String get claimRejectedTitle => 'Besuch abgelehnt';

  @override
  String get claimRejectedBody => 'Sprich kurz mit dem Team an der Theke.';

  @override
  String get visitConfirmed => 'Besuch bestätigt';

  @override
  String hallHonours(String name) {
    return 'Die Halle ehrt dich, $name';
  }

  @override
  String get experience => 'Erfahrung';

  @override
  String get coinsWord => 'Münzen';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks Wochen an Bord!',
      one: '1 Woche an Bord',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Serie gehalten – weiter so.';

  @override
  String get achievementUnlocked => 'Erfolg freigeschaltet';

  @override
  String get continueLabel => 'Weiter';

  @override
  String levelReached(String level) {
    return 'Stufe $level erreicht!';
  }

  @override
  String coinBonus(String mult) {
    return 'Münz-Bonus ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Vorher ×$mult – auf jeden Besuch';
  }

  @override
  String get newGear => 'Neu in deiner Ausrüstung';

  @override
  String get newBackdrop => 'Neue Kulisse';

  @override
  String equipItem(String item) {
    return '$item anlegen';
  }

  @override
  String get later => 'Später';

  @override
  String get shareLevel => 'Aufstieg teilen';

  @override
  String shareLevelText(String level) {
    return 'Ich bin jetzt $level in Valhalla Hero!';
  }

  @override
  String ownedOf(int owned, int total) {
    return '$owned von $total im Besitz';
  }

  @override
  String get cosmeticOnly => 'Rein kosmetisch – kein Einfluss aufs Spiel';

  @override
  String get heroForm => 'Heldenform';

  @override
  String get heroFormHero => 'Held';

  @override
  String get heroFormHeroine => 'Heldin';

  @override
  String get heroFormHint => 'Held oder Heldin – dein Fortschritt bleibt';

  @override
  String levelOfEight(String roman) {
    return 'Stufe $roman von VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp von $max XP bis Walhalla';
  }

  @override
  String get yourLevel => 'Deine Stufe';

  @override
  String get nextUp => 'Als Nächstes';

  @override
  String fromXp(String xp) {
    return 'ab $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return 'noch $xp XP';
  }

  @override
  String get reached => 'Erreicht';

  @override
  String almostThere(String name) {
    return 'Fast geschafft: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Rekord $weeks';
  }

  @override
  String get rewardsRedeemed => 'Beute eingelöst';

  @override
  String get itemsOwned => 'Ausrüstung im Besitz';

  @override
  String get yourBalance => 'Dein Guthaben';

  @override
  String get coinPurse => 'Münzbeutel';

  @override
  String coinsExpireSoon(int coins, String date) {
    return '$coins Münzen verfallen am $date';
  }

  @override
  String get redeemBeforeExpiry => 'Tausche sie vorher in der Beute ein.';

  @override
  String get segVouchers => 'Gutscheine';

  @override
  String get allRewards => 'Alle Belohnungen';

  @override
  String missingCoins(String coins) {
    return 'Dir fehlen $coins';
  }

  @override
  String get holdToRedeem => 'Gedrückt halten zum Eintauschen';

  @override
  String get holdHint =>
      'Kein versehentliches Ausgeben – erst nach dem Halten bestätigt.';

  @override
  String get priceLabel => 'Preis';

  @override
  String get balanceAfter => 'Guthaben danach';

  @override
  String get validLabel => 'Gültig';

  @override
  String validDays(int days) {
    return '$days Tage ab Eintausch';
  }

  @override
  String get redeemHow => 'Einlösen';

  @override
  String get showCodeAtBar => 'Code an der Theke zeigen';

  @override
  String get noVouchers =>
      'Noch keine Gutscheine. Tausche Münzen gegen Beute ein.';

  @override
  String get showThisCode => 'Zeig diesen Code an der Theke';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'noch $days Tage',
      one: 'noch 1 Tag',
    );
    return 'Gültig bis $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Eingelöst am $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Eingetauscht am $date · $coins Münzen';
  }

  @override
  String get stepShowCode => 'Code zeigen';

  @override
  String get stepTeamConfirms => 'Team bestätigt';

  @override
  String get stepEnjoy => 'Vorteil genießen';

  @override
  String get voucherLiveNote =>
      'Der Status aktualisiert sich live, sobald das Team bestätigt.';

  @override
  String expiryInfo(int months) {
    return 'Münzen verfallen nach $months Monaten';
  }

  @override
  String get xpNeverExpires => 'XP verfallen nie';

  @override
  String get coinsNoCash =>
      'Münzen sind ein freiwilliger Treue-Vorteil ohne Geldwert und werden nicht ausgezahlt.';

  @override
  String get toShop => 'Zur Beute';

  @override
  String get fameTitle => 'Ruhmeshalle';

  @override
  String get allHeroes => 'Alle Helden';

  @override
  String get rankHeader => 'PLATZ · HELD';

  @override
  String get yourPosition => 'Deine Position';

  @override
  String xpToRank(String xp, int rank) {
    return 'Noch $xp XP bis Platz $rank';
  }

  @override
  String get alleyTitle => 'Allee der Unsterblichen';

  @override
  String get alleyBody =>
      'Wer Stufe VIII erreicht – als Einherjar oder Valkyrja –, bekommt hier für immer eine Statue.';

  @override
  String get alleyFree => 'Noch frei';

  @override
  String rankInFame(int rank) {
    return 'Platz $rank der Ruhmeshalle';
  }

  @override
  String get reportName => 'Heldennamen melden';

  @override
  String get reportThanks => 'Danke – wir sehen uns das an.';

  @override
  String get share => 'Teilen';

  @override
  String get directions => 'Route';

  @override
  String get eventsNews => 'Events & Neuigkeiten';

  @override
  String get optionalRevocable => 'Freiwillig · jederzeit widerrufbar';

  @override
  String get personalOffers => 'Persönliche Angebote';

  @override
  String get personalOffersCaption => 'Freiwillig · auf Basis deiner Besuche';

  @override
  String get serviceNotifications => 'Besuche & Belohnungen';

  @override
  String get serviceNotificationsCaption =>
      'Bestätigungen, Level-Ups, ablaufende Münzen';

  @override
  String get alwaysOn => 'Immer an';

  @override
  String get showInFame => 'In der Ruhmeshalle zeigen';

  @override
  String get showInFameCaption => 'Nur Heldenname und Held – nie dein Klarname';

  @override
  String get account => 'Konto';

  @override
  String get heroName => 'Heldenname';

  @override
  String get editHeroName => 'Heldenname ändern';

  @override
  String get teamGroup => 'Team';

  @override
  String get teamMode => 'Team-Modus öffnen';

  @override
  String get teamModeCaption =>
      'Besuche bestätigen, Fotos prüfen, Gutscheine checken';

  @override
  String get legal => 'Rechtliches';

  @override
  String get terms => 'Teilnahmebedingungen';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get imprint => 'Impressum';

  @override
  String get myData => 'Meine Daten';

  @override
  String get exportCaption => 'JSON-Datei mit allen deinen Daten';

  @override
  String get deleteCaption => 'Deine Münzen und Gutscheine verfallen dabei.';

  @override
  String get hornCalls => 'Hornrufe';

  @override
  String get markAllRead => 'Alle gelesen';

  @override
  String get today => 'Heute';

  @override
  String get earlier => 'Früher';

  @override
  String get counter => 'Theke';

  @override
  String get teamModeBadge => 'TEAM-MODUS';

  @override
  String get exitTeam => 'Beenden';

  @override
  String claimsTab(int count) {
    return 'Besuche · $count';
  }

  @override
  String get voucherCheckTab => 'Gutschein prüfen';

  @override
  String get highAmount => 'Hoher Betrag – bitte Beleg ansehen';

  @override
  String get voucherCodeLabel => 'Gutschein-Code des Gastes';

  @override
  String get voucherValid => 'Gültig';

  @override
  String get voucherUsedHint =>
      'Danach ist der Code verbraucht. Rückgängig nur durch Admins.';

  @override
  String get welcomeHeadline => 'Jeder Besuch schreibt deine Saga.';

  @override
  String get welcomeBody =>
      'Scanne Belege, teile Momente aus der Halle und tausche Münzen gegen Merch und exklusive Erlebnisse.';

  @override
  String get continueWithEmail => 'E-Mail';

  @override
  String get adultsOnlyFooter => 'Nur für Gäste ab 18';

  @override
  String get emailSignInTitle => 'Mit E-Mail anmelden';

  @override
  String get newHereCreate => 'Neu hier? Konto erstellen';

  @override
  String get beforeYouEnter => 'Bevor du die Halle betrittst';

  @override
  String get ageBody =>
      'Valhalla Hero ist nur für Gäste ab 18 Jahren. Dein Geburtsdatum bleibt privat.';

  @override
  String get ageOk => 'Alles klar – du bist dabei.';

  @override
  String get consentsTitle => 'Einwilligungen';

  @override
  String get eventsNewsConsentCaption =>
      'Push-Nachrichten, wenn in der Halle etwas los ist.';

  @override
  String get offersConsentCaption => 'Angebote auf Basis deiner Besuche.';

  @override
  String get consentsFootnote =>
      'Beides freiwillig und jederzeit in den Einstellungen änderbar. Bestätigungen zu deinen Besuchen bekommst du immer.';

  @override
  String stepOf(int step, int total) {
    return 'Schritt $step von $total';
  }

  @override
  String get heroAwakes => 'Dein Held erwacht';

  @override
  String get chooseForm =>
      'Wähle deine Heldenform. Jederzeit änderbar – dein Fortschritt bleibt.';

  @override
  String get heroNameLabel => 'Name deines Helden';

  @override
  String get heroNameHint =>
      'Sichtbar in der Ruhmeshalle. Bitte keinen Klarnamen.';

  @override
  String get startJourney => 'Heldenreise beginnen';

  @override
  String get eightLevels => '8 Stufen';

  @override
  String get appTagline => 'Deine Besuche. Deine Legende.';

  @override
  String get dayMon => 'MO';

  @override
  String get dayTue => 'DI';

  @override
  String get dayWed => 'MI';

  @override
  String get dayThu => 'DO';

  @override
  String get dayFri => 'FR';

  @override
  String get daySat => 'SA';

  @override
  String get daySun => 'SO';

  @override
  String get comingSoon => 'Bald verfügbar';

  @override
  String get tabEvents => 'Events';

  @override
  String get tabSaga => 'Saga';

  @override
  String get tabScan => 'Hinzufügen';

  @override
  String get tonight => 'Heute Abend';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get liveNow => 'Läuft gerade';

  @override
  String get eventsEmpty => 'Gerade sind keine Events geplant.';

  @override
  String get eventsPast => 'Vergangene Events';

  @override
  String get catMatch => 'Sport live';

  @override
  String get catLive => 'Live-Musik';

  @override
  String get catQuiz => 'Quiz';

  @override
  String get catParty => 'Party';

  @override
  String get catSpecial => 'Special';

  @override
  String get scanTitle => 'Beleg scannen';

  @override
  String get scanHint => 'Richte die Kamera auf den QR-Code auf deinem Beleg.';

  @override
  String get scanFromPhotos => 'Aus Fotos';

  @override
  String get scanEnterCode => 'Code eingeben';

  @override
  String get scanCodeHint => 'Steht unter dem QR-Code auf deinem Beleg.';

  @override
  String get scanNoQr => 'Ohne QR melden';

  @override
  String get scanDemo => 'Demo-Beleg';

  @override
  String get scanChecking => 'Beleg wird geprüft …';

  @override
  String get torch => 'Licht';

  @override
  String get scanNoCamera =>
      'Keine Kamera verfügbar. Wähle ein Foto oder gib den Code ein.';

  @override
  String get scanNothingInImage => 'Kein QR-Code im Bild gefunden.';

  @override
  String get scanOnce =>
      'Jeder Beleg zählt einmal – XP gibt es pro Besuch, Münzen nach Betrag.';

  @override
  String get receiptErrUsed => 'Dieser Beleg wurde schon eingelöst.';

  @override
  String get receiptErrInvalid => 'Das ist kein gültiger Valhalla-Beleg.';

  @override
  String get receiptErrTooOld => 'Dieser Beleg ist zu alt.';

  @override
  String get receiptErrUnknownVenue =>
      'Der Beleg stammt nicht aus einer Valhalla-Bar.';

  @override
  String get receiptErrDailyLimit =>
      'Tageslimit für Belege erreicht. Bis morgen!';

  @override
  String get receiptAdded => 'Beleg hinzugefügt';

  @override
  String get receiptAddedHint =>
      'XP gibt es einmal pro Besuch – weitere Belege des Tages bringen Münzen.';

  @override
  String get sagaComposerTitle => 'Teile deinen Moment';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Foto aus der Halle oder mit Valhalla-Merch · +$xp XP · +$coins Münzen';
  }

  @override
  String get checkinNewTitle => 'Foto teilen';

  @override
  String get takePhoto => 'Kamera';

  @override
  String get pickPhoto => 'Mediathek';

  @override
  String get captionHint => 'Was ist los in der Halle?';

  @override
  String get tagEvent => 'Zu einem Event';

  @override
  String get noEvent => 'Kein Event';

  @override
  String get checkinRules =>
      'Nur Fotos aus der Halle oder mit Valhalla-Merch. Das Team prüft jedes Foto – danach erscheint es in der Saga.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · +$coins Münzen nach Freigabe (einmal pro Tag)';
  }

  @override
  String get checkinSubmit => 'Zur Prüfung senden';

  @override
  String get checkinPendingTitle => 'Dein Foto wird geprüft';

  @override
  String get checkinPendingBody =>
      'Sobald das Team es freigibt, erscheint es in der Saga. Bis dahin kannst du kein weiteres Foto senden.';

  @override
  String get checkinWithdraw => 'Zurückziehen';

  @override
  String get checkinRejectedTitle => 'Foto nicht freigegeben';

  @override
  String get checkinErrPending => 'Du hast schon ein Foto in Prüfung.';

  @override
  String get sagaEmpty => 'Noch keine Fotos. Mach den Anfang!';

  @override
  String get justNow => 'gerade eben';

  @override
  String agoMinutes(int minutes) {
    return 'vor $minutes Min.';
  }

  @override
  String agoHours(int hours) {
    return 'vor $hours Std.';
  }

  @override
  String get photosInSaga => 'Fotos in der Saga';

  @override
  String teamPhotosTab(int count) {
    return 'Fotos · $count';
  }

  @override
  String get teamPhotosEmpty => 'Keine Fotos zu prüfen.';

  @override
  String get approvePhoto => 'Freigeben';

  @override
  String get helpFeedback => 'Hilfe & Feedback';

  @override
  String get reportBug => 'Fehler melden';

  @override
  String get reportBugCaption => 'Etwas funktioniert nicht? Sag uns Bescheid.';

  @override
  String get bugDescribe => 'Was ist passiert?';

  @override
  String get bugHint =>
      'Beschreibe kurz, was du gemacht hast und was schiefging.';

  @override
  String get bugIncludeInfo => 'App- und Geräteinfos mitsenden';

  @override
  String get bugSend => 'Senden';

  @override
  String get bugThanks => 'Danke! Wir kümmern uns darum.';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Likes',
      one: '1 Like',
      zero: 'Noch keine Likes',
    );
    return '$_temp0';
  }
}
