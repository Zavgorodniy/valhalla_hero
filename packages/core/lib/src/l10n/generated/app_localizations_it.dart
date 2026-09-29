// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class L10nIt extends L10n {
  L10nIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Bottino';

  @override
  String get signIn => 'Accedi';

  @override
  String get signUp => 'Registrati';

  @override
  String get signOut => 'Esci';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Password';

  @override
  String get nickname => 'Nickname';

  @override
  String get birthDate => 'Data di nascita';

  @override
  String get ageGateError => 'Devi avere almeno 18 anni.';

  @override
  String get continueWithApple => 'Continua con Apple';

  @override
  String get alreadyHaveAccount => 'Hai già un account?';

  @override
  String get termsAccept =>
      'Accetto le condizioni di partecipazione e ho letto l’informativa sulla privacy.';

  @override
  String get createAccount => 'Crea account';

  @override
  String get signupConfirmTitle => 'Conferma la tua e-mail';

  @override
  String signupConfirmBody(String email) {
    return 'Abbiamo inviato un link a $email. Aprilo, poi accedi qui.';
  }

  @override
  String get completeProfile => 'Completa il profilo';

  @override
  String authError(String message) {
    return 'Accesso non riuscito: $message';
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
  String get onBoard => 'A bordo';

  @override
  String visitsCount(int count) {
    return '$count visite';
  }

  @override
  String get claimVisit => 'Segnala visita';

  @override
  String get claimVisitTitle => 'Segnala una visita';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Hai troppe segnalazioni in attesa.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Le mie segnalazioni';

  @override
  String get achievements => 'Traguardi';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return '$unlocked di $total sbloccati';
  }

  @override
  String get locked => 'Bloccato';

  @override
  String get rewards => 'Premi';

  @override
  String get gear => 'Equipaggiamento';

  @override
  String get myVouchers => 'I miei buoni';

  @override
  String get redeemed => 'Riscattato! Mostra questo codice al bancone.';

  @override
  String get insufficientCoins => 'Monete insufficienti.';

  @override
  String get outOfStock => 'Esaurito';

  @override
  String stockLeft(int count) {
    return 'Ne restano $count';
  }

  @override
  String validUntil(String date) {
    return 'Valido fino al $date';
  }

  @override
  String get voucherActive => 'Attivo';

  @override
  String get voucherRedeemed => 'Riscattato';

  @override
  String get voucherExpired => 'Scaduto';

  @override
  String get voucherCancelled => 'Annullato';

  @override
  String get rewardTypeMerch => 'Merch';

  @override
  String get rewardTypeDrink => 'Bevanda';

  @override
  String get rewardTypeDiscount => 'Sconto';

  @override
  String get rewardTypePriorityBooking => 'Prenotazione';

  @override
  String get rewardTypeEventAccess => 'Evento';

  @override
  String get owned => 'Posseduto';

  @override
  String get equip => 'Equipaggia';

  @override
  String get equipped => 'Equipaggiato';

  @override
  String get unequip => 'Togli';

  @override
  String get purchaseDone => 'Acquistato. Ora puoi equipaggiarlo.';

  @override
  String unlockAtLevel(int level) {
    return 'Dal livello $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Traguardo: $name';
  }

  @override
  String get unlockByEvent => 'Solo agli eventi';

  @override
  String get slotHeadgear => 'Testa';

  @override
  String get slotHandItem => 'Mano';

  @override
  String get slotCape => 'Mantello';

  @override
  String get slotCompanion => 'Compagno';

  @override
  String get slotFrame => 'Cornice';

  @override
  String get rarityCommon => 'Comune';

  @override
  String get rarityRare => 'Raro';

  @override
  String get rarityLegendary => 'Leggendario';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Tu';

  @override
  String get leaderboardHidden => 'Sei nascosto/a dalla classifica.';

  @override
  String get postTypeNews => 'Notizie';

  @override
  String get postTypeEvent => 'Evento';

  @override
  String get notifications => 'Messaggi';

  @override
  String get notificationsEmpty => 'Nessun messaggio.';

  @override
  String get settings => 'Impostazioni';

  @override
  String get language => 'Lingua';

  @override
  String get leaderboardVisible => 'Visibile in classifica';

  @override
  String get privacy => 'Privacy';

  @override
  String get exportData => 'Esporta i miei dati';

  @override
  String get exportDataDone => 'Esportazione creata.';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get deleteAccountTitle => 'Eliminare davvero l’account?';

  @override
  String deleteAccountBody(int coins) {
    return 'Tutti i dati, gli XP e $coins monete verranno eliminati definitivamente.';
  }

  @override
  String get delete => 'Elimina';

  @override
  String get cancel => 'Annulla';

  @override
  String get confirm => 'Conferma';

  @override
  String get save => 'Salva';

  @override
  String get close => 'Chiudi';

  @override
  String get gotIt => 'Capito';

  @override
  String get retry => 'Riprova';

  @override
  String get staffClaimsEmpty => 'Nessuna segnalazione in attesa.';

  @override
  String get staffApprove => 'Conferma';

  @override
  String get staffReject => 'Rifiuta';

  @override
  String get staffRejectReason => 'Motivo (facoltativo)';

  @override
  String get staffVoucherConfirm => 'Segna come riscattato';

  @override
  String get staffVoucherNotFound => 'Nessun buono con questo codice.';

  @override
  String get staffVoucherDone => 'Buono riscattato.';

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
  String get coinReasonVisit => 'Visita';

  @override
  String get coinReasonAchievement => 'Traguardo';

  @override
  String get coinReasonManual => 'Accredito dello staff';

  @override
  String get coinReasonReward => 'Premio';

  @override
  String get coinReasonItem => 'Equipaggiamento';

  @override
  String get coinReasonExpiry => 'Scadenza';

  @override
  String get coinReasonRefund => 'Rimborso';

  @override
  String get coinReasonCheckin => 'Foto nella saga';

  @override
  String get tabHero => 'Eroe';

  @override
  String get heroPath => 'Via dell’eroe';

  @override
  String get statStreak => 'Serie';

  @override
  String get statOnBoard => 'A bordo';

  @override
  String get statVisits => 'Visite';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks settimane',
      one: '1 settimana',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'Questa settimana';

  @override
  String get all => 'Tutti';

  @override
  String get claimSheetSub => 'Lo staff del bar conferma la tua visita.';

  @override
  String get claimWhere => 'Dove sei?';

  @override
  String get change => 'Cambia';

  @override
  String get claimAmountLabel => 'Importo del conto';

  @override
  String get claimAmountHint =>
      'Determina solo le monete. Gli XP sono per visita – mai per euro.';

  @override
  String get claimNoteLabel => 'Nota per lo staff (facoltativa)';

  @override
  String get claimNoteHint => 'es. tavolo 7';

  @override
  String get claimPreview => 'Dopo la conferma ricevi';

  @override
  String streakBonus(int xp) {
    return '+$xp bonus serie';
  }

  @override
  String get claimSentTitle => 'Visita segnalata';

  @override
  String get claimSentBody =>
      'Mostra questo codice allo staff – è il modo più veloce.';

  @override
  String get yourVisitCode => 'Il tuo codice visita';

  @override
  String get stepReported => 'Segnalata';

  @override
  String get stepChecking => 'In verifica';

  @override
  String get stepCheckingSub => 'Di solito meno di 5 minuti';

  @override
  String get stepCredited => 'Accreditata';

  @override
  String get stepCreditedSub => 'XP, bonus serie e monete';

  @override
  String get hornWillCall => 'Suoneremo il corno quando sarà fatto.';

  @override
  String get toHall => 'Torna alla sala';

  @override
  String get claimRejectedTitle => 'Visita rifiutata';

  @override
  String get claimRejectedBody => 'Scambia due parole con lo staff al bancone.';

  @override
  String get visitConfirmed => 'Visita confermata';

  @override
  String hallHonours(String name) {
    return 'La sala ti onora, $name';
  }

  @override
  String get experience => 'Esperienza';

  @override
  String get coinsWord => 'Monete';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks settimane a bordo!',
      one: '1 settimana a bordo',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Serie mantenuta – continua così.';

  @override
  String get achievementUnlocked => 'Traguardo sbloccato';

  @override
  String get continueLabel => 'Continua';

  @override
  String levelReached(String level) {
    return 'Livello $level raggiunto!';
  }

  @override
  String coinBonus(String mult) {
    return 'Bonus monete ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Prima ×$mult – a ogni visita';
  }

  @override
  String get newGear => 'Nuovo nel tuo equipaggiamento';

  @override
  String get newBackdrop => 'Nuovo sfondo';

  @override
  String equipItem(String item) {
    return 'Equipaggia $item';
  }

  @override
  String get later => 'Più tardi';

  @override
  String get shareLevel => 'Condividi il livello';

  @override
  String shareLevelText(String level) {
    return 'Sono appena diventato/a $level in Valhalla Hero!';
  }

  @override
  String ownedOf(int owned, int total) {
    return '$owned di $total posseduti';
  }

  @override
  String get cosmeticOnly => 'Solo estetico – nessun effetto sul gioco';

  @override
  String get heroForm => 'Aspetto dell’eroe';

  @override
  String get heroFormHero => 'Eroe';

  @override
  String get heroFormHeroine => 'Eroina';

  @override
  String get heroFormHint => 'Eroe o eroina – i tuoi progressi restano';

  @override
  String levelOfEight(String roman) {
    return 'Livello $roman di VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp di $max XP verso il Valhalla';
  }

  @override
  String get yourLevel => 'Il tuo livello';

  @override
  String get nextUp => 'Prossimo';

  @override
  String fromXp(String xp) {
    return 'da $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return 'ancora $xp XP';
  }

  @override
  String get reached => 'Sbloccato';

  @override
  String almostThere(String name) {
    return 'Quasi: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Record $weeks';
  }

  @override
  String get rewardsRedeemed => 'Premi riscattati';

  @override
  String get itemsOwned => 'Equipaggiamento posseduto';

  @override
  String get yourBalance => 'Il tuo saldo';

  @override
  String get coinPurse => 'Borsa delle monete';

  @override
  String coinsExpireSoon(int coins, String date) {
    return '$coins monete scadono il $date';
  }

  @override
  String get redeemBeforeExpiry => 'Spendile prima nel negozio.';

  @override
  String get segVouchers => 'Buoni';

  @override
  String get allRewards => 'Tutti i premi';

  @override
  String missingCoins(String coins) {
    return 'Ti mancano $coins';
  }

  @override
  String get holdToRedeem => 'Tieni premuto per riscattare';

  @override
  String get holdHint =>
      'Niente spese per sbaglio – confermato solo tenendo premuto.';

  @override
  String get priceLabel => 'Prezzo';

  @override
  String get balanceAfter => 'Saldo dopo';

  @override
  String get validLabel => 'Validità';

  @override
  String validDays(int days) {
    return '$days giorni dal riscatto';
  }

  @override
  String get redeemHow => 'Come riscattare';

  @override
  String get showCodeAtBar => 'Mostra il codice al bancone';

  @override
  String get noVouchers =>
      'Ancora nessun buono. Scambia le monete con il bottino.';

  @override
  String get showThisCode => 'Mostra questo codice al bancone';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'ancora $days giorni',
      one: 'ancora 1 giorno',
    );
    return 'Valido fino al $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Riscattato il $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Riscattato il $date · $coins monete';
  }

  @override
  String get stepShowCode => 'Mostra il codice';

  @override
  String get stepTeamConfirms => 'Lo staff conferma';

  @override
  String get stepEnjoy => 'Goditelo';

  @override
  String get voucherLiveNote =>
      'Lo stato si aggiorna in tempo reale appena lo staff conferma.';

  @override
  String expiryInfo(int months) {
    return 'Le monete scadono dopo $months mesi';
  }

  @override
  String get xpNeverExpires => 'Gli XP non scadono mai';

  @override
  String get coinsNoCash =>
      'Le monete sono un vantaggio fedeltà volontario senza valore in denaro e non vengono mai pagate.';

  @override
  String get toShop => 'Al negozio';

  @override
  String get fameTitle => 'Sala della Fama';

  @override
  String get allHeroes => 'Tutti gli eroi';

  @override
  String get rankHeader => 'POSTO · EROE';

  @override
  String get yourPosition => 'La tua posizione';

  @override
  String xpToRank(String xp, int rank) {
    return '$xp XP al $rank° posto';
  }

  @override
  String get alleyTitle => 'Viale degli Immortali';

  @override
  String get alleyBody =>
      'Raggiungi il livello VIII – come Einherjar o Valchiria – e qui avrai una statua per sempre.';

  @override
  String get alleyFree => 'Ancora libero';

  @override
  String rankInFame(int rank) {
    return '$rank° posto nella Sala della Fama';
  }

  @override
  String get reportName => 'Segnala il nome';

  @override
  String get reportThanks => 'Grazie – daremo un’occhiata.';

  @override
  String get share => 'Condividi';

  @override
  String get directions => 'Indicazioni';

  @override
  String get eventsNews => 'Eventi e notizie';

  @override
  String get optionalRevocable =>
      'Facoltativo · revocabile in qualsiasi momento';

  @override
  String get personalOffers => 'Offerte personali';

  @override
  String get personalOffersCaption => 'Facoltativo · in base alle tue visite';

  @override
  String get serviceNotifications => 'Visite e premi';

  @override
  String get serviceNotificationsCaption =>
      'Conferme, nuovi livelli, monete in scadenza';

  @override
  String get alwaysOn => 'Sempre attivo';

  @override
  String get showInFame => 'Mostra nella Sala della Fama';

  @override
  String get showInFameCaption =>
      'Solo nome e aspetto dell’eroe – mai il tuo vero nome';

  @override
  String get account => 'Account';

  @override
  String get heroName => 'Nome dell’eroe';

  @override
  String get editHeroName => 'Cambia nome dell’eroe';

  @override
  String get teamGroup => 'Staff';

  @override
  String get teamMode => 'Apri modalità staff';

  @override
  String get teamModeCaption => 'Conferma visite, verifica foto e buoni';

  @override
  String get legal => 'Note legali';

  @override
  String get terms => 'Condizioni di partecipazione';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get imprint => 'Note legali (Impressum)';

  @override
  String get myData => 'I miei dati';

  @override
  String get exportCaption => 'File JSON con tutti i tuoi dati';

  @override
  String get deleteCaption => 'Le tue monete e i tuoi buoni andranno persi.';

  @override
  String get hornCalls => 'Richiami del corno';

  @override
  String get markAllRead => 'Segna tutto come letto';

  @override
  String get today => 'Oggi';

  @override
  String get earlier => 'Prima';

  @override
  String get counter => 'Bancone';

  @override
  String get teamModeBadge => 'MODALITÀ STAFF';

  @override
  String get exitTeam => 'Esci';

  @override
  String claimsTab(int count) {
    return 'Visite · $count';
  }

  @override
  String get voucherCheckTab => 'Verifica buono';

  @override
  String get highAmount => 'Importo elevato – controlla lo scontrino';

  @override
  String get voucherCodeLabel => 'Codice buono dell’ospite';

  @override
  String get voucherValid => 'Valido';

  @override
  String get voucherUsedHint =>
      'Dopo il codice risulta usato. Solo gli admin possono annullare.';

  @override
  String get welcomeHeadline => 'Ogni visita scrive la tua saga.';

  @override
  String get welcomeBody =>
      'Scansiona gli scontrini, condividi momenti dalla sala e scambia le monete con merch ed esperienze esclusive.';

  @override
  String get continueWithEmail => 'E-mail';

  @override
  String get adultsOnlyFooter => 'Solo per ospiti maggiorenni';

  @override
  String get emailSignInTitle => 'Accedi con e-mail';

  @override
  String get newHereCreate => 'Nuovo qui? Crea un account';

  @override
  String get beforeYouEnter => 'Prima di entrare nella sala';

  @override
  String get ageBody =>
      'Valhalla Hero è solo per ospiti dai 18 anni in su. La tua data di nascita resta privata.';

  @override
  String get ageOk => 'Tutto a posto – benvenuto/a.';

  @override
  String get consentsTitle => 'Consensi';

  @override
  String get eventsNewsConsentCaption =>
      'Notifiche push quando succede qualcosa nella sala.';

  @override
  String get offersConsentCaption => 'Offerte in base alle tue visite.';

  @override
  String get consentsFootnote =>
      'Entrambi facoltativi e modificabili in qualsiasi momento nelle impostazioni. Le conferme delle visite arrivano sempre.';

  @override
  String stepOf(int step, int total) {
    return 'Passo $step di $total';
  }

  @override
  String get heroAwakes => 'Il tuo eroe si risveglia';

  @override
  String get chooseForm =>
      'Scegli l’aspetto del tuo eroe. Puoi cambiarlo quando vuoi – i progressi restano.';

  @override
  String get heroNameLabel => 'Nome del tuo eroe';

  @override
  String get heroNameHint =>
      'Visibile nella Sala della Fama. Niente nomi veri, per favore.';

  @override
  String get startJourney => 'Inizia il viaggio';

  @override
  String get eightLevels => '8 livelli';

  @override
  String get appTagline => 'Le tue visite. La tua leggenda.';

  @override
  String get dayMon => 'LUN';

  @override
  String get dayTue => 'MAR';

  @override
  String get dayWed => 'MER';

  @override
  String get dayThu => 'GIO';

  @override
  String get dayFri => 'VEN';

  @override
  String get daySat => 'SAB';

  @override
  String get daySun => 'DOM';

  @override
  String get comingSoon => 'Prossimamente';

  @override
  String get tabEvents => 'Eventi';

  @override
  String get tabSaga => 'Saga';

  @override
  String get tabScan => 'Aggiungi';

  @override
  String get tonight => 'Stasera';

  @override
  String get tomorrow => 'Domani';

  @override
  String get liveNow => 'In corso';

  @override
  String get eventsEmpty => 'Al momento non ci sono eventi in programma.';

  @override
  String get eventsPast => 'Eventi passati';

  @override
  String get catMatch => 'Sport in diretta';

  @override
  String get catLive => 'Musica dal vivo';

  @override
  String get catQuiz => 'Quiz';

  @override
  String get catParty => 'Festa';

  @override
  String get catSpecial => 'Speciale';

  @override
  String get scanTitle => 'Scansiona scontrino';

  @override
  String get scanHint => 'Inquadra il codice QR sul tuo scontrino.';

  @override
  String get scanFromPhotos => 'Dalle foto';

  @override
  String get scanEnterCode => 'Inserisci codice';

  @override
  String get scanCodeHint => 'Stampato sotto il codice QR dello scontrino.';

  @override
  String get scanNoQr => 'Segnala senza QR';

  @override
  String get scanDemo => 'Scontrino demo';

  @override
  String get scanChecking => 'Verifica dello scontrino …';

  @override
  String get torch => 'Torcia';

  @override
  String get scanNoCamera =>
      'Fotocamera non disponibile. Scegli una foto o inserisci il codice.';

  @override
  String get scanNothingInImage => 'Nessun codice QR trovato nell’immagine.';

  @override
  String get scanOnce =>
      'Ogni scontrino vale una volta – XP per visita, monete in base all’importo.';

  @override
  String get receiptErrUsed => 'Questo scontrino è già stato usato.';

  @override
  String get receiptErrInvalid => 'Questo non è uno scontrino Valhalla valido.';

  @override
  String get receiptErrTooOld => 'Questo scontrino è troppo vecchio.';

  @override
  String get receiptErrUnknownVenue =>
      'Questo scontrino non è di un bar Valhalla.';

  @override
  String get receiptErrDailyLimit =>
      'Limite giornaliero di scontrini raggiunto. A domani!';

  @override
  String get receiptAdded => 'Scontrino aggiunto';

  @override
  String get receiptAddedHint =>
      'Gli XP sono per visita – altri scontrini nello stesso giorno danno monete.';

  @override
  String get sagaComposerTitle => 'Condividi il tuo momento';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Foto dalla sala o con merch Valhalla · +$xp XP · +$coins monete';
  }

  @override
  String get checkinNewTitle => 'Condividi foto';

  @override
  String get takePhoto => 'Fotocamera';

  @override
  String get pickPhoto => 'Galleria';

  @override
  String get captionHint => 'Cosa succede nella sala?';

  @override
  String get tagEvent => 'Collega un evento';

  @override
  String get noEvent => 'Nessun evento';

  @override
  String get checkinRules =>
      'Solo foto dalla sala o con merch Valhalla. Lo staff controlla ogni foto prima che compaia nella saga.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · +$coins monete dopo l’approvazione (una volta al giorno)';
  }

  @override
  String get checkinSubmit => 'Invia per la verifica';

  @override
  String get checkinPendingTitle => 'La tua foto è in verifica';

  @override
  String get checkinPendingBody =>
      'Appena lo staff la approva, compare nella saga. Fino ad allora non puoi inviarne un’altra.';

  @override
  String get checkinWithdraw => 'Ritira';

  @override
  String get checkinRejectedTitle => 'Foto non approvata';

  @override
  String get checkinErrPending => 'Hai già una foto in verifica.';

  @override
  String get sagaEmpty => 'Ancora nessuna foto. Inizia tu la saga!';

  @override
  String get justNow => 'proprio ora';

  @override
  String agoMinutes(int minutes) {
    return '$minutes min fa';
  }

  @override
  String agoHours(int hours) {
    return '$hours h fa';
  }

  @override
  String get photosInSaga => 'Foto nella saga';

  @override
  String teamPhotosTab(int count) {
    return 'Foto · $count';
  }

  @override
  String get teamPhotosEmpty => 'Nessuna foto da verificare.';

  @override
  String get approvePhoto => 'Approva';

  @override
  String get helpFeedback => 'Aiuto e feedback';

  @override
  String get reportBug => 'Segnala un bug';

  @override
  String get reportBugCaption => 'Qualcosa non funziona? Faccelo sapere.';

  @override
  String get bugDescribe => 'Cosa è successo?';

  @override
  String get bugHint =>
      'Descrivi brevemente cosa stavi facendo e cosa è andato storto.';

  @override
  String get bugIncludeInfo => 'Includi informazioni su app e dispositivo';

  @override
  String get bugSend => 'Invia';

  @override
  String get bugThanks => 'Grazie! Ce ne occupiamo.';

  @override
  String get chooseLanguage => 'Scegli la lingua';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mi piace',
      one: '1 mi piace',
      zero: 'Ancora nessun mi piace',
    );
    return '$_temp0';
  }
}
