// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Loot';

  @override
  String get signIn => 'Sign in';

  @override
  String get signUp => 'Sign up';

  @override
  String get signOut => 'Sign out';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get nickname => 'Nickname';

  @override
  String get birthDate => 'Date of birth';

  @override
  String get ageGateError => 'You must be at least 18 years old.';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get termsAccept =>
      'I accept the terms of participation and have read the privacy policy.';

  @override
  String get createAccount => 'Create account';

  @override
  String get completeProfile => 'Complete profile';

  @override
  String authError(String message) {
    return 'Sign-in failed: $message';
  }

  @override
  String xpLabel(int xp) {
    return '$xp XP';
  }

  @override
  String get onBoard => 'On board';

  @override
  String visitsCount(int count) {
    return '$count visits';
  }

  @override
  String get claimVisit => 'Report visit';

  @override
  String get claimVisitTitle => 'Report a visit';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Bill amount (€)';

  @override
  String get claimNote => 'Note (optional)';

  @override
  String get claimTooManyPending => 'You have too many pending reports.';

  @override
  String get claimStatusApproved => 'Confirmed';

  @override
  String get claimStatusRejected => 'Rejected';

  @override
  String get myClaims => 'My reports';

  @override
  String get achievements => 'Achievements';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return '$unlocked of $total unlocked';
  }

  @override
  String get locked => 'Locked';

  @override
  String get rewards => 'Rewards';

  @override
  String get gear => 'Gear';

  @override
  String get myVouchers => 'My vouchers';

  @override
  String get redeemed => 'Redeemed! Show this code at the bar.';

  @override
  String get insufficientCoins => 'Not enough coins.';

  @override
  String get outOfStock => 'Sold out';

  @override
  String stockLeft(int count) {
    return '$count left';
  }

  @override
  String validUntil(String date) {
    return 'Valid until $date';
  }

  @override
  String get voucherActive => 'Active';

  @override
  String get voucherRedeemed => 'Redeemed';

  @override
  String get voucherExpired => 'Expired';

  @override
  String get voucherCancelled => 'Cancelled';

  @override
  String get rewardTypeMerch => 'Merch';

  @override
  String get rewardTypeDrink => 'Drink';

  @override
  String get rewardTypeDiscount => 'Discount';

  @override
  String get rewardTypePriorityBooking => 'Booking';

  @override
  String get rewardTypeEventAccess => 'Event';

  @override
  String get owned => 'Owned';

  @override
  String get equip => 'Equip';

  @override
  String get equipped => 'Equipped';

  @override
  String get unequip => 'Unequip';

  @override
  String get purchaseDone => 'Purchased. You can equip it now.';

  @override
  String unlockAtLevel(int level) {
    return 'From level $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Achievement: $name';
  }

  @override
  String get unlockByEvent => 'Events only';

  @override
  String get slotHeadgear => 'Head';

  @override
  String get slotHandItem => 'Hand';

  @override
  String get slotCape => 'Cape';

  @override
  String get slotCompanion => 'Companion';

  @override
  String get slotFrame => 'Frame';

  @override
  String get rarityCommon => 'Common';

  @override
  String get rarityRare => 'Rare';

  @override
  String get rarityLegendary => 'Legendary';

  @override
  String get leaderboardTitle => 'Ranking';

  @override
  String get leaderboardYou => 'You';

  @override
  String get leaderboardHidden => 'You are hidden from the ranking.';

  @override
  String get postTypeNews => 'News';

  @override
  String get postTypeEvent => 'Event';

  @override
  String get notifications => 'Messages';

  @override
  String get notificationsEmpty => 'No messages.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get leaderboardVisible => 'Visible on the leaderboard';

  @override
  String get privacy => 'Privacy';

  @override
  String get exportData => 'Export my data';

  @override
  String get exportDataDone => 'Export created.';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountTitle => 'Really delete your account?';

  @override
  String deleteAccountBody(int coins) {
    return 'All data, XP and $coins coins will be deleted permanently.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get save => 'Save';

  @override
  String get close => 'Close';

  @override
  String get gotIt => 'Got it';

  @override
  String get retry => 'Retry';

  @override
  String get staffClaimsEmpty => 'No pending reports.';

  @override
  String get staffApprove => 'Approve';

  @override
  String get staffReject => 'Reject';

  @override
  String get staffRejectReason => 'Reason (optional)';

  @override
  String get staffVoucherConfirm => 'Mark as redeemed';

  @override
  String get staffVoucherNotFound => 'No voucher with this code.';

  @override
  String get staffVoucherDone => 'Voucher redeemed.';

  @override
  String get staffCredit => 'Credit visit manually';

  @override
  String get adminDashboard => 'Dashboard';

  @override
  String get adminUsers => 'Guests';

  @override
  String get adminClaims => 'Reports';

  @override
  String get adminRewards => 'Rewards';

  @override
  String get adminItems => 'Gear';

  @override
  String get adminPosts => 'Saga';

  @override
  String get adminVenues => 'Bars';

  @override
  String get adminEconomy => 'Economy';

  @override
  String get adminStatUsers => 'Guests';

  @override
  String get adminStatOnBoard => 'On board';

  @override
  String get adminStatVisits30 => 'Visits (30 days)';

  @override
  String get adminStatRevenue30 => 'Revenue (30 days)';

  @override
  String get adminStatPending => 'Pending reports';

  @override
  String get adminStatCoins => 'Coins outstanding';

  @override
  String get adminStatVouchersActive => 'Active vouchers';

  @override
  String get adminStatVouchersRedeemed30 => 'Redeemed (30 days)';

  @override
  String get adminNewPost => 'New post';

  @override
  String get adminPublish => 'Publish';

  @override
  String get adminDraft => 'Draft';

  @override
  String get adminTitle => 'Title';

  @override
  String get adminBody => 'Body';

  @override
  String get adminImageUrl => 'Image URL';

  @override
  String get adminStartsAt => 'Starts at';

  @override
  String get adminEndsAt => 'Ends (optional)';

  @override
  String get adminCategory => 'Category';

  @override
  String get adminPrice => 'Price (coins)';

  @override
  String get adminStock => 'Stock (empty = unlimited)';

  @override
  String get adminValidityDays => 'Validity (days)';

  @override
  String get adminActive => 'Active';

  @override
  String get adminRole => 'Role';

  @override
  String get adminSearch => 'Search';

  @override
  String get adminEconomyXpPerVisit => 'XP per visit';

  @override
  String get adminEconomyCoinsPerEuro => 'Coins per euro';

  @override
  String get adminEconomyDailyCap => 'Daily coin cap';

  @override
  String get adminEconomyExpiryMonths => 'Expiry (months)';

  @override
  String get adminEconomyOnboardDays => 'On board (days)';

  @override
  String get adminEconomyStreakBonus => 'Streak bonus XP';

  @override
  String get adminLevels => 'Levels';

  @override
  String get adminLevelThreshold => 'XP threshold';

  @override
  String get adminLevelMultiplier => 'Coin multiplier';

  @override
  String get adminSaved => 'Saved.';

  @override
  String get adminNotAllowed => 'Administrators only.';

  @override
  String get coinReasonVisit => 'Visit';

  @override
  String get coinReasonAchievement => 'Achievement';

  @override
  String get coinReasonManual => 'Team credit';

  @override
  String get coinReasonReward => 'Reward';

  @override
  String get coinReasonItem => 'Gear';

  @override
  String get coinReasonExpiry => 'Expiry';

  @override
  String get coinReasonRefund => 'Refund';

  @override
  String get tabHero => 'Hero';

  @override
  String get heroPath => 'Hero path';

  @override
  String get statStreak => 'Streak';

  @override
  String get statOnBoard => 'On board';

  @override
  String get statVisits => 'Visits';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks weeks',
      one: '1 week',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'This week';

  @override
  String get all => 'All';

  @override
  String get claimSheetSub => 'The team at the bar confirms your visit.';

  @override
  String get claimWhere => 'Where are you?';

  @override
  String get change => 'Change';

  @override
  String get claimAmountLabel => 'Bill amount';

  @override
  String get claimAmountHint =>
      'Only sets your coins. XP is per visit – never per euro.';

  @override
  String get claimNoteLabel => 'Note for the team (optional)';

  @override
  String get claimNoteHint => 'e.g. table 7';

  @override
  String get claimPreview => 'After confirmation you get';

  @override
  String streakBonus(int xp) {
    return '+$xp streak bonus';
  }

  @override
  String get claimSentTitle => 'Visit reported';

  @override
  String get claimSentBody =>
      'Show the team this code – that’s the fastest way.';

  @override
  String get yourVisitCode => 'Your visit code';

  @override
  String get stepReported => 'Reported';

  @override
  String get stepChecking => 'Being checked';

  @override
  String get stepCheckingSub => 'Usually under 5 minutes';

  @override
  String get stepCredited => 'Credited';

  @override
  String get stepCreditedSub => 'XP, streak bonus and coins';

  @override
  String get hornWillCall => 'We’ll sound the horn when it’s done.';

  @override
  String get toHall => 'Back to the hall';

  @override
  String get claimRejectedTitle => 'Visit rejected';

  @override
  String get claimRejectedBody => 'Have a quick word with the team at the bar.';

  @override
  String get visitConfirmed => 'Visit confirmed';

  @override
  String hallHonours(String name) {
    return 'The hall honours you, $name';
  }

  @override
  String get experience => 'Experience';

  @override
  String get coinsWord => 'Coins';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks weeks on board!',
      one: '1 week on board',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Streak kept – keep it up.';

  @override
  String get achievementUnlocked => 'Achievement unlocked';

  @override
  String get continueLabel => 'Continue';

  @override
  String levelReached(String level) {
    return 'Level $level reached!';
  }

  @override
  String coinBonus(String mult) {
    return 'Coin bonus ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Before ×$mult – on every visit';
  }

  @override
  String get newGear => 'New in your gear';

  @override
  String get newBackdrop => 'New backdrop';

  @override
  String equipItem(String item) {
    return 'Equip $item';
  }

  @override
  String get later => 'Later';

  @override
  String get shareLevel => 'Share level-up';

  @override
  String shareLevelText(String level) {
    return 'I just became $level in Valhalla Hero!';
  }

  @override
  String ownedOf(int owned, int total) {
    return '$owned of $total owned';
  }

  @override
  String get cosmeticOnly => 'Cosmetic only – no gameplay effect';

  @override
  String get heroForm => 'Hero form';

  @override
  String get heroFormHero => 'Hero';

  @override
  String get heroFormHeroine => 'Heroine';

  @override
  String get heroFormHint => 'Hero or heroine – your progress stays';

  @override
  String levelOfEight(String roman) {
    return 'Level $roman of VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp of $max XP to Valhalla';
  }

  @override
  String get yourLevel => 'Your level';

  @override
  String get nextUp => 'Next up';

  @override
  String fromXp(String xp) {
    return 'from $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return '$xp XP to go';
  }

  @override
  String get reached => 'Unlocked';

  @override
  String almostThere(String name) {
    return 'Almost there: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Best $weeks';
  }

  @override
  String get rewardsRedeemed => 'Rewards redeemed';

  @override
  String get itemsOwned => 'Gear owned';

  @override
  String get yourBalance => 'Your balance';

  @override
  String get coinPurse => 'Coin purse';

  @override
  String coinsExpireSoon(int coins, String date) {
    return '$coins coins expire on $date';
  }

  @override
  String get redeemBeforeExpiry => 'Spend them in the shop before then.';

  @override
  String get segVouchers => 'Vouchers';

  @override
  String get allRewards => 'All rewards';

  @override
  String missingCoins(String coins) {
    return 'You need $coins more';
  }

  @override
  String get holdToRedeem => 'Hold to redeem';

  @override
  String get holdHint =>
      'No accidental spending – confirmed only after holding.';

  @override
  String get priceLabel => 'Price';

  @override
  String get balanceAfter => 'Balance after';

  @override
  String get validLabel => 'Valid';

  @override
  String validDays(int days) {
    return '$days days from redemption';
  }

  @override
  String get redeemHow => 'How to redeem';

  @override
  String get showCodeAtBar => 'Show code at the bar';

  @override
  String get noVouchers => 'No vouchers yet. Trade coins for loot.';

  @override
  String get showThisCode => 'Show this code at the bar';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days left',
      one: '1 day left',
    );
    return 'Valid until $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Redeemed on $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Redeemed on $date · $coins coins';
  }

  @override
  String get stepShowCode => 'Show code';

  @override
  String get stepTeamConfirms => 'Team confirms';

  @override
  String get stepEnjoy => 'Enjoy';

  @override
  String get voucherLiveNote =>
      'The status updates live as soon as the team confirms.';

  @override
  String expiryInfo(int months) {
    return 'Coins expire after $months months';
  }

  @override
  String get xpNeverExpires => 'XP never expires';

  @override
  String get coinsNoCash =>
      'Coins are a voluntary loyalty perk without cash value and are never paid out.';

  @override
  String get toShop => 'To the shop';

  @override
  String get fameTitle => 'Hall of Fame';

  @override
  String get allHeroes => 'All heroes';

  @override
  String get rankHeader => 'RANK · HERO';

  @override
  String get yourPosition => 'Your position';

  @override
  String xpToRank(String xp, int rank) {
    return '$xp XP to rank $rank';
  }

  @override
  String get alleyTitle => 'Avenue of the Immortals';

  @override
  String get alleyBody =>
      'Reach level VIII – as Einherjar or Valkyrja – and you get a statue here forever.';

  @override
  String get alleyFree => 'Still free';

  @override
  String rankInFame(int rank) {
    return 'Rank $rank in the Hall of Fame';
  }

  @override
  String get reportName => 'Report hero name';

  @override
  String get reportThanks => 'Thanks – we’ll take a look.';

  @override
  String get share => 'Share';

  @override
  String get directions => 'Directions';

  @override
  String get eventsNews => 'Events & news';

  @override
  String get optionalRevocable => 'Optional · revocable any time';

  @override
  String get personalOffers => 'Personal offers';

  @override
  String get personalOffersCaption => 'Optional · based on your visits';

  @override
  String get serviceNotifications => 'Visits & rewards';

  @override
  String get serviceNotificationsCaption =>
      'Confirmations, level-ups, expiring coins';

  @override
  String get alwaysOn => 'Always on';

  @override
  String get showInFame => 'Show in the Hall of Fame';

  @override
  String get showInFameCaption =>
      'Only hero name and hero – never your real name';

  @override
  String get account => 'Account';

  @override
  String get heroName => 'Hero name';

  @override
  String get editHeroName => 'Change hero name';

  @override
  String get teamGroup => 'Team';

  @override
  String get teamMode => 'Open team mode';

  @override
  String get teamModeCaption => 'Confirm visits, review photos, check vouchers';

  @override
  String get legal => 'Legal';

  @override
  String get terms => 'Terms of participation';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get imprint => 'Imprint';

  @override
  String get myData => 'My data';

  @override
  String get exportCaption => 'JSON file with all your data';

  @override
  String get deleteCaption => 'Your coins and vouchers will be lost.';

  @override
  String get hornCalls => 'Horn calls';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get today => 'Today';

  @override
  String get earlier => 'Earlier';

  @override
  String get counter => 'Counter';

  @override
  String get teamModeBadge => 'TEAM MODE';

  @override
  String get exitTeam => 'Exit';

  @override
  String claimsTab(int count) {
    return 'Visits · $count';
  }

  @override
  String get voucherCheckTab => 'Check voucher';

  @override
  String get highAmount => 'High amount – please check the receipt';

  @override
  String get voucherCodeLabel => 'Guest voucher code';

  @override
  String get voucherValid => 'Valid';

  @override
  String get voucherUsedHint =>
      'The code is used up afterwards. Only admins can undo it.';

  @override
  String get welcomeHeadline => 'Every visit writes your saga.';

  @override
  String get welcomeBody =>
      'Scan receipts, share moments from the hall and trade coins for merch and exclusive perks.';

  @override
  String get continueWithEmail => 'Email';

  @override
  String get adultsOnlyFooter => 'Guests aged 18+ only';

  @override
  String get emailSignInTitle => 'Sign in with email';

  @override
  String get newHereCreate => 'New here? Create account';

  @override
  String get beforeYouEnter => 'Before you enter the hall';

  @override
  String get ageBody =>
      'Valhalla Hero is for guests aged 18+ only. Your date of birth stays private.';

  @override
  String get ageOk => 'All set – you’re in.';

  @override
  String get consentsTitle => 'Consents';

  @override
  String get eventsNewsConsentCaption =>
      'Push messages when something is on in the hall.';

  @override
  String get offersConsentCaption => 'Offers based on your visits.';

  @override
  String get consentsFootnote =>
      'Both optional and changeable any time in settings. You always get confirmations about your visits.';

  @override
  String stepOf(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get heroAwakes => 'Your hero awakens';

  @override
  String get chooseForm =>
      'Choose your hero form. Change it any time – your progress stays.';

  @override
  String get heroNameLabel => 'Your hero’s name';

  @override
  String get heroNameHint => 'Shown in the Hall of Fame. Please no real names.';

  @override
  String get startJourney => 'Begin the journey';

  @override
  String get eightLevels => '8 levels';

  @override
  String get appTagline => 'Your visits. Your legend.';

  @override
  String get dayMon => 'MON';

  @override
  String get dayTue => 'TUE';

  @override
  String get dayWed => 'WED';

  @override
  String get dayThu => 'THU';

  @override
  String get dayFri => 'FRI';

  @override
  String get daySat => 'SAT';

  @override
  String get daySun => 'SUN';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get tabEvents => 'Events';

  @override
  String get tabSaga => 'Saga';

  @override
  String get tabScan => 'Scan';

  @override
  String get tonight => 'Tonight';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get liveNow => 'On now';

  @override
  String get eventsEmpty => 'No events planned right now.';

  @override
  String get catMatch => 'Live sports';

  @override
  String get catLive => 'Live music';

  @override
  String get catQuiz => 'Quiz';

  @override
  String get catParty => 'Party';

  @override
  String get catSpecial => 'Special';

  @override
  String get scanTitle => 'Scan receipt';

  @override
  String get scanHint => 'Point the camera at the QR code on your receipt.';

  @override
  String get scanFromPhotos => 'From photos';

  @override
  String get scanEnterCode => 'Enter code';

  @override
  String get scanCodeHint => 'Printed below the QR code on your receipt.';

  @override
  String get scanNoQr => 'Report without QR';

  @override
  String get scanDemo => 'Demo receipt';

  @override
  String get scanChecking => 'Checking receipt …';

  @override
  String get torch => 'Light';

  @override
  String get scanNoCamera =>
      'No camera available. Pick a photo or enter the code.';

  @override
  String get scanNothingInImage => 'No QR code found in the image.';

  @override
  String get scanOnce =>
      'Each receipt counts once – XP per visit, coins by amount.';

  @override
  String get receiptErrUsed => 'This receipt has already been redeemed.';

  @override
  String get receiptErrInvalid => 'This is not a valid Valhalla receipt.';

  @override
  String get receiptErrTooOld => 'This receipt is too old.';

  @override
  String get receiptErrUnknownVenue =>
      'This receipt is not from a Valhalla bar.';

  @override
  String get receiptErrDailyLimit =>
      'You already redeemed a receipt here today. See you tomorrow!';

  @override
  String get sagaComposerTitle => 'Share your moment';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Photo from the hall or with Valhalla merch · +$xp XP · +$coins coins';
  }

  @override
  String get checkinNewTitle => 'Share photo';

  @override
  String get takePhoto => 'Camera';

  @override
  String get pickPhoto => 'Library';

  @override
  String get captionHint => 'What is happening in the hall?';

  @override
  String get tagEvent => 'Tag an event';

  @override
  String get noEvent => 'No event';

  @override
  String get checkinRules =>
      'Only photos from the hall or with Valhalla merch. The team reviews every photo before it appears in the saga.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · +$coins coins after approval (once per day)';
  }

  @override
  String get checkinSubmit => 'Send for review';

  @override
  String get checkinPendingTitle => 'Your photo is being reviewed';

  @override
  String get checkinPendingBody =>
      'As soon as the team approves it, it appears in the saga. Until then you cannot send another photo.';

  @override
  String get checkinWithdraw => 'Withdraw';

  @override
  String get checkinRejectedTitle => 'Photo not approved';

  @override
  String get checkinErrPending => 'You already have a photo under review.';

  @override
  String get sagaEmpty => 'No photos yet. Be the first!';

  @override
  String get justNow => 'just now';

  @override
  String agoMinutes(int minutes) {
    return '$minutes min ago';
  }

  @override
  String agoHours(int hours) {
    return '$hours h ago';
  }

  @override
  String get photosInSaga => 'Photos in the saga';

  @override
  String teamPhotosTab(int count) {
    return 'Photos · $count';
  }

  @override
  String get teamPhotosEmpty => 'No photos to review.';

  @override
  String get approvePhoto => 'Approve';

  @override
  String get helpFeedback => 'Help & feedback';

  @override
  String get reportBug => 'Report a bug';

  @override
  String get reportBugCaption => 'Something not working? Let us know.';

  @override
  String get bugDescribe => 'What happened?';

  @override
  String get bugHint => 'Briefly describe what you did and what went wrong.';

  @override
  String get bugIncludeInfo => 'Include app and device info';

  @override
  String get bugSend => 'Send';

  @override
  String get bugThanks => 'Thanks! We are on it.';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count likes',
      one: '1 like',
      zero: 'No likes yet',
    );
    return '$_temp0';
  }
}
