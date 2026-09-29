import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
    Locale('pl'),
    Locale('ru'),
    Locale('tr'),
    Locale('uk'),
  ];

  /// No description provided for @appName.
  ///
  /// In de, this message translates to:
  /// **'Valhalla Hero'**
  String get appName;

  /// No description provided for @tabShop.
  ///
  /// In de, this message translates to:
  /// **'Beute'**
  String get tabShop;

  /// No description provided for @signIn.
  ///
  /// In de, this message translates to:
  /// **'Anmelden'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get signUp;

  /// No description provided for @signOut.
  ///
  /// In de, this message translates to:
  /// **'Abmelden'**
  String get signOut;

  /// No description provided for @email.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get password;

  /// No description provided for @nickname.
  ///
  /// In de, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @birthDate.
  ///
  /// In de, this message translates to:
  /// **'Geburtsdatum'**
  String get birthDate;

  /// No description provided for @ageGateError.
  ///
  /// In de, this message translates to:
  /// **'Du musst mindestens 18 Jahre alt sein.'**
  String get ageGateError;

  /// No description provided for @continueWithApple.
  ///
  /// In de, this message translates to:
  /// **'Mit Apple fortfahren'**
  String get continueWithApple;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In de, this message translates to:
  /// **'Schon ein Konto?'**
  String get alreadyHaveAccount;

  /// No description provided for @termsAccept.
  ///
  /// In de, this message translates to:
  /// **'Ich akzeptiere die Teilnahmebedingungen und habe die Datenschutzerklärung gelesen.'**
  String get termsAccept;

  /// No description provided for @createAccount.
  ///
  /// In de, this message translates to:
  /// **'Konto erstellen'**
  String get createAccount;

  /// No description provided for @signupConfirmTitle.
  ///
  /// In de, this message translates to:
  /// **'Bestätige deine E-Mail'**
  String get signupConfirmTitle;

  /// No description provided for @signupConfirmBody.
  ///
  /// In de, this message translates to:
  /// **'Wir haben einen Link an {email} geschickt. Öffne ihn und melde dich dann hier an.'**
  String signupConfirmBody(String email);

  /// No description provided for @completeProfile.
  ///
  /// In de, this message translates to:
  /// **'Profil vervollständigen'**
  String get completeProfile;

  /// No description provided for @authError.
  ///
  /// In de, this message translates to:
  /// **'Anmeldung fehlgeschlagen: {message}'**
  String authError(String message);

  /// No description provided for @xpLabel.
  ///
  /// In de, this message translates to:
  /// **'{xp} XP'**
  String xpLabel(int xp);

  /// No description provided for @onBoard.
  ///
  /// In de, this message translates to:
  /// **'An Bord'**
  String get onBoard;

  /// No description provided for @visitsCount.
  ///
  /// In de, this message translates to:
  /// **'{count} Besuche'**
  String visitsCount(int count);

  /// No description provided for @claimVisit.
  ///
  /// In de, this message translates to:
  /// **'Besuch melden'**
  String get claimVisit;

  /// No description provided for @claimVisitTitle.
  ///
  /// In de, this message translates to:
  /// **'Besuch melden'**
  String get claimVisitTitle;

  /// No description provided for @claimVenue.
  ///
  /// In de, this message translates to:
  /// **'Bar'**
  String get claimVenue;

  /// No description provided for @claimAmount.
  ///
  /// In de, this message translates to:
  /// **'Rechnungsbetrag (€)'**
  String get claimAmount;

  /// No description provided for @claimNote.
  ///
  /// In de, this message translates to:
  /// **'Notiz (optional)'**
  String get claimNote;

  /// No description provided for @claimTooManyPending.
  ///
  /// In de, this message translates to:
  /// **'Du hast zu viele offene Meldungen.'**
  String get claimTooManyPending;

  /// No description provided for @claimStatusApproved.
  ///
  /// In de, this message translates to:
  /// **'Bestätigt'**
  String get claimStatusApproved;

  /// No description provided for @claimStatusRejected.
  ///
  /// In de, this message translates to:
  /// **'Abgelehnt'**
  String get claimStatusRejected;

  /// No description provided for @myClaims.
  ///
  /// In de, this message translates to:
  /// **'Meine Meldungen'**
  String get myClaims;

  /// No description provided for @achievements.
  ///
  /// In de, this message translates to:
  /// **'Erfolge'**
  String get achievements;

  /// No description provided for @achievementsUnlocked.
  ///
  /// In de, this message translates to:
  /// **'{unlocked} von {total} freigeschaltet'**
  String achievementsUnlocked(int unlocked, int total);

  /// No description provided for @locked.
  ///
  /// In de, this message translates to:
  /// **'Gesperrt'**
  String get locked;

  /// No description provided for @rewards.
  ///
  /// In de, this message translates to:
  /// **'Belohnungen'**
  String get rewards;

  /// No description provided for @gear.
  ///
  /// In de, this message translates to:
  /// **'Ausrüstung'**
  String get gear;

  /// No description provided for @myVouchers.
  ///
  /// In de, this message translates to:
  /// **'Meine Gutscheine'**
  String get myVouchers;

  /// No description provided for @redeemed.
  ///
  /// In de, this message translates to:
  /// **'Eingelöst! Zeige diesen Code an der Theke.'**
  String get redeemed;

  /// No description provided for @insufficientCoins.
  ///
  /// In de, this message translates to:
  /// **'Nicht genug Münzen.'**
  String get insufficientCoins;

  /// No description provided for @outOfStock.
  ///
  /// In de, this message translates to:
  /// **'Ausverkauft'**
  String get outOfStock;

  /// No description provided for @stockLeft.
  ///
  /// In de, this message translates to:
  /// **'Noch {count}'**
  String stockLeft(int count);

  /// No description provided for @validUntil.
  ///
  /// In de, this message translates to:
  /// **'Gültig bis {date}'**
  String validUntil(String date);

  /// No description provided for @voucherActive.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get voucherActive;

  /// No description provided for @voucherRedeemed.
  ///
  /// In de, this message translates to:
  /// **'Eingelöst'**
  String get voucherRedeemed;

  /// No description provided for @voucherExpired.
  ///
  /// In de, this message translates to:
  /// **'Abgelaufen'**
  String get voucherExpired;

  /// No description provided for @voucherCancelled.
  ///
  /// In de, this message translates to:
  /// **'Storniert'**
  String get voucherCancelled;

  /// No description provided for @rewardTypeMerch.
  ///
  /// In de, this message translates to:
  /// **'Merch'**
  String get rewardTypeMerch;

  /// No description provided for @rewardTypeDrink.
  ///
  /// In de, this message translates to:
  /// **'Getränk'**
  String get rewardTypeDrink;

  /// No description provided for @rewardTypeDiscount.
  ///
  /// In de, this message translates to:
  /// **'Rabatt'**
  String get rewardTypeDiscount;

  /// No description provided for @rewardTypePriorityBooking.
  ///
  /// In de, this message translates to:
  /// **'Reservierung'**
  String get rewardTypePriorityBooking;

  /// No description provided for @rewardTypeEventAccess.
  ///
  /// In de, this message translates to:
  /// **'Event'**
  String get rewardTypeEventAccess;

  /// No description provided for @owned.
  ///
  /// In de, this message translates to:
  /// **'Im Besitz'**
  String get owned;

  /// No description provided for @equip.
  ///
  /// In de, this message translates to:
  /// **'Anlegen'**
  String get equip;

  /// No description provided for @equipped.
  ///
  /// In de, this message translates to:
  /// **'Angelegt'**
  String get equipped;

  /// No description provided for @unequip.
  ///
  /// In de, this message translates to:
  /// **'Ablegen'**
  String get unequip;

  /// No description provided for @purchaseDone.
  ///
  /// In de, this message translates to:
  /// **'Gekauft. Du kannst es jetzt anlegen.'**
  String get purchaseDone;

  /// No description provided for @unlockAtLevel.
  ///
  /// In de, this message translates to:
  /// **'Ab Stufe {level}'**
  String unlockAtLevel(int level);

  /// No description provided for @unlockByAchievement.
  ///
  /// In de, this message translates to:
  /// **'Erfolg: {name}'**
  String unlockByAchievement(String name);

  /// No description provided for @unlockByEvent.
  ///
  /// In de, this message translates to:
  /// **'Nur bei Events'**
  String get unlockByEvent;

  /// No description provided for @slotHeadgear.
  ///
  /// In de, this message translates to:
  /// **'Kopf'**
  String get slotHeadgear;

  /// No description provided for @slotHandItem.
  ///
  /// In de, this message translates to:
  /// **'Hand'**
  String get slotHandItem;

  /// No description provided for @slotCape.
  ///
  /// In de, this message translates to:
  /// **'Umhang'**
  String get slotCape;

  /// No description provided for @slotCompanion.
  ///
  /// In de, this message translates to:
  /// **'Gefährte'**
  String get slotCompanion;

  /// No description provided for @slotFrame.
  ///
  /// In de, this message translates to:
  /// **'Rahmen'**
  String get slotFrame;

  /// No description provided for @rarityCommon.
  ///
  /// In de, this message translates to:
  /// **'Gewöhnlich'**
  String get rarityCommon;

  /// No description provided for @rarityRare.
  ///
  /// In de, this message translates to:
  /// **'Selten'**
  String get rarityRare;

  /// No description provided for @rarityLegendary.
  ///
  /// In de, this message translates to:
  /// **'Legendär'**
  String get rarityLegendary;

  /// No description provided for @leaderboardTitle.
  ///
  /// In de, this message translates to:
  /// **'Rangliste'**
  String get leaderboardTitle;

  /// No description provided for @leaderboardYou.
  ///
  /// In de, this message translates to:
  /// **'Du'**
  String get leaderboardYou;

  /// No description provided for @leaderboardHidden.
  ///
  /// In de, this message translates to:
  /// **'Du bist in der Rangliste ausgeblendet.'**
  String get leaderboardHidden;

  /// No description provided for @postTypeNews.
  ///
  /// In de, this message translates to:
  /// **'News'**
  String get postTypeNews;

  /// No description provided for @postTypeEvent.
  ///
  /// In de, this message translates to:
  /// **'Event'**
  String get postTypeEvent;

  /// No description provided for @notifications.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get notifications;

  /// No description provided for @notificationsEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Nachrichten.'**
  String get notificationsEmpty;

  /// No description provided for @settings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get language;

  /// No description provided for @leaderboardVisible.
  ///
  /// In de, this message translates to:
  /// **'In der Rangliste sichtbar'**
  String get leaderboardVisible;

  /// No description provided for @privacy.
  ///
  /// In de, this message translates to:
  /// **'Datenschutz'**
  String get privacy;

  /// No description provided for @exportData.
  ///
  /// In de, this message translates to:
  /// **'Meine Daten exportieren'**
  String get exportData;

  /// No description provided for @exportDataDone.
  ///
  /// In de, this message translates to:
  /// **'Export erstellt.'**
  String get exportDataDone;

  /// No description provided for @deleteAccount.
  ///
  /// In de, this message translates to:
  /// **'Konto löschen'**
  String get deleteAccount;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In de, this message translates to:
  /// **'Konto wirklich löschen?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountBody.
  ///
  /// In de, this message translates to:
  /// **'Alle Daten, XP und {coins} Münzen werden unwiderruflich gelöscht.'**
  String deleteAccountBody(int coins);

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In de, this message translates to:
  /// **'Bestätigen'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// No description provided for @gotIt.
  ///
  /// In de, this message translates to:
  /// **'Verstanden'**
  String get gotIt;

  /// No description provided for @retry.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get retry;

  /// No description provided for @staffClaimsEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine offenen Meldungen.'**
  String get staffClaimsEmpty;

  /// No description provided for @staffApprove.
  ///
  /// In de, this message translates to:
  /// **'Bestätigen'**
  String get staffApprove;

  /// No description provided for @staffReject.
  ///
  /// In de, this message translates to:
  /// **'Ablehnen'**
  String get staffReject;

  /// No description provided for @staffRejectReason.
  ///
  /// In de, this message translates to:
  /// **'Grund (optional)'**
  String get staffRejectReason;

  /// No description provided for @staffVoucherConfirm.
  ///
  /// In de, this message translates to:
  /// **'Als eingelöst markieren'**
  String get staffVoucherConfirm;

  /// No description provided for @staffVoucherNotFound.
  ///
  /// In de, this message translates to:
  /// **'Kein Gutschein mit diesem Code.'**
  String get staffVoucherNotFound;

  /// No description provided for @staffVoucherDone.
  ///
  /// In de, this message translates to:
  /// **'Gutschein eingelöst.'**
  String get staffVoucherDone;

  /// No description provided for @staffCredit.
  ///
  /// In de, this message translates to:
  /// **'Besuch manuell gutschreiben'**
  String get staffCredit;

  /// No description provided for @adminDashboard.
  ///
  /// In de, this message translates to:
  /// **'Übersicht'**
  String get adminDashboard;

  /// No description provided for @adminUsers.
  ///
  /// In de, this message translates to:
  /// **'Gäste'**
  String get adminUsers;

  /// No description provided for @adminClaims.
  ///
  /// In de, this message translates to:
  /// **'Meldungen'**
  String get adminClaims;

  /// No description provided for @adminRewards.
  ///
  /// In de, this message translates to:
  /// **'Belohnungen'**
  String get adminRewards;

  /// No description provided for @adminItems.
  ///
  /// In de, this message translates to:
  /// **'Ausrüstung'**
  String get adminItems;

  /// No description provided for @adminPosts.
  ///
  /// In de, this message translates to:
  /// **'Saga'**
  String get adminPosts;

  /// No description provided for @adminVenues.
  ///
  /// In de, this message translates to:
  /// **'Bars'**
  String get adminVenues;

  /// No description provided for @adminEconomy.
  ///
  /// In de, this message translates to:
  /// **'Ökonomie'**
  String get adminEconomy;

  /// No description provided for @adminStatUsers.
  ///
  /// In de, this message translates to:
  /// **'Gäste'**
  String get adminStatUsers;

  /// No description provided for @adminStatOnBoard.
  ///
  /// In de, this message translates to:
  /// **'An Bord'**
  String get adminStatOnBoard;

  /// No description provided for @adminStatVisits30.
  ///
  /// In de, this message translates to:
  /// **'Besuche (30 Tage)'**
  String get adminStatVisits30;

  /// No description provided for @adminStatRevenue30.
  ///
  /// In de, this message translates to:
  /// **'Umsatz (30 Tage)'**
  String get adminStatRevenue30;

  /// No description provided for @adminStatPending.
  ///
  /// In de, this message translates to:
  /// **'Offene Meldungen'**
  String get adminStatPending;

  /// No description provided for @adminStatCoins.
  ///
  /// In de, this message translates to:
  /// **'Münzen im Umlauf'**
  String get adminStatCoins;

  /// No description provided for @adminStatVouchersActive.
  ///
  /// In de, this message translates to:
  /// **'Aktive Gutscheine'**
  String get adminStatVouchersActive;

  /// No description provided for @adminStatVouchersRedeemed30.
  ///
  /// In de, this message translates to:
  /// **'Eingelöst (30 Tage)'**
  String get adminStatVouchersRedeemed30;

  /// No description provided for @adminNewPost.
  ///
  /// In de, this message translates to:
  /// **'Neuer Beitrag'**
  String get adminNewPost;

  /// No description provided for @adminPublish.
  ///
  /// In de, this message translates to:
  /// **'Veröffentlichen'**
  String get adminPublish;

  /// No description provided for @adminDraft.
  ///
  /// In de, this message translates to:
  /// **'Entwurf'**
  String get adminDraft;

  /// No description provided for @adminTitle.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get adminTitle;

  /// No description provided for @adminBody.
  ///
  /// In de, this message translates to:
  /// **'Text'**
  String get adminBody;

  /// No description provided for @adminImageUrl.
  ///
  /// In de, this message translates to:
  /// **'Bild-URL'**
  String get adminImageUrl;

  /// No description provided for @adminStartsAt.
  ///
  /// In de, this message translates to:
  /// **'Beginn'**
  String get adminStartsAt;

  /// No description provided for @adminEndsAt.
  ///
  /// In de, this message translates to:
  /// **'Ende (optional)'**
  String get adminEndsAt;

  /// No description provided for @adminCategory.
  ///
  /// In de, this message translates to:
  /// **'Kategorie'**
  String get adminCategory;

  /// No description provided for @adminPrice.
  ///
  /// In de, this message translates to:
  /// **'Preis (Münzen)'**
  String get adminPrice;

  /// No description provided for @adminStock.
  ///
  /// In de, this message translates to:
  /// **'Bestand (leer = unbegrenzt)'**
  String get adminStock;

  /// No description provided for @adminValidityDays.
  ///
  /// In de, this message translates to:
  /// **'Gültigkeit (Tage)'**
  String get adminValidityDays;

  /// No description provided for @adminActive.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get adminActive;

  /// No description provided for @adminRole.
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get adminRole;

  /// No description provided for @adminSearch.
  ///
  /// In de, this message translates to:
  /// **'Suchen'**
  String get adminSearch;

  /// No description provided for @adminEconomyXpPerVisit.
  ///
  /// In de, this message translates to:
  /// **'XP pro Besuch'**
  String get adminEconomyXpPerVisit;

  /// No description provided for @adminEconomyCoinsPerEuro.
  ///
  /// In de, this message translates to:
  /// **'Münzen pro Euro'**
  String get adminEconomyCoinsPerEuro;

  /// No description provided for @adminEconomyDailyCap.
  ///
  /// In de, this message translates to:
  /// **'Tageslimit Münzen'**
  String get adminEconomyDailyCap;

  /// No description provided for @adminEconomyExpiryMonths.
  ///
  /// In de, this message translates to:
  /// **'Verfall (Monate)'**
  String get adminEconomyExpiryMonths;

  /// No description provided for @adminEconomyOnboardDays.
  ///
  /// In de, this message translates to:
  /// **'An Bord (Tage)'**
  String get adminEconomyOnboardDays;

  /// No description provided for @adminEconomyStreakBonus.
  ///
  /// In de, this message translates to:
  /// **'Streak-Bonus XP'**
  String get adminEconomyStreakBonus;

  /// No description provided for @adminLevels.
  ///
  /// In de, this message translates to:
  /// **'Stufen'**
  String get adminLevels;

  /// No description provided for @adminLevelThreshold.
  ///
  /// In de, this message translates to:
  /// **'XP-Schwelle'**
  String get adminLevelThreshold;

  /// No description provided for @adminLevelMultiplier.
  ///
  /// In de, this message translates to:
  /// **'Münz-Multiplikator'**
  String get adminLevelMultiplier;

  /// No description provided for @adminSaved.
  ///
  /// In de, this message translates to:
  /// **'Gespeichert.'**
  String get adminSaved;

  /// No description provided for @adminNotAllowed.
  ///
  /// In de, this message translates to:
  /// **'Nur für Administratoren.'**
  String get adminNotAllowed;

  /// No description provided for @coinReasonVisit.
  ///
  /// In de, this message translates to:
  /// **'Besuch'**
  String get coinReasonVisit;

  /// No description provided for @coinReasonAchievement.
  ///
  /// In de, this message translates to:
  /// **'Erfolg'**
  String get coinReasonAchievement;

  /// No description provided for @coinReasonManual.
  ///
  /// In de, this message translates to:
  /// **'Team-Gutschrift'**
  String get coinReasonManual;

  /// No description provided for @coinReasonReward.
  ///
  /// In de, this message translates to:
  /// **'Belohnung'**
  String get coinReasonReward;

  /// No description provided for @coinReasonItem.
  ///
  /// In de, this message translates to:
  /// **'Ausrüstung'**
  String get coinReasonItem;

  /// No description provided for @coinReasonExpiry.
  ///
  /// In de, this message translates to:
  /// **'Verfall'**
  String get coinReasonExpiry;

  /// No description provided for @coinReasonRefund.
  ///
  /// In de, this message translates to:
  /// **'Erstattung'**
  String get coinReasonRefund;

  /// No description provided for @coinReasonCheckin.
  ///
  /// In de, this message translates to:
  /// **'Foto in der Saga'**
  String get coinReasonCheckin;

  /// No description provided for @tabHero.
  ///
  /// In de, this message translates to:
  /// **'Held'**
  String get tabHero;

  /// No description provided for @heroPath.
  ///
  /// In de, this message translates to:
  /// **'Heldenweg'**
  String get heroPath;

  /// No description provided for @statStreak.
  ///
  /// In de, this message translates to:
  /// **'Serie'**
  String get statStreak;

  /// No description provided for @statOnBoard.
  ///
  /// In de, this message translates to:
  /// **'An Bord'**
  String get statOnBoard;

  /// No description provided for @statVisits.
  ///
  /// In de, this message translates to:
  /// **'Besuche'**
  String get statVisits;

  /// No description provided for @weeksCount.
  ///
  /// In de, this message translates to:
  /// **'{weeks, plural, =1{1 Woche} other{{weeks} Wochen}}'**
  String weeksCount(int weeks);

  /// No description provided for @daysCount.
  ///
  /// In de, this message translates to:
  /// **'{days, plural, =1{1 Tag} other{{days} Tage}}'**
  String daysCount(int days);

  /// No description provided for @thisWeek.
  ///
  /// In de, this message translates to:
  /// **'Diese Woche'**
  String get thisWeek;

  /// No description provided for @all.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get all;

  /// No description provided for @claimSheetSub.
  ///
  /// In de, this message translates to:
  /// **'Das Team an der Theke bestätigt deinen Besuch.'**
  String get claimSheetSub;

  /// No description provided for @claimWhere.
  ///
  /// In de, this message translates to:
  /// **'Wo bist du?'**
  String get claimWhere;

  /// No description provided for @change.
  ///
  /// In de, this message translates to:
  /// **'Ändern'**
  String get change;

  /// No description provided for @claimAmountLabel.
  ///
  /// In de, this message translates to:
  /// **'Rechnungsbetrag'**
  String get claimAmountLabel;

  /// No description provided for @claimAmountHint.
  ///
  /// In de, this message translates to:
  /// **'Bestimmt nur deine Münzen. XP gibt es pro Besuch – nie pro Euro.'**
  String get claimAmountHint;

  /// No description provided for @claimNoteLabel.
  ///
  /// In de, this message translates to:
  /// **'Notiz fürs Team (optional)'**
  String get claimNoteLabel;

  /// No description provided for @claimNoteHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Tisch 7'**
  String get claimNoteHint;

  /// No description provided for @claimPreview.
  ///
  /// In de, this message translates to:
  /// **'Nach der Bestätigung erhältst du'**
  String get claimPreview;

  /// No description provided for @streakBonus.
  ///
  /// In de, this message translates to:
  /// **'+{xp} Serienbonus'**
  String streakBonus(int xp);

  /// No description provided for @claimSentTitle.
  ///
  /// In de, this message translates to:
  /// **'Besuch gemeldet'**
  String get claimSentTitle;

  /// No description provided for @claimSentBody.
  ///
  /// In de, this message translates to:
  /// **'Zeig dem Team diesen Code – dann geht’s am schnellsten.'**
  String get claimSentBody;

  /// No description provided for @yourVisitCode.
  ///
  /// In de, this message translates to:
  /// **'Dein Besuchscode'**
  String get yourVisitCode;

  /// No description provided for @stepReported.
  ///
  /// In de, this message translates to:
  /// **'Gemeldet'**
  String get stepReported;

  /// No description provided for @stepChecking.
  ///
  /// In de, this message translates to:
  /// **'Wird geprüft'**
  String get stepChecking;

  /// No description provided for @stepCheckingSub.
  ///
  /// In de, this message translates to:
  /// **'Meist in unter 5 Minuten'**
  String get stepCheckingSub;

  /// No description provided for @stepCredited.
  ///
  /// In de, this message translates to:
  /// **'Gutgeschrieben'**
  String get stepCredited;

  /// No description provided for @stepCreditedSub.
  ///
  /// In de, this message translates to:
  /// **'XP, Serienbonus und Münzen'**
  String get stepCreditedSub;

  /// No description provided for @hornWillCall.
  ///
  /// In de, this message translates to:
  /// **'Wir melden uns per Hornruf.'**
  String get hornWillCall;

  /// No description provided for @toHall.
  ///
  /// In de, this message translates to:
  /// **'Zur Halle'**
  String get toHall;

  /// No description provided for @claimRejectedTitle.
  ///
  /// In de, this message translates to:
  /// **'Besuch abgelehnt'**
  String get claimRejectedTitle;

  /// No description provided for @claimRejectedBody.
  ///
  /// In de, this message translates to:
  /// **'Sprich kurz mit dem Team an der Theke.'**
  String get claimRejectedBody;

  /// No description provided for @visitConfirmed.
  ///
  /// In de, this message translates to:
  /// **'Besuch bestätigt'**
  String get visitConfirmed;

  /// No description provided for @hallHonours.
  ///
  /// In de, this message translates to:
  /// **'Die Halle ehrt dich, {name}'**
  String hallHonours(String name);

  /// No description provided for @experience.
  ///
  /// In de, this message translates to:
  /// **'Erfahrung'**
  String get experience;

  /// No description provided for @coinsWord.
  ///
  /// In de, this message translates to:
  /// **'Münzen'**
  String get coinsWord;

  /// No description provided for @streakNow.
  ///
  /// In de, this message translates to:
  /// **'{weeks, plural, =1{1 Woche an Bord} other{{weeks} Wochen an Bord!}}'**
  String streakNow(int weeks);

  /// No description provided for @streakKept.
  ///
  /// In de, this message translates to:
  /// **'Serie gehalten – weiter so.'**
  String get streakKept;

  /// No description provided for @achievementUnlocked.
  ///
  /// In de, this message translates to:
  /// **'Erfolg freigeschaltet'**
  String get achievementUnlocked;

  /// No description provided for @continueLabel.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get continueLabel;

  /// No description provided for @levelReached.
  ///
  /// In de, this message translates to:
  /// **'Stufe {level} erreicht!'**
  String levelReached(String level);

  /// No description provided for @coinBonus.
  ///
  /// In de, this message translates to:
  /// **'Münz-Bonus ×{mult}'**
  String coinBonus(String mult);

  /// No description provided for @coinBonusSub.
  ///
  /// In de, this message translates to:
  /// **'Vorher ×{mult} – auf jeden Besuch'**
  String coinBonusSub(String mult);

  /// No description provided for @newGear.
  ///
  /// In de, this message translates to:
  /// **'Neu in deiner Ausrüstung'**
  String get newGear;

  /// No description provided for @newBackdrop.
  ///
  /// In de, this message translates to:
  /// **'Neue Kulisse'**
  String get newBackdrop;

  /// No description provided for @equipItem.
  ///
  /// In de, this message translates to:
  /// **'{item} anlegen'**
  String equipItem(String item);

  /// No description provided for @later.
  ///
  /// In de, this message translates to:
  /// **'Später'**
  String get later;

  /// No description provided for @shareLevel.
  ///
  /// In de, this message translates to:
  /// **'Aufstieg teilen'**
  String get shareLevel;

  /// No description provided for @shareLevelText.
  ///
  /// In de, this message translates to:
  /// **'Ich bin jetzt {level} in Valhalla Hero!'**
  String shareLevelText(String level);

  /// No description provided for @ownedOf.
  ///
  /// In de, this message translates to:
  /// **'{owned} von {total} im Besitz'**
  String ownedOf(int owned, int total);

  /// No description provided for @cosmeticOnly.
  ///
  /// In de, this message translates to:
  /// **'Rein kosmetisch – kein Einfluss aufs Spiel'**
  String get cosmeticOnly;

  /// No description provided for @heroForm.
  ///
  /// In de, this message translates to:
  /// **'Heldenform'**
  String get heroForm;

  /// No description provided for @heroFormHero.
  ///
  /// In de, this message translates to:
  /// **'Held'**
  String get heroFormHero;

  /// No description provided for @heroFormHeroine.
  ///
  /// In de, this message translates to:
  /// **'Heldin'**
  String get heroFormHeroine;

  /// No description provided for @heroFormHint.
  ///
  /// In de, this message translates to:
  /// **'Held oder Heldin – dein Fortschritt bleibt'**
  String get heroFormHint;

  /// No description provided for @levelOfEight.
  ///
  /// In de, this message translates to:
  /// **'Stufe {roman} von VIII'**
  String levelOfEight(String roman);

  /// No description provided for @xpToValhalla.
  ///
  /// In de, this message translates to:
  /// **'{xp} von {max} XP bis Walhalla'**
  String xpToValhalla(String xp, String max);

  /// No description provided for @yourLevel.
  ///
  /// In de, this message translates to:
  /// **'Deine Stufe'**
  String get yourLevel;

  /// No description provided for @nextUp.
  ///
  /// In de, this message translates to:
  /// **'Als Nächstes'**
  String get nextUp;

  /// No description provided for @fromXp.
  ///
  /// In de, this message translates to:
  /// **'ab {xp} XP'**
  String fromXp(String xp);

  /// No description provided for @xpLeft.
  ///
  /// In de, this message translates to:
  /// **'noch {xp} XP'**
  String xpLeft(String xp);

  /// No description provided for @reached.
  ///
  /// In de, this message translates to:
  /// **'Erreicht'**
  String get reached;

  /// No description provided for @almostThere.
  ///
  /// In de, this message translates to:
  /// **'Fast geschafft: {name}'**
  String almostThere(String name);

  /// No description provided for @longestStreak.
  ///
  /// In de, this message translates to:
  /// **'Rekord {weeks}'**
  String longestStreak(int weeks);

  /// No description provided for @rewardsRedeemed.
  ///
  /// In de, this message translates to:
  /// **'Beute eingelöst'**
  String get rewardsRedeemed;

  /// No description provided for @itemsOwned.
  ///
  /// In de, this message translates to:
  /// **'Ausrüstung im Besitz'**
  String get itemsOwned;

  /// No description provided for @yourBalance.
  ///
  /// In de, this message translates to:
  /// **'Dein Guthaben'**
  String get yourBalance;

  /// No description provided for @coinPurse.
  ///
  /// In de, this message translates to:
  /// **'Münzbeutel'**
  String get coinPurse;

  /// No description provided for @coinsExpireSoon.
  ///
  /// In de, this message translates to:
  /// **'{coins} Münzen verfallen am {date}'**
  String coinsExpireSoon(int coins, String date);

  /// No description provided for @redeemBeforeExpiry.
  ///
  /// In de, this message translates to:
  /// **'Tausche sie vorher in der Beute ein.'**
  String get redeemBeforeExpiry;

  /// No description provided for @segVouchers.
  ///
  /// In de, this message translates to:
  /// **'Gutscheine'**
  String get segVouchers;

  /// No description provided for @allRewards.
  ///
  /// In de, this message translates to:
  /// **'Alle Belohnungen'**
  String get allRewards;

  /// No description provided for @missingCoins.
  ///
  /// In de, this message translates to:
  /// **'Dir fehlen {coins}'**
  String missingCoins(String coins);

  /// No description provided for @holdToRedeem.
  ///
  /// In de, this message translates to:
  /// **'Gedrückt halten zum Eintauschen'**
  String get holdToRedeem;

  /// No description provided for @holdHint.
  ///
  /// In de, this message translates to:
  /// **'Kein versehentliches Ausgeben – erst nach dem Halten bestätigt.'**
  String get holdHint;

  /// No description provided for @priceLabel.
  ///
  /// In de, this message translates to:
  /// **'Preis'**
  String get priceLabel;

  /// No description provided for @balanceAfter.
  ///
  /// In de, this message translates to:
  /// **'Guthaben danach'**
  String get balanceAfter;

  /// No description provided for @validLabel.
  ///
  /// In de, this message translates to:
  /// **'Gültig'**
  String get validLabel;

  /// No description provided for @validDays.
  ///
  /// In de, this message translates to:
  /// **'{days} Tage ab Eintausch'**
  String validDays(int days);

  /// No description provided for @redeemHow.
  ///
  /// In de, this message translates to:
  /// **'Einlösen'**
  String get redeemHow;

  /// No description provided for @showCodeAtBar.
  ///
  /// In de, this message translates to:
  /// **'Code an der Theke zeigen'**
  String get showCodeAtBar;

  /// No description provided for @noVouchers.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Gutscheine. Tausche Münzen gegen Beute ein.'**
  String get noVouchers;

  /// No description provided for @showThisCode.
  ///
  /// In de, this message translates to:
  /// **'Zeig diesen Code an der Theke'**
  String get showThisCode;

  /// No description provided for @validUntilDays.
  ///
  /// In de, this message translates to:
  /// **'Gültig bis {date} · {days, plural, =1{noch 1 Tag} other{noch {days} Tage}}'**
  String validUntilDays(String date, int days);

  /// No description provided for @redeemedOn.
  ///
  /// In de, this message translates to:
  /// **'Eingelöst am {date}'**
  String redeemedOn(String date);

  /// No description provided for @exchangedOn.
  ///
  /// In de, this message translates to:
  /// **'Eingetauscht am {date} · {coins} Münzen'**
  String exchangedOn(String date, String coins);

  /// No description provided for @stepShowCode.
  ///
  /// In de, this message translates to:
  /// **'Code zeigen'**
  String get stepShowCode;

  /// No description provided for @stepTeamConfirms.
  ///
  /// In de, this message translates to:
  /// **'Team bestätigt'**
  String get stepTeamConfirms;

  /// No description provided for @stepEnjoy.
  ///
  /// In de, this message translates to:
  /// **'Vorteil genießen'**
  String get stepEnjoy;

  /// No description provided for @voucherLiveNote.
  ///
  /// In de, this message translates to:
  /// **'Der Status aktualisiert sich live, sobald das Team bestätigt.'**
  String get voucherLiveNote;

  /// No description provided for @expiryInfo.
  ///
  /// In de, this message translates to:
  /// **'Münzen verfallen nach {months} Monaten'**
  String expiryInfo(int months);

  /// No description provided for @xpNeverExpires.
  ///
  /// In de, this message translates to:
  /// **'XP verfallen nie'**
  String get xpNeverExpires;

  /// No description provided for @coinsNoCash.
  ///
  /// In de, this message translates to:
  /// **'Münzen sind ein freiwilliger Treue-Vorteil ohne Geldwert und werden nicht ausgezahlt.'**
  String get coinsNoCash;

  /// No description provided for @toShop.
  ///
  /// In de, this message translates to:
  /// **'Zur Beute'**
  String get toShop;

  /// No description provided for @fameTitle.
  ///
  /// In de, this message translates to:
  /// **'Ruhmeshalle'**
  String get fameTitle;

  /// No description provided for @allHeroes.
  ///
  /// In de, this message translates to:
  /// **'Alle Helden'**
  String get allHeroes;

  /// No description provided for @rankHeader.
  ///
  /// In de, this message translates to:
  /// **'PLATZ · HELD'**
  String get rankHeader;

  /// No description provided for @yourPosition.
  ///
  /// In de, this message translates to:
  /// **'Deine Position'**
  String get yourPosition;

  /// No description provided for @xpToRank.
  ///
  /// In de, this message translates to:
  /// **'Noch {xp} XP bis Platz {rank}'**
  String xpToRank(String xp, int rank);

  /// No description provided for @alleyTitle.
  ///
  /// In de, this message translates to:
  /// **'Allee der Unsterblichen'**
  String get alleyTitle;

  /// No description provided for @alleyBody.
  ///
  /// In de, this message translates to:
  /// **'Wer Stufe VIII erreicht – als Einherjar oder Valkyrja –, bekommt hier für immer eine Statue.'**
  String get alleyBody;

  /// No description provided for @alleyFree.
  ///
  /// In de, this message translates to:
  /// **'Noch frei'**
  String get alleyFree;

  /// No description provided for @rankInFame.
  ///
  /// In de, this message translates to:
  /// **'Platz {rank} der Ruhmeshalle'**
  String rankInFame(int rank);

  /// No description provided for @reportName.
  ///
  /// In de, this message translates to:
  /// **'Heldennamen melden'**
  String get reportName;

  /// No description provided for @reportThanks.
  ///
  /// In de, this message translates to:
  /// **'Danke – wir sehen uns das an.'**
  String get reportThanks;

  /// No description provided for @share.
  ///
  /// In de, this message translates to:
  /// **'Teilen'**
  String get share;

  /// No description provided for @directions.
  ///
  /// In de, this message translates to:
  /// **'Route'**
  String get directions;

  /// No description provided for @eventsNews.
  ///
  /// In de, this message translates to:
  /// **'Events & Neuigkeiten'**
  String get eventsNews;

  /// No description provided for @optionalRevocable.
  ///
  /// In de, this message translates to:
  /// **'Freiwillig · jederzeit widerrufbar'**
  String get optionalRevocable;

  /// No description provided for @personalOffers.
  ///
  /// In de, this message translates to:
  /// **'Persönliche Angebote'**
  String get personalOffers;

  /// No description provided for @personalOffersCaption.
  ///
  /// In de, this message translates to:
  /// **'Freiwillig · auf Basis deiner Besuche'**
  String get personalOffersCaption;

  /// No description provided for @serviceNotifications.
  ///
  /// In de, this message translates to:
  /// **'Besuche & Belohnungen'**
  String get serviceNotifications;

  /// No description provided for @serviceNotificationsCaption.
  ///
  /// In de, this message translates to:
  /// **'Bestätigungen, Level-Ups, ablaufende Münzen'**
  String get serviceNotificationsCaption;

  /// No description provided for @alwaysOn.
  ///
  /// In de, this message translates to:
  /// **'Immer an'**
  String get alwaysOn;

  /// No description provided for @showInFame.
  ///
  /// In de, this message translates to:
  /// **'In der Ruhmeshalle zeigen'**
  String get showInFame;

  /// No description provided for @showInFameCaption.
  ///
  /// In de, this message translates to:
  /// **'Nur Heldenname und Held – nie dein Klarname'**
  String get showInFameCaption;

  /// No description provided for @account.
  ///
  /// In de, this message translates to:
  /// **'Konto'**
  String get account;

  /// No description provided for @heroName.
  ///
  /// In de, this message translates to:
  /// **'Heldenname'**
  String get heroName;

  /// No description provided for @editHeroName.
  ///
  /// In de, this message translates to:
  /// **'Heldenname ändern'**
  String get editHeroName;

  /// No description provided for @teamGroup.
  ///
  /// In de, this message translates to:
  /// **'Team'**
  String get teamGroup;

  /// No description provided for @teamMode.
  ///
  /// In de, this message translates to:
  /// **'Team-Modus öffnen'**
  String get teamMode;

  /// No description provided for @teamModeCaption.
  ///
  /// In de, this message translates to:
  /// **'Besuche bestätigen, Fotos prüfen, Gutscheine checken'**
  String get teamModeCaption;

  /// No description provided for @legal.
  ///
  /// In de, this message translates to:
  /// **'Rechtliches'**
  String get legal;

  /// No description provided for @terms.
  ///
  /// In de, this message translates to:
  /// **'Teilnahmebedingungen'**
  String get terms;

  /// No description provided for @privacyPolicy.
  ///
  /// In de, this message translates to:
  /// **'Datenschutzerklärung'**
  String get privacyPolicy;

  /// No description provided for @imprint.
  ///
  /// In de, this message translates to:
  /// **'Impressum'**
  String get imprint;

  /// No description provided for @myData.
  ///
  /// In de, this message translates to:
  /// **'Meine Daten'**
  String get myData;

  /// No description provided for @exportCaption.
  ///
  /// In de, this message translates to:
  /// **'JSON-Datei mit allen deinen Daten'**
  String get exportCaption;

  /// No description provided for @deleteCaption.
  ///
  /// In de, this message translates to:
  /// **'Deine Münzen und Gutscheine verfallen dabei.'**
  String get deleteCaption;

  /// No description provided for @hornCalls.
  ///
  /// In de, this message translates to:
  /// **'Hornrufe'**
  String get hornCalls;

  /// No description provided for @markAllRead.
  ///
  /// In de, this message translates to:
  /// **'Alle gelesen'**
  String get markAllRead;

  /// No description provided for @today.
  ///
  /// In de, this message translates to:
  /// **'Heute'**
  String get today;

  /// No description provided for @earlier.
  ///
  /// In de, this message translates to:
  /// **'Früher'**
  String get earlier;

  /// No description provided for @counter.
  ///
  /// In de, this message translates to:
  /// **'Theke'**
  String get counter;

  /// No description provided for @teamModeBadge.
  ///
  /// In de, this message translates to:
  /// **'TEAM-MODUS'**
  String get teamModeBadge;

  /// No description provided for @exitTeam.
  ///
  /// In de, this message translates to:
  /// **'Beenden'**
  String get exitTeam;

  /// No description provided for @claimsTab.
  ///
  /// In de, this message translates to:
  /// **'Besuche · {count}'**
  String claimsTab(int count);

  /// No description provided for @voucherCheckTab.
  ///
  /// In de, this message translates to:
  /// **'Gutschein prüfen'**
  String get voucherCheckTab;

  /// No description provided for @highAmount.
  ///
  /// In de, this message translates to:
  /// **'Hoher Betrag – bitte Beleg ansehen'**
  String get highAmount;

  /// No description provided for @voucherCodeLabel.
  ///
  /// In de, this message translates to:
  /// **'Gutschein-Code des Gastes'**
  String get voucherCodeLabel;

  /// No description provided for @voucherValid.
  ///
  /// In de, this message translates to:
  /// **'Gültig'**
  String get voucherValid;

  /// No description provided for @voucherUsedHint.
  ///
  /// In de, this message translates to:
  /// **'Danach ist der Code verbraucht. Rückgängig nur durch Admins.'**
  String get voucherUsedHint;

  /// No description provided for @welcomeHeadline.
  ///
  /// In de, this message translates to:
  /// **'Jeder Besuch schreibt deine Saga.'**
  String get welcomeHeadline;

  /// No description provided for @welcomeBody.
  ///
  /// In de, this message translates to:
  /// **'Scanne Belege, teile Momente aus der Halle und tausche Münzen gegen Merch und exklusive Erlebnisse.'**
  String get welcomeBody;

  /// No description provided for @continueWithEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get continueWithEmail;

  /// No description provided for @adultsOnlyFooter.
  ///
  /// In de, this message translates to:
  /// **'Nur für Gäste ab 18'**
  String get adultsOnlyFooter;

  /// No description provided for @emailSignInTitle.
  ///
  /// In de, this message translates to:
  /// **'Mit E-Mail anmelden'**
  String get emailSignInTitle;

  /// No description provided for @newHereCreate.
  ///
  /// In de, this message translates to:
  /// **'Neu hier? Konto erstellen'**
  String get newHereCreate;

  /// No description provided for @beforeYouEnter.
  ///
  /// In de, this message translates to:
  /// **'Bevor du die Halle betrittst'**
  String get beforeYouEnter;

  /// No description provided for @ageBody.
  ///
  /// In de, this message translates to:
  /// **'Valhalla Hero ist nur für Gäste ab 18 Jahren. Dein Geburtsdatum bleibt privat.'**
  String get ageBody;

  /// No description provided for @ageOk.
  ///
  /// In de, this message translates to:
  /// **'Alles klar – du bist dabei.'**
  String get ageOk;

  /// No description provided for @consentsTitle.
  ///
  /// In de, this message translates to:
  /// **'Einwilligungen'**
  String get consentsTitle;

  /// No description provided for @eventsNewsConsentCaption.
  ///
  /// In de, this message translates to:
  /// **'Push-Nachrichten, wenn in der Halle etwas los ist.'**
  String get eventsNewsConsentCaption;

  /// No description provided for @offersConsentCaption.
  ///
  /// In de, this message translates to:
  /// **'Angebote auf Basis deiner Besuche.'**
  String get offersConsentCaption;

  /// No description provided for @consentsFootnote.
  ///
  /// In de, this message translates to:
  /// **'Beides freiwillig und jederzeit in den Einstellungen änderbar. Bestätigungen zu deinen Besuchen bekommst du immer.'**
  String get consentsFootnote;

  /// No description provided for @stepOf.
  ///
  /// In de, this message translates to:
  /// **'Schritt {step} von {total}'**
  String stepOf(int step, int total);

  /// No description provided for @heroAwakes.
  ///
  /// In de, this message translates to:
  /// **'Dein Held erwacht'**
  String get heroAwakes;

  /// No description provided for @chooseForm.
  ///
  /// In de, this message translates to:
  /// **'Wähle deine Heldenform. Jederzeit änderbar – dein Fortschritt bleibt.'**
  String get chooseForm;

  /// No description provided for @heroNameLabel.
  ///
  /// In de, this message translates to:
  /// **'Name deines Helden'**
  String get heroNameLabel;

  /// No description provided for @heroNameHint.
  ///
  /// In de, this message translates to:
  /// **'Sichtbar in der Ruhmeshalle. Bitte keinen Klarnamen.'**
  String get heroNameHint;

  /// No description provided for @startJourney.
  ///
  /// In de, this message translates to:
  /// **'Heldenreise beginnen'**
  String get startJourney;

  /// No description provided for @eightLevels.
  ///
  /// In de, this message translates to:
  /// **'8 Stufen'**
  String get eightLevels;

  /// No description provided for @appTagline.
  ///
  /// In de, this message translates to:
  /// **'Deine Besuche. Deine Legende.'**
  String get appTagline;

  /// No description provided for @dayMon.
  ///
  /// In de, this message translates to:
  /// **'MO'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In de, this message translates to:
  /// **'DI'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In de, this message translates to:
  /// **'MI'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In de, this message translates to:
  /// **'DO'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In de, this message translates to:
  /// **'FR'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In de, this message translates to:
  /// **'SA'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In de, this message translates to:
  /// **'SO'**
  String get daySun;

  /// No description provided for @comingSoon.
  ///
  /// In de, this message translates to:
  /// **'Bald verfügbar'**
  String get comingSoon;

  /// No description provided for @tabEvents.
  ///
  /// In de, this message translates to:
  /// **'Events'**
  String get tabEvents;

  /// No description provided for @tabSaga.
  ///
  /// In de, this message translates to:
  /// **'Saga'**
  String get tabSaga;

  /// No description provided for @tabScan.
  ///
  /// In de, this message translates to:
  /// **'Hinzufügen'**
  String get tabScan;

  /// No description provided for @tonight.
  ///
  /// In de, this message translates to:
  /// **'Heute Abend'**
  String get tonight;

  /// No description provided for @tomorrow.
  ///
  /// In de, this message translates to:
  /// **'Morgen'**
  String get tomorrow;

  /// No description provided for @liveNow.
  ///
  /// In de, this message translates to:
  /// **'Läuft gerade'**
  String get liveNow;

  /// No description provided for @eventsEmpty.
  ///
  /// In de, this message translates to:
  /// **'Gerade sind keine Events geplant.'**
  String get eventsEmpty;

  /// No description provided for @eventsPast.
  ///
  /// In de, this message translates to:
  /// **'Vergangene Events'**
  String get eventsPast;

  /// No description provided for @catMatch.
  ///
  /// In de, this message translates to:
  /// **'Sport live'**
  String get catMatch;

  /// No description provided for @catLive.
  ///
  /// In de, this message translates to:
  /// **'Live-Musik'**
  String get catLive;

  /// No description provided for @catQuiz.
  ///
  /// In de, this message translates to:
  /// **'Quiz'**
  String get catQuiz;

  /// No description provided for @catParty.
  ///
  /// In de, this message translates to:
  /// **'Party'**
  String get catParty;

  /// No description provided for @catSpecial.
  ///
  /// In de, this message translates to:
  /// **'Special'**
  String get catSpecial;

  /// No description provided for @scanTitle.
  ///
  /// In de, this message translates to:
  /// **'Beleg scannen'**
  String get scanTitle;

  /// No description provided for @scanHint.
  ///
  /// In de, this message translates to:
  /// **'Richte die Kamera auf den QR-Code auf deinem Beleg.'**
  String get scanHint;

  /// No description provided for @scanFromPhotos.
  ///
  /// In de, this message translates to:
  /// **'Aus Fotos'**
  String get scanFromPhotos;

  /// No description provided for @scanEnterCode.
  ///
  /// In de, this message translates to:
  /// **'Code eingeben'**
  String get scanEnterCode;

  /// No description provided for @scanCodeHint.
  ///
  /// In de, this message translates to:
  /// **'Steht unter dem QR-Code auf deinem Beleg.'**
  String get scanCodeHint;

  /// No description provided for @scanNoQr.
  ///
  /// In de, this message translates to:
  /// **'Ohne QR melden'**
  String get scanNoQr;

  /// No description provided for @scanDemo.
  ///
  /// In de, this message translates to:
  /// **'Demo-Beleg'**
  String get scanDemo;

  /// No description provided for @scanChecking.
  ///
  /// In de, this message translates to:
  /// **'Beleg wird geprüft …'**
  String get scanChecking;

  /// No description provided for @torch.
  ///
  /// In de, this message translates to:
  /// **'Licht'**
  String get torch;

  /// No description provided for @scanNoCamera.
  ///
  /// In de, this message translates to:
  /// **'Keine Kamera verfügbar. Wähle ein Foto oder gib den Code ein.'**
  String get scanNoCamera;

  /// No description provided for @scanNothingInImage.
  ///
  /// In de, this message translates to:
  /// **'Kein QR-Code im Bild gefunden.'**
  String get scanNothingInImage;

  /// No description provided for @scanOnce.
  ///
  /// In de, this message translates to:
  /// **'Jeder Beleg zählt einmal – XP gibt es pro Besuch, Münzen nach Betrag.'**
  String get scanOnce;

  /// No description provided for @receiptErrUsed.
  ///
  /// In de, this message translates to:
  /// **'Dieser Beleg wurde schon eingelöst.'**
  String get receiptErrUsed;

  /// No description provided for @receiptErrInvalid.
  ///
  /// In de, this message translates to:
  /// **'Das ist kein gültiger Valhalla-Beleg.'**
  String get receiptErrInvalid;

  /// No description provided for @receiptErrTooOld.
  ///
  /// In de, this message translates to:
  /// **'Dieser Beleg ist zu alt.'**
  String get receiptErrTooOld;

  /// No description provided for @receiptErrUnknownVenue.
  ///
  /// In de, this message translates to:
  /// **'Der Beleg stammt nicht aus einer Valhalla-Bar.'**
  String get receiptErrUnknownVenue;

  /// No description provided for @receiptErrDailyLimit.
  ///
  /// In de, this message translates to:
  /// **'Tageslimit für Belege erreicht. Bis morgen!'**
  String get receiptErrDailyLimit;

  /// No description provided for @receiptAdded.
  ///
  /// In de, this message translates to:
  /// **'Beleg hinzugefügt'**
  String get receiptAdded;

  /// No description provided for @receiptAddedHint.
  ///
  /// In de, this message translates to:
  /// **'XP gibt es einmal pro Besuch – weitere Belege des Tages bringen Münzen.'**
  String get receiptAddedHint;

  /// No description provided for @sagaComposerTitle.
  ///
  /// In de, this message translates to:
  /// **'Teile deinen Moment'**
  String get sagaComposerTitle;

  /// No description provided for @sagaComposerSub.
  ///
  /// In de, this message translates to:
  /// **'Foto aus der Halle oder mit Valhalla-Merch · +{xp} XP · +{coins} Münzen'**
  String sagaComposerSub(int xp, int coins);

  /// No description provided for @checkinNewTitle.
  ///
  /// In de, this message translates to:
  /// **'Foto teilen'**
  String get checkinNewTitle;

  /// No description provided for @takePhoto.
  ///
  /// In de, this message translates to:
  /// **'Kamera'**
  String get takePhoto;

  /// No description provided for @pickPhoto.
  ///
  /// In de, this message translates to:
  /// **'Mediathek'**
  String get pickPhoto;

  /// No description provided for @captionHint.
  ///
  /// In de, this message translates to:
  /// **'Was ist los in der Halle?'**
  String get captionHint;

  /// No description provided for @tagEvent.
  ///
  /// In de, this message translates to:
  /// **'Zu einem Event'**
  String get tagEvent;

  /// No description provided for @noEvent.
  ///
  /// In de, this message translates to:
  /// **'Kein Event'**
  String get noEvent;

  /// No description provided for @checkinRules.
  ///
  /// In de, this message translates to:
  /// **'Nur Fotos aus der Halle oder mit Valhalla-Merch. Das Team prüft jedes Foto – danach erscheint es in der Saga.'**
  String get checkinRules;

  /// No description provided for @checkinReward.
  ///
  /// In de, this message translates to:
  /// **'+{xp} XP · +{coins} Münzen nach Freigabe (einmal pro Tag)'**
  String checkinReward(int xp, int coins);

  /// No description provided for @checkinSubmit.
  ///
  /// In de, this message translates to:
  /// **'Zur Prüfung senden'**
  String get checkinSubmit;

  /// No description provided for @checkinPendingTitle.
  ///
  /// In de, this message translates to:
  /// **'Dein Foto wird geprüft'**
  String get checkinPendingTitle;

  /// No description provided for @checkinPendingBody.
  ///
  /// In de, this message translates to:
  /// **'Sobald das Team es freigibt, erscheint es in der Saga. Bis dahin kannst du kein weiteres Foto senden.'**
  String get checkinPendingBody;

  /// No description provided for @checkinWithdraw.
  ///
  /// In de, this message translates to:
  /// **'Zurückziehen'**
  String get checkinWithdraw;

  /// No description provided for @checkinRejectedTitle.
  ///
  /// In de, this message translates to:
  /// **'Foto nicht freigegeben'**
  String get checkinRejectedTitle;

  /// No description provided for @checkinErrPending.
  ///
  /// In de, this message translates to:
  /// **'Du hast schon ein Foto in Prüfung.'**
  String get checkinErrPending;

  /// No description provided for @sagaEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Fotos. Mach den Anfang!'**
  String get sagaEmpty;

  /// No description provided for @justNow.
  ///
  /// In de, this message translates to:
  /// **'gerade eben'**
  String get justNow;

  /// No description provided for @agoMinutes.
  ///
  /// In de, this message translates to:
  /// **'vor {minutes} Min.'**
  String agoMinutes(int minutes);

  /// No description provided for @agoHours.
  ///
  /// In de, this message translates to:
  /// **'vor {hours} Std.'**
  String agoHours(int hours);

  /// No description provided for @photosInSaga.
  ///
  /// In de, this message translates to:
  /// **'Fotos in der Saga'**
  String get photosInSaga;

  /// No description provided for @teamPhotosTab.
  ///
  /// In de, this message translates to:
  /// **'Fotos · {count}'**
  String teamPhotosTab(int count);

  /// No description provided for @teamPhotosEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Fotos zu prüfen.'**
  String get teamPhotosEmpty;

  /// No description provided for @approvePhoto.
  ///
  /// In de, this message translates to:
  /// **'Freigeben'**
  String get approvePhoto;

  /// No description provided for @helpFeedback.
  ///
  /// In de, this message translates to:
  /// **'Hilfe & Feedback'**
  String get helpFeedback;

  /// No description provided for @reportBug.
  ///
  /// In de, this message translates to:
  /// **'Fehler melden'**
  String get reportBug;

  /// No description provided for @reportBugCaption.
  ///
  /// In de, this message translates to:
  /// **'Etwas funktioniert nicht? Sag uns Bescheid.'**
  String get reportBugCaption;

  /// No description provided for @bugDescribe.
  ///
  /// In de, this message translates to:
  /// **'Was ist passiert?'**
  String get bugDescribe;

  /// No description provided for @bugHint.
  ///
  /// In de, this message translates to:
  /// **'Beschreibe kurz, was du gemacht hast und was schiefging.'**
  String get bugHint;

  /// No description provided for @bugIncludeInfo.
  ///
  /// In de, this message translates to:
  /// **'App- und Geräteinfos mitsenden'**
  String get bugIncludeInfo;

  /// No description provided for @bugSend.
  ///
  /// In de, this message translates to:
  /// **'Senden'**
  String get bugSend;

  /// No description provided for @bugThanks.
  ///
  /// In de, this message translates to:
  /// **'Danke! Wir kümmern uns darum.'**
  String get bugThanks;

  /// No description provided for @chooseLanguage.
  ///
  /// In de, this message translates to:
  /// **'Sprache wählen'**
  String get chooseLanguage;

  /// No description provided for @whoLikes.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =0{Noch keine Likes} =1{1 Like} other{{count} Likes}}'**
  String whoLikes(int count);
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'nl',
    'pl',
    'ru',
    'tr',
    'uk',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return L10nDe();
    case 'en':
      return L10nEn();
    case 'es':
      return L10nEs();
    case 'fr':
      return L10nFr();
    case 'it':
      return L10nIt();
    case 'nl':
      return L10nNl();
    case 'pl':
      return L10nPl();
    case 'ru':
      return L10nRu();
    case 'tr':
      return L10nTr();
    case 'uk':
      return L10nUk();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
