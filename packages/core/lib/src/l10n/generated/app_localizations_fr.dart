// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class L10nFr extends L10n {
  L10nFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Butin';

  @override
  String get signIn => 'Se connecter';

  @override
  String get signUp => 'S’inscrire';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get nickname => 'Pseudo';

  @override
  String get birthDate => 'Date de naissance';

  @override
  String get ageGateError => 'Tu dois avoir au moins 18 ans.';

  @override
  String get continueWithApple => 'Continuer avec Apple';

  @override
  String get alreadyHaveAccount => 'Déjà un compte ?';

  @override
  String get termsAccept =>
      'J’accepte les conditions de participation et j’ai lu la politique de confidentialité.';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get signupConfirmTitle => 'Confirme ton e-mail';

  @override
  String signupConfirmBody(String email) {
    return 'Nous avons envoyé un lien à $email. Ouvre-le, puis connecte-toi ici.';
  }

  @override
  String get completeProfile => 'Compléter le profil';

  @override
  String authError(String message) {
    return 'Échec de la connexion : $message';
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
  String get onBoard => 'À bord';

  @override
  String visitsCount(int count) {
    return 'Visites : $count';
  }

  @override
  String get claimVisit => 'Signaler une visite';

  @override
  String get claimVisitTitle => 'Signaler une visite';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Tu as trop de signalements en attente.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Mes signalements';

  @override
  String get achievements => 'Succès';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return '$unlocked sur $total débloqués';
  }

  @override
  String get locked => 'Verrouillé';

  @override
  String get rewards => 'Récompenses';

  @override
  String get gear => 'Équipement';

  @override
  String get myVouchers => 'Mes bons';

  @override
  String get redeemed => 'Échangé ! Montre ce code au bar.';

  @override
  String get insufficientCoins => 'Pas assez de pièces.';

  @override
  String get outOfStock => 'Épuisé';

  @override
  String stockLeft(int count) {
    return 'Plus que $count';
  }

  @override
  String validUntil(String date) {
    return 'Valable jusqu’au $date';
  }

  @override
  String get voucherActive => 'Actif';

  @override
  String get voucherRedeemed => 'Utilisé';

  @override
  String get voucherExpired => 'Expiré';

  @override
  String get voucherCancelled => 'Annulé';

  @override
  String get rewardTypeMerch => 'Merch';

  @override
  String get rewardTypeDrink => 'Boisson';

  @override
  String get rewardTypeDiscount => 'Réduction';

  @override
  String get rewardTypePriorityBooking => 'Réservation';

  @override
  String get rewardTypeEventAccess => 'Événement';

  @override
  String get owned => 'Possédé';

  @override
  String get equip => 'Équiper';

  @override
  String get equipped => 'Équipé';

  @override
  String get unequip => 'Retirer';

  @override
  String get purchaseDone => 'Acheté. Tu peux l’équiper maintenant.';

  @override
  String unlockAtLevel(int level) {
    return 'Dès le niveau $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Succès : $name';
  }

  @override
  String get unlockByEvent => 'Uniquement lors d’événements';

  @override
  String get slotHeadgear => 'Tête';

  @override
  String get slotHandItem => 'Main';

  @override
  String get slotCape => 'Cape';

  @override
  String get slotCompanion => 'Compagnon';

  @override
  String get slotFrame => 'Cadre';

  @override
  String get rarityCommon => 'Commun';

  @override
  String get rarityRare => 'Rare';

  @override
  String get rarityLegendary => 'Légendaire';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Toi';

  @override
  String get leaderboardHidden => 'Tu es masqué·e du classement.';

  @override
  String get postTypeNews => 'Actus';

  @override
  String get postTypeEvent => 'Événement';

  @override
  String get notifications => 'Messages';

  @override
  String get notificationsEmpty => 'Aucun message.';

  @override
  String get settings => 'Réglages';

  @override
  String get language => 'Langue';

  @override
  String get leaderboardVisible => 'Visible dans le classement';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get exportData => 'Exporter mes données';

  @override
  String get exportDataDone => 'Export créé.';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountTitle => 'Vraiment supprimer ton compte ?';

  @override
  String deleteAccountBody(int coins) {
    return 'Toutes les données, l’XP et $coins pièces seront supprimées définitivement.';
  }

  @override
  String get delete => 'Supprimer';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get save => 'Enregistrer';

  @override
  String get close => 'Fermer';

  @override
  String get gotIt => 'Compris';

  @override
  String get retry => 'Réessayer';

  @override
  String get staffClaimsEmpty => 'Aucun signalement en attente.';

  @override
  String get staffApprove => 'Valider';

  @override
  String get staffReject => 'Refuser';

  @override
  String get staffRejectReason => 'Motif (facultatif)';

  @override
  String get staffVoucherConfirm => 'Marquer comme utilisé';

  @override
  String get staffVoucherNotFound => 'Aucun bon avec ce code.';

  @override
  String get staffVoucherDone => 'Bon utilisé.';

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
  String get coinReasonVisit => 'Visite';

  @override
  String get coinReasonAchievement => 'Succès';

  @override
  String get coinReasonManual => 'Crédit de l’équipe';

  @override
  String get coinReasonReward => 'Récompense';

  @override
  String get coinReasonItem => 'Équipement';

  @override
  String get coinReasonExpiry => 'Expiration';

  @override
  String get coinReasonRefund => 'Remboursement';

  @override
  String get coinReasonCheckin => 'Photo dans la saga';

  @override
  String get tabHero => 'Héros';

  @override
  String get heroPath => 'Chemin du héros';

  @override
  String get statStreak => 'Série';

  @override
  String get statOnBoard => 'À bord';

  @override
  String get statVisits => 'Visites';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks semaines',
      one: '1 semaine',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get all => 'Tous';

  @override
  String get claimSheetSub => 'L’équipe du bar confirme ta visite.';

  @override
  String get claimWhere => 'Où es-tu ?';

  @override
  String get change => 'Changer';

  @override
  String get claimAmountLabel => 'Montant de l’addition';

  @override
  String get claimAmountHint =>
      'Ne détermine que tes pièces. L’XP se gagne par visite – jamais par euro.';

  @override
  String get claimNoteLabel => 'Note pour l’équipe (facultatif)';

  @override
  String get claimNoteHint => 'ex. table 7';

  @override
  String get claimPreview => 'Après confirmation, tu reçois';

  @override
  String streakBonus(int xp) {
    return '+$xp bonus de série';
  }

  @override
  String get claimSentTitle => 'Visite signalée';

  @override
  String get claimSentBody =>
      'Montre ce code à l’équipe – c’est le plus rapide.';

  @override
  String get yourVisitCode => 'Ton code de visite';

  @override
  String get stepReported => 'Signalée';

  @override
  String get stepChecking => 'En vérification';

  @override
  String get stepCheckingSub => 'Généralement moins de 5 minutes';

  @override
  String get stepCredited => 'Créditée';

  @override
  String get stepCreditedSub => 'XP, bonus de série et pièces';

  @override
  String get hornWillCall => 'Nous sonnerons du cor quand ce sera fait.';

  @override
  String get toHall => 'Retour à la halle';

  @override
  String get claimRejectedTitle => 'Visite refusée';

  @override
  String get claimRejectedBody => 'Parles-en rapidement avec l’équipe au bar.';

  @override
  String get visitConfirmed => 'Visite confirmée';

  @override
  String hallHonours(String name) {
    return 'La halle t’honore, $name';
  }

  @override
  String get experience => 'Expérience';

  @override
  String get coinsWord => 'Pièces';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks semaines à bord !',
      one: '1 semaine à bord',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Série maintenue – continue comme ça.';

  @override
  String get achievementUnlocked => 'Succès débloqué';

  @override
  String get continueLabel => 'Continuer';

  @override
  String levelReached(String level) {
    return 'Niveau $level atteint !';
  }

  @override
  String coinBonus(String mult) {
    return 'Bonus de pièces ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Avant ×$mult – à chaque visite';
  }

  @override
  String get newGear => 'Nouveau dans ton équipement';

  @override
  String get newBackdrop => 'Nouveau décor';

  @override
  String equipItem(String item) {
    return 'Équiper $item';
  }

  @override
  String get later => 'Plus tard';

  @override
  String get shareLevel => 'Partager le niveau';

  @override
  String shareLevelText(String level) {
    return 'Je viens de devenir $level dans Valhalla Hero !';
  }

  @override
  String ownedOf(int owned, int total) {
    return '$owned sur $total possédés';
  }

  @override
  String get cosmeticOnly => 'Purement esthétique – aucun effet sur le jeu';

  @override
  String get heroForm => 'Apparence du héros';

  @override
  String get heroFormHero => 'Héros';

  @override
  String get heroFormHeroine => 'Héroïne';

  @override
  String get heroFormHint => 'Héros ou héroïne – ta progression reste';

  @override
  String levelOfEight(String roman) {
    return 'Niveau $roman sur VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp sur $max XP jusqu’au Valhalla';
  }

  @override
  String get yourLevel => 'Ton niveau';

  @override
  String get nextUp => 'Ensuite';

  @override
  String fromXp(String xp) {
    return 'dès $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return 'encore $xp XP';
  }

  @override
  String get reached => 'Débloqué';

  @override
  String almostThere(String name) {
    return 'Presque : $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Record $weeks';
  }

  @override
  String get rewardsRedeemed => 'Récompenses échangées';

  @override
  String get itemsOwned => 'Équipement possédé';

  @override
  String get yourBalance => 'Ton solde';

  @override
  String get coinPurse => 'Bourse';

  @override
  String coinsExpireSoon(int coins, String date) {
    return '$coins pièces expirent le $date';
  }

  @override
  String get redeemBeforeExpiry => 'Dépense-les dans la boutique avant.';

  @override
  String get segVouchers => 'Bons';

  @override
  String get allRewards => 'Toutes les récompenses';

  @override
  String missingCoins(String coins) {
    return 'Il te manque $coins';
  }

  @override
  String get holdToRedeem => 'Maintenir pour échanger';

  @override
  String get holdHint =>
      'Pas de dépense par erreur – confirmé seulement en maintenant.';

  @override
  String get priceLabel => 'Prix';

  @override
  String get balanceAfter => 'Solde après';

  @override
  String get validLabel => 'Validité';

  @override
  String validDays(int days) {
    return '$days jours après l’échange';
  }

  @override
  String get redeemHow => 'Comment échanger';

  @override
  String get showCodeAtBar => 'Montrer le code au bar';

  @override
  String get noVouchers =>
      'Pas encore de bons. Échange tes pièces contre du butin.';

  @override
  String get showThisCode => 'Montre ce code au bar';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'encore $days jours',
      one: 'encore 1 jour',
    );
    return 'Valable jusqu’au $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Utilisé le $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Échangé le $date · $coins pièces';
  }

  @override
  String get stepShowCode => 'Montrer le code';

  @override
  String get stepTeamConfirms => 'L’équipe confirme';

  @override
  String get stepEnjoy => 'Profite';

  @override
  String get voucherLiveNote =>
      'Le statut se met à jour en direct dès que l’équipe confirme.';

  @override
  String expiryInfo(int months) {
    return 'Les pièces expirent après $months mois';
  }

  @override
  String get xpNeverExpires => 'L’XP n’expire jamais';

  @override
  String get coinsNoCash =>
      'Les pièces sont un avantage fidélité volontaire sans valeur monétaire et ne sont jamais versées.';

  @override
  String get toShop => 'Vers la boutique';

  @override
  String get fameTitle => 'Panthéon';

  @override
  String get allHeroes => 'Tous les héros';

  @override
  String get rankHeader => 'RANG · HÉROS';

  @override
  String get yourPosition => 'Ta position';

  @override
  String xpToRank(String xp, int rank) {
    return '$xp XP jusqu’au rang $rank';
  }

  @override
  String get alleyTitle => 'Allée des Immortels';

  @override
  String get alleyBody =>
      'Atteins le niveau VIII – en Einherjar ou Valkyrie – et ta statue restera ici pour toujours.';

  @override
  String get alleyFree => 'Encore libre';

  @override
  String rankInFame(int rank) {
    return 'Rang $rank au Panthéon';
  }

  @override
  String get reportName => 'Signaler le nom';

  @override
  String get reportThanks => 'Merci – nous allons vérifier.';

  @override
  String get share => 'Partager';

  @override
  String get directions => 'Itinéraire';

  @override
  String get eventsNews => 'Événements & actus';

  @override
  String get optionalRevocable => 'Facultatif · révocable à tout moment';

  @override
  String get personalOffers => 'Offres personnalisées';

  @override
  String get personalOffersCaption => 'Facultatif · selon tes visites';

  @override
  String get serviceNotifications => 'Visites & récompenses';

  @override
  String get serviceNotificationsCaption =>
      'Confirmations, montées de niveau, pièces qui expirent';

  @override
  String get alwaysOn => 'Toujours actif';

  @override
  String get showInFame => 'Afficher au Panthéon';

  @override
  String get showInFameCaption =>
      'Seulement le nom et l’apparence du héros – jamais ton vrai nom';

  @override
  String get account => 'Compte';

  @override
  String get heroName => 'Nom du héros';

  @override
  String get editHeroName => 'Changer le nom du héros';

  @override
  String get teamGroup => 'Équipe';

  @override
  String get teamMode => 'Ouvrir le mode équipe';

  @override
  String get teamModeCaption =>
      'Confirmer les visites, vérifier les photos et les bons';

  @override
  String get legal => 'Mentions légales';

  @override
  String get terms => 'Conditions de participation';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get imprint => 'Mentions légales (Impressum)';

  @override
  String get myData => 'Mes données';

  @override
  String get exportCaption => 'Fichier JSON avec toutes tes données';

  @override
  String get deleteCaption => 'Tes pièces et tes bons seront perdus.';

  @override
  String get hornCalls => 'Appels du cor';

  @override
  String get markAllRead => 'Tout marquer comme lu';

  @override
  String get today => 'Aujourd’hui';

  @override
  String get earlier => 'Plus tôt';

  @override
  String get counter => 'Comptoir';

  @override
  String get teamModeBadge => 'MODE ÉQUIPE';

  @override
  String get exitTeam => 'Quitter';

  @override
  String claimsTab(int count) {
    return 'Visites · $count';
  }

  @override
  String get voucherCheckTab => 'Vérifier un bon';

  @override
  String get highAmount => 'Montant élevé – vérifie le ticket';

  @override
  String get voucherCodeLabel => 'Code du bon client';

  @override
  String get voucherValid => 'Valable';

  @override
  String get voucherUsedHint =>
      'Le code est ensuite utilisé. Seuls les admins peuvent annuler.';

  @override
  String get welcomeHeadline => 'Chaque visite écrit ta saga.';

  @override
  String get welcomeBody =>
      'Scanne tes tickets, partage des moments de la halle et échange tes pièces contre du merch et des expériences exclusives.';

  @override
  String get continueWithEmail => 'E-mail';

  @override
  String get adultsOnlyFooter => 'Réservé aux 18 ans et plus';

  @override
  String get emailSignInTitle => 'Connexion par e-mail';

  @override
  String get newHereCreate => 'Nouveau ici ? Créer un compte';

  @override
  String get beforeYouEnter => 'Avant d’entrer dans la halle';

  @override
  String get ageBody =>
      'Valhalla Hero est réservé aux clients de 18 ans et plus. Ta date de naissance reste privée.';

  @override
  String get ageOk => 'C’est bon – bienvenue.';

  @override
  String get consentsTitle => 'Consentements';

  @override
  String get eventsNewsConsentCaption =>
      'Notifications push quand il se passe quelque chose dans la halle.';

  @override
  String get offersConsentCaption => 'Offres selon tes visites.';

  @override
  String get consentsFootnote =>
      'Les deux sont facultatifs et modifiables à tout moment dans les réglages. Tu reçois toujours les confirmations de tes visites.';

  @override
  String stepOf(int step, int total) {
    return 'Étape $step sur $total';
  }

  @override
  String get heroAwakes => 'Ton héros s’éveille';

  @override
  String get chooseForm =>
      'Choisis l’apparence de ton héros. Modifiable à tout moment – ta progression reste.';

  @override
  String get heroNameLabel => 'Nom de ton héros';

  @override
  String get heroNameHint =>
      'Affiché au Panthéon. Pas de vrais noms, s’il te plaît.';

  @override
  String get startJourney => 'Commencer l’aventure';

  @override
  String get eightLevels => '8 niveaux';

  @override
  String get appTagline => 'Tes visites. Ta légende.';

  @override
  String get dayMon => 'LUN';

  @override
  String get dayTue => 'MAR';

  @override
  String get dayWed => 'MER';

  @override
  String get dayThu => 'JEU';

  @override
  String get dayFri => 'VEN';

  @override
  String get daySat => 'SAM';

  @override
  String get daySun => 'DIM';

  @override
  String get comingSoon => 'Bientôt';

  @override
  String get tabEvents => 'Agenda';

  @override
  String get tabSaga => 'Saga';

  @override
  String get tabScan => 'Ajouter';

  @override
  String get tonight => 'Ce soir';

  @override
  String get tomorrow => 'Demain';

  @override
  String get liveNow => 'En cours';

  @override
  String get eventsEmpty => 'Aucun événement prévu pour le moment.';

  @override
  String get eventsPast => 'Événements passés';

  @override
  String get catMatch => 'Sport en direct';

  @override
  String get catLive => 'Musique live';

  @override
  String get catQuiz => 'Quiz';

  @override
  String get catParty => 'Soirée';

  @override
  String get catSpecial => 'Spécial';

  @override
  String get scanTitle => 'Scanner le ticket';

  @override
  String get scanHint => 'Vise le QR code de ton ticket avec l’appareil photo.';

  @override
  String get scanFromPhotos => 'Depuis les photos';

  @override
  String get scanEnterCode => 'Saisir le code';

  @override
  String get scanCodeHint => 'Imprimé sous le QR code de ton ticket.';

  @override
  String get scanNoQr => 'Signaler sans QR';

  @override
  String get scanDemo => 'Ticket démo';

  @override
  String get scanChecking => 'Vérification du ticket …';

  @override
  String get torch => 'Lampe';

  @override
  String get scanNoCamera =>
      'Aucun appareil photo disponible. Choisis une photo ou saisis le code.';

  @override
  String get scanNothingInImage => 'Aucun QR code trouvé dans l’image.';

  @override
  String get scanOnce =>
      'Chaque ticket compte une fois – XP par visite, pièces selon le montant.';

  @override
  String get receiptErrUsed => 'Ce ticket a déjà été utilisé.';

  @override
  String get receiptErrInvalid => 'Ce n’est pas un ticket Valhalla valide.';

  @override
  String get receiptErrTooOld => 'Ce ticket est trop ancien.';

  @override
  String get receiptErrUnknownVenue =>
      'Ce ticket ne vient pas d’un bar Valhalla.';

  @override
  String get receiptErrDailyLimit =>
      'Limite de tickets du jour atteinte. À demain !';

  @override
  String get receiptAdded => 'Ticket ajouté';

  @override
  String get receiptAddedHint =>
      'L’XP est par visite – les tickets suivants du jour rapportent des pièces.';

  @override
  String get sagaComposerTitle => 'Partage ton moment';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Photo de la halle ou avec du merch Valhalla · +$xp XP · +$coins pièces';
  }

  @override
  String get checkinNewTitle => 'Partager une photo';

  @override
  String get takePhoto => 'Appareil';

  @override
  String get pickPhoto => 'Galerie';

  @override
  String get captionHint => 'Que se passe-t-il dans la halle ?';

  @override
  String get tagEvent => 'Lier un événement';

  @override
  String get noEvent => 'Aucun événement';

  @override
  String get checkinRules =>
      'Uniquement des photos de la halle ou avec du merch Valhalla. L’équipe vérifie chaque photo avant qu’elle n’apparaisse dans la saga.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · +$coins pièces après validation (une fois par jour)';
  }

  @override
  String get checkinSubmit => 'Envoyer pour vérification';

  @override
  String get checkinPendingTitle => 'Ta photo est en cours de vérification';

  @override
  String get checkinPendingBody =>
      'Dès que l’équipe la valide, elle apparaît dans la saga. D’ici là, tu ne peux pas en envoyer d’autre.';

  @override
  String get checkinWithdraw => 'Retirer';

  @override
  String get checkinRejectedTitle => 'Photo non validée';

  @override
  String get checkinErrPending =>
      'Tu as déjà une photo en cours de vérification.';

  @override
  String get sagaEmpty =>
      'Pas encore de photos. Sois le premier ou la première !';

  @override
  String get justNow => 'à l’instant';

  @override
  String agoMinutes(int minutes) {
    return 'il y a $minutes min';
  }

  @override
  String agoHours(int hours) {
    return 'il y a $hours h';
  }

  @override
  String get photosInSaga => 'Photos dans la saga';

  @override
  String teamPhotosTab(int count) {
    return 'Photos · $count';
  }

  @override
  String get teamPhotosEmpty => 'Aucune photo à vérifier.';

  @override
  String get approvePhoto => 'Valider';

  @override
  String get helpFeedback => 'Aide & retours';

  @override
  String get reportBug => 'Signaler un bug';

  @override
  String get reportBugCaption => 'Quelque chose ne marche pas ? Dis-le-nous.';

  @override
  String get bugDescribe => 'Que s’est-il passé ?';

  @override
  String get bugHint =>
      'Décris brièvement ce que tu faisais et ce qui a mal tourné.';

  @override
  String get bugIncludeInfo => 'Joindre les infos de l’app et de l’appareil';

  @override
  String get bugSend => 'Envoyer';

  @override
  String get bugThanks => 'Merci ! On s’en occupe.';

  @override
  String get chooseLanguage => 'Choisir la langue';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count j’aime',
      one: '1 j’aime',
      zero: 'Pas encore de j’aime',
    );
    return '$_temp0';
  }
}
