// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Ganimet';

  @override
  String get signIn => 'Giriş yap';

  @override
  String get signUp => 'Kaydol';

  @override
  String get signOut => 'Çıkış yap';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get nickname => 'Takma ad';

  @override
  String get birthDate => 'Doğum tarihi';

  @override
  String get ageGateError => 'En az 18 yaşında olmalısın.';

  @override
  String get continueWithApple => 'Apple ile devam et';

  @override
  String get alreadyHaveAccount => 'Zaten hesabın var mı?';

  @override
  String get termsAccept =>
      'Katılım koşullarını kabul ediyorum ve gizlilik politikasını okudum.';

  @override
  String get createAccount => 'Hesap oluştur';

  @override
  String get completeProfile => 'Profili tamamla';

  @override
  String authError(String message) {
    return 'Giriş başarısız: $message';
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
  String get onBoard => 'Gemide';

  @override
  String visitsCount(int count) {
    return '$count ziyaret';
  }

  @override
  String get claimVisit => 'Ziyaret bildir';

  @override
  String get claimVisitTitle => 'Ziyaret bildir';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Bekleyen çok fazla bildirimin var.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Bildirimlerim';

  @override
  String get achievements => 'Başarımlar';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return '$total içinden $unlocked açıldı';
  }

  @override
  String get locked => 'Kilitli';

  @override
  String get rewards => 'Ödüller';

  @override
  String get gear => 'Teçhizat';

  @override
  String get myVouchers => 'Kuponlarım';

  @override
  String get redeemed => 'Kullanıldı! Bu kodu barda göster.';

  @override
  String get insufficientCoins => 'Yeterli sikke yok.';

  @override
  String get outOfStock => 'Tükendi';

  @override
  String stockLeft(int count) {
    return '$count kaldı';
  }

  @override
  String validUntil(String date) {
    return '$date tarihine kadar geçerli';
  }

  @override
  String get voucherActive => 'Aktif';

  @override
  String get voucherRedeemed => 'Kullanıldı';

  @override
  String get voucherExpired => 'Süresi doldu';

  @override
  String get voucherCancelled => 'İptal edildi';

  @override
  String get rewardTypeMerch => 'Merch';

  @override
  String get rewardTypeDrink => 'İçecek';

  @override
  String get rewardTypeDiscount => 'İndirim';

  @override
  String get rewardTypePriorityBooking => 'Rezervasyon';

  @override
  String get rewardTypeEventAccess => 'Etkinlik';

  @override
  String get owned => 'Sende';

  @override
  String get equip => 'Kuşan';

  @override
  String get equipped => 'Kuşanıldı';

  @override
  String get unequip => 'Çıkar';

  @override
  String get purchaseDone => 'Satın alındı. Şimdi kuşanabilirsin.';

  @override
  String unlockAtLevel(int level) {
    return 'Seviye $level itibarıyla';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Başarım: $name';
  }

  @override
  String get unlockByEvent => 'Sadece etkinliklerde';

  @override
  String get slotHeadgear => 'Baş';

  @override
  String get slotHandItem => 'El';

  @override
  String get slotCape => 'Pelerin';

  @override
  String get slotCompanion => 'Yoldaş';

  @override
  String get slotFrame => 'Çerçeve';

  @override
  String get rarityCommon => 'Sıradan';

  @override
  String get rarityRare => 'Nadir';

  @override
  String get rarityLegendary => 'Efsanevi';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Sen';

  @override
  String get leaderboardHidden => 'Sıralamada gizlisin.';

  @override
  String get postTypeNews => 'Haberler';

  @override
  String get postTypeEvent => 'Etkinlik';

  @override
  String get notifications => 'Mesajlar';

  @override
  String get notificationsEmpty => 'Mesaj yok.';

  @override
  String get settings => 'Ayarlar';

  @override
  String get language => 'Dil';

  @override
  String get leaderboardVisible => 'Sıralamada görünür';

  @override
  String get privacy => 'Gizlilik';

  @override
  String get exportData => 'Verilerimi dışa aktar';

  @override
  String get exportDataDone => 'Dışa aktarma oluşturuldu.';

  @override
  String get deleteAccount => 'Hesabı sil';

  @override
  String get deleteAccountTitle => 'Hesabın gerçekten silinsin mi?';

  @override
  String deleteAccountBody(int coins) {
    return 'Tüm veriler, XP ve $coins sikke kalıcı olarak silinecek.';
  }

  @override
  String get delete => 'Sil';

  @override
  String get cancel => 'İptal';

  @override
  String get confirm => 'Onayla';

  @override
  String get save => 'Kaydet';

  @override
  String get close => 'Kapat';

  @override
  String get gotIt => 'Anladım';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get staffClaimsEmpty => 'Bekleyen bildirim yok.';

  @override
  String get staffApprove => 'Onayla';

  @override
  String get staffReject => 'Reddet';

  @override
  String get staffRejectReason => 'Neden (isteğe bağlı)';

  @override
  String get staffVoucherConfirm => 'Kullanıldı olarak işaretle';

  @override
  String get staffVoucherNotFound => 'Bu koda ait kupon yok.';

  @override
  String get staffVoucherDone => 'Kupon kullanıldı.';

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
  String get coinReasonVisit => 'Ziyaret';

  @override
  String get coinReasonAchievement => 'Başarım';

  @override
  String get coinReasonManual => 'Ekip tarafından';

  @override
  String get coinReasonReward => 'Ödül';

  @override
  String get coinReasonItem => 'Teçhizat';

  @override
  String get coinReasonExpiry => 'Süre dolumu';

  @override
  String get coinReasonRefund => 'İade';

  @override
  String get tabHero => 'Kahraman';

  @override
  String get heroPath => 'Kahramanın yolu';

  @override
  String get statStreak => 'Seri';

  @override
  String get statOnBoard => 'Gemide';

  @override
  String get statVisits => 'Ziyaretler';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks hafta',
      one: '1 hafta',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days gün',
      one: '1 gün',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'Bu hafta';

  @override
  String get all => 'Tümü';

  @override
  String get claimSheetSub => 'Bardaki ekip ziyaretini onaylar.';

  @override
  String get claimWhere => 'Neredesin?';

  @override
  String get change => 'Değiştir';

  @override
  String get claimAmountLabel => 'Hesap tutarı';

  @override
  String get claimAmountHint =>
      'Sadece sikkeleri belirler. XP ziyaret başınadır – asla euro başına değil.';

  @override
  String get claimNoteLabel => 'Ekip için not (isteğe bağlı)';

  @override
  String get claimNoteHint => 'örn. masa 7';

  @override
  String get claimPreview => 'Onaydan sonra alacakların';

  @override
  String streakBonus(int xp) {
    return '+$xp seri bonusu';
  }

  @override
  String get claimSentTitle => 'Ziyaret bildirildi';

  @override
  String get claimSentBody => 'Bu kodu ekibe göster – en hızlı yol bu.';

  @override
  String get yourVisitCode => 'Ziyaret kodun';

  @override
  String get stepReported => 'Bildirildi';

  @override
  String get stepChecking => 'Kontrol ediliyor';

  @override
  String get stepCheckingSub => 'Genellikle 5 dakikadan kısa';

  @override
  String get stepCredited => 'Eklendi';

  @override
  String get stepCreditedSub => 'XP, seri bonusu ve sikkeler';

  @override
  String get hornWillCall => 'Hazır olunca boruyu öttüreceğiz.';

  @override
  String get toHall => 'Salona dön';

  @override
  String get claimRejectedTitle => 'Ziyaret reddedildi';

  @override
  String get claimRejectedBody => 'Bardaki ekiple kısaca konuş.';

  @override
  String get visitConfirmed => 'Ziyaret onaylandı';

  @override
  String hallHonours(String name) {
    return 'Salon seni onurlandırıyor, $name';
  }

  @override
  String get experience => 'Deneyim';

  @override
  String get coinsWord => 'Sikkeler';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks haftadır gemide!',
      one: '1 haftadır gemide',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Seri devam ediyor – böyle devam.';

  @override
  String get achievementUnlocked => 'Başarım açıldı';

  @override
  String get continueLabel => 'Devam';

  @override
  String levelReached(String level) {
    return 'Seviye $level ulaşıldı!';
  }

  @override
  String coinBonus(String mult) {
    return 'Sikke bonusu ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Önce ×$mult – her ziyarette';
  }

  @override
  String get newGear => 'Teçhizatında yeni';

  @override
  String get newBackdrop => 'Yeni arka plan';

  @override
  String equipItem(String item) {
    return '$item kuşan';
  }

  @override
  String get later => 'Sonra';

  @override
  String get shareLevel => 'Seviyeyi paylaş';

  @override
  String shareLevelText(String level) {
    return 'Valhalla Hero’da $level oldum!';
  }

  @override
  String ownedOf(int owned, int total) {
    return '$total içinden $owned sende';
  }

  @override
  String get cosmeticOnly => 'Sadece görünüm – oyuna etkisi yok';

  @override
  String get heroForm => 'Kahraman görünümü';

  @override
  String get heroFormHero => 'Erkek kahraman';

  @override
  String get heroFormHeroine => 'Kadın kahraman';

  @override
  String get heroFormHint => 'Erkek ya da kadın kahraman – ilerlemen korunur';

  @override
  String levelOfEight(String roman) {
    return 'Seviye $roman / VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return 'Valhalla’ya $xp / $max XP';
  }

  @override
  String get yourLevel => 'Seviyen';

  @override
  String get nextUp => 'Sıradaki';

  @override
  String fromXp(String xp) {
    return '$xp XP’den itibaren';
  }

  @override
  String xpLeft(String xp) {
    return '$xp XP kaldı';
  }

  @override
  String get reached => 'Açıldı';

  @override
  String almostThere(String name) {
    return 'Neredeyse: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Rekor $weeks';
  }

  @override
  String get rewardsRedeemed => 'Alınan ödüller';

  @override
  String get itemsOwned => 'Sahip olunan teçhizat';

  @override
  String get yourBalance => 'Bakiyen';

  @override
  String get coinPurse => 'Sikke kesesi';

  @override
  String coinsExpireSoon(int coins, String date) {
    return '$coins sikkenin süresi $date tarihinde doluyor';
  }

  @override
  String get redeemBeforeExpiry => 'Ondan önce mağazada harca.';

  @override
  String get segVouchers => 'Kuponlar';

  @override
  String get allRewards => 'Tüm ödüller';

  @override
  String missingCoins(String coins) {
    return '$coins daha gerekiyor';
  }

  @override
  String get holdToRedeem => 'Kullanmak için basılı tut';

  @override
  String get holdHint =>
      'Yanlışlıkla harcama yok – ancak basılı tutunca onaylanır.';

  @override
  String get priceLabel => 'Fiyat';

  @override
  String get balanceAfter => 'Sonraki bakiye';

  @override
  String get validLabel => 'Geçerlilik';

  @override
  String validDays(int days) {
    return 'Kullanımdan itibaren $days gün';
  }

  @override
  String get redeemHow => 'Nasıl kullanılır';

  @override
  String get showCodeAtBar => 'Kodu barda göster';

  @override
  String get noVouchers => 'Henüz kupon yok. Sikkeleri ganimetle takas et.';

  @override
  String get showThisCode => 'Bu kodu barda göster';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days gün kaldı',
      one: '1 gün kaldı',
    );
    return '$date tarihine kadar geçerli · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return '$date tarihinde kullanıldı';
  }

  @override
  String exchangedOn(String date, String coins) {
    return '$date tarihinde alındı · $coins sikke';
  }

  @override
  String get stepShowCode => 'Kodu göster';

  @override
  String get stepTeamConfirms => 'Ekip onaylar';

  @override
  String get stepEnjoy => 'Keyfini çıkar';

  @override
  String get voucherLiveNote =>
      'Ekip onaylar onaylamaz durum canlı güncellenir.';

  @override
  String expiryInfo(int months) {
    return 'Sikkelerin süresi $months ay sonra dolar';
  }

  @override
  String get xpNeverExpires => 'XP’nin süresi asla dolmaz';

  @override
  String get coinsNoCash =>
      'Sikkeler nakit değeri olmayan gönüllü bir sadakat avantajıdır ve asla ödenmez.';

  @override
  String get toShop => 'Mağazaya git';

  @override
  String get fameTitle => 'Şöhretler Salonu';

  @override
  String get allHeroes => 'Tüm kahramanlar';

  @override
  String get rankHeader => 'SIRA · KAHRAMAN';

  @override
  String get yourPosition => 'Sıran';

  @override
  String xpToRank(String xp, int rank) {
    return '$rank. sıraya $xp XP';
  }

  @override
  String get alleyTitle => 'Ölümsüzler Yolu';

  @override
  String get alleyBody =>
      'Seviye VIII’e ulaş – Einherjar ya da Valkür olarak – ve burada sonsuza dek bir heykelin olsun.';

  @override
  String get alleyFree => 'Hâlâ boş';

  @override
  String rankInFame(int rank) {
    return 'Şöhretler Salonu’nda $rank. sıra';
  }

  @override
  String get reportName => 'Kahraman adını bildir';

  @override
  String get reportThanks => 'Teşekkürler – inceleyeceğiz.';

  @override
  String get share => 'Paylaş';

  @override
  String get directions => 'Yol tarifi';

  @override
  String get eventsNews => 'Etkinlikler ve haberler';

  @override
  String get optionalRevocable =>
      'İsteğe bağlı · istediğin zaman geri alınabilir';

  @override
  String get personalOffers => 'Kişisel teklifler';

  @override
  String get personalOffersCaption => 'İsteğe bağlı · ziyaretlerine göre';

  @override
  String get serviceNotifications => 'Ziyaretler ve ödüller';

  @override
  String get serviceNotificationsCaption =>
      'Onaylar, seviye atlamalar, süresi dolan sikkeler';

  @override
  String get alwaysOn => 'Her zaman açık';

  @override
  String get showInFame => 'Şöhretler Salonu’nda göster';

  @override
  String get showInFameCaption =>
      'Sadece kahraman adı ve görünümü – asla gerçek adın';

  @override
  String get account => 'Hesap';

  @override
  String get heroName => 'Kahraman adı';

  @override
  String get editHeroName => 'Kahraman adını değiştir';

  @override
  String get teamGroup => 'Ekip';

  @override
  String get teamMode => 'Ekip modunu aç';

  @override
  String get teamModeCaption =>
      'Ziyaretleri onayla, fotoğrafları ve kuponları kontrol et';

  @override
  String get legal => 'Yasal';

  @override
  String get terms => 'Katılım koşulları';

  @override
  String get privacyPolicy => 'Gizlilik politikası';

  @override
  String get imprint => 'Künye (Impressum)';

  @override
  String get myData => 'Verilerim';

  @override
  String get exportCaption => 'Tüm verilerini içeren JSON dosyası';

  @override
  String get deleteCaption => 'Sikkelerin ve kuponların kaybolur.';

  @override
  String get hornCalls => 'Boru çağrıları';

  @override
  String get markAllRead => 'Tümünü okundu say';

  @override
  String get today => 'Bugün';

  @override
  String get earlier => 'Daha önce';

  @override
  String get counter => 'Bar';

  @override
  String get teamModeBadge => 'EKİP MODU';

  @override
  String get exitTeam => 'Çık';

  @override
  String claimsTab(int count) {
    return 'Ziyaretler · $count';
  }

  @override
  String get voucherCheckTab => 'Kupon kontrol et';

  @override
  String get highAmount => 'Yüksek tutar – fişi kontrol et';

  @override
  String get voucherCodeLabel => 'Misafirin kupon kodu';

  @override
  String get voucherValid => 'Geçerli';

  @override
  String get voucherUsedHint =>
      'Sonrasında kod kullanılmış olur. Sadece yöneticiler geri alabilir.';

  @override
  String get welcomeHeadline => 'Her ziyaret destanını yazar.';

  @override
  String get welcomeBody =>
      'Fişleri tara, salondan anları paylaş ve sikkeleri merch ve özel deneyimlerle takas et.';

  @override
  String get continueWithEmail => 'E-posta';

  @override
  String get adultsOnlyFooter => 'Sadece 18 yaş üstü misafirler';

  @override
  String get emailSignInTitle => 'E-posta ile giriş';

  @override
  String get newHereCreate => 'Burada yeni misin? Hesap oluştur';

  @override
  String get beforeYouEnter => 'Salona girmeden önce';

  @override
  String get ageBody =>
      'Valhalla Hero sadece 18 yaş üstü misafirler içindir. Doğum tarihin gizli kalır.';

  @override
  String get ageOk => 'Her şey tamam – hoş geldin.';

  @override
  String get consentsTitle => 'İzinler';

  @override
  String get eventsNewsConsentCaption =>
      'Salonda bir şeyler olduğunda push bildirimleri.';

  @override
  String get offersConsentCaption => 'Ziyaretlerine göre teklifler.';

  @override
  String get consentsFootnote =>
      'İkisi de isteğe bağlı ve ayarlardan her zaman değiştirilebilir. Ziyaret onaylarını her zaman alırsın.';

  @override
  String stepOf(int step, int total) {
    return 'Adım $step / $total';
  }

  @override
  String get heroAwakes => 'Kahramanın uyanıyor';

  @override
  String get chooseForm =>
      'Kahraman görünümünü seç. İstediğin zaman değiştirebilirsin – ilerlemen korunur.';

  @override
  String get heroNameLabel => 'Kahramanının adı';

  @override
  String get heroNameHint =>
      'Şöhretler Salonu’nda görünür. Lütfen gerçek isim kullanma.';

  @override
  String get startJourney => 'Yolculuğa başla';

  @override
  String get eightLevels => '8 seviye';

  @override
  String get appTagline => 'Senin ziyaretlerin. Senin efsanen.';

  @override
  String get dayMon => 'PZT';

  @override
  String get dayTue => 'SAL';

  @override
  String get dayWed => 'ÇAR';

  @override
  String get dayThu => 'PER';

  @override
  String get dayFri => 'CUM';

  @override
  String get daySat => 'CMT';

  @override
  String get daySun => 'PAZ';

  @override
  String get comingSoon => 'Yakında';

  @override
  String get tabEvents => 'Etkinlik';

  @override
  String get tabSaga => 'Destan';

  @override
  String get tabScan => 'Tara';

  @override
  String get tonight => 'Bu akşam';

  @override
  String get tomorrow => 'Yarın';

  @override
  String get liveNow => 'Şimdi sürüyor';

  @override
  String get eventsEmpty => 'Şu anda planlanmış etkinlik yok.';

  @override
  String get catMatch => 'Canlı spor';

  @override
  String get catLive => 'Canlı müzik';

  @override
  String get catQuiz => 'Bilgi yarışması';

  @override
  String get catParty => 'Parti';

  @override
  String get catSpecial => 'Özel';

  @override
  String get scanTitle => 'Fiş tara';

  @override
  String get scanHint => 'Kamerayı fişindeki QR koda doğrult.';

  @override
  String get scanFromPhotos => 'Fotoğraflardan';

  @override
  String get scanEnterCode => 'Kod gir';

  @override
  String get scanCodeHint => 'Fişindeki QR kodun altında yazılı.';

  @override
  String get scanNoQr => 'QR olmadan bildir';

  @override
  String get scanDemo => 'Demo fiş';

  @override
  String get scanChecking => 'Fiş kontrol ediliyor …';

  @override
  String get torch => 'Işık';

  @override
  String get scanNoCamera => 'Kamera yok. Bir fotoğraf seç ya da kodu gir.';

  @override
  String get scanNothingInImage => 'Görselde QR kod bulunamadı.';

  @override
  String get scanOnce =>
      'Her fiş bir kez sayılır – XP ziyaret başına, sikkeler tutara göre.';

  @override
  String get receiptErrUsed => 'Bu fiş zaten kullanıldı.';

  @override
  String get receiptErrInvalid => 'Bu geçerli bir Valhalla fişi değil.';

  @override
  String get receiptErrTooOld => 'Bu fiş çok eski.';

  @override
  String get receiptErrUnknownVenue => 'Bu fiş bir Valhalla barına ait değil.';

  @override
  String get receiptErrDailyLimit =>
      'Bugün burada zaten bir fiş kullandın. Yarın görüşürüz!';

  @override
  String get sagaComposerTitle => 'Anını paylaş';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Salondan ya da Valhalla merch’üyle fotoğraf · +$xp XP · +$coins sikke';
  }

  @override
  String get checkinNewTitle => 'Fotoğraf paylaş';

  @override
  String get takePhoto => 'Kamera';

  @override
  String get pickPhoto => 'Galeri';

  @override
  String get captionHint => 'Salonda neler oluyor?';

  @override
  String get tagEvent => 'Etkinlik etiketle';

  @override
  String get noEvent => 'Etkinlik yok';

  @override
  String get checkinRules =>
      'Sadece salondan ya da Valhalla merch’üyle fotoğraflar. Ekip her fotoğrafı destanda görünmeden önce kontrol eder.';

  @override
  String checkinReward(int xp, int coins) {
    return 'Onaydan sonra +$xp XP · +$coins sikke (günde bir kez)';
  }

  @override
  String get checkinSubmit => 'Kontrole gönder';

  @override
  String get checkinPendingTitle => 'Fotoğrafın kontrol ediliyor';

  @override
  String get checkinPendingBody =>
      'Ekip onaylar onaylamaz destanda görünür. O zamana kadar başka fotoğraf gönderemezsin.';

  @override
  String get checkinWithdraw => 'Geri çek';

  @override
  String get checkinRejectedTitle => 'Fotoğraf onaylanmadı';

  @override
  String get checkinErrPending => 'Kontrol edilen bir fotoğrafın zaten var.';

  @override
  String get sagaEmpty => 'Henüz fotoğraf yok. İlk sen ol!';

  @override
  String get justNow => 'az önce';

  @override
  String agoMinutes(int minutes) {
    return '$minutes dk önce';
  }

  @override
  String agoHours(int hours) {
    return '$hours sa önce';
  }

  @override
  String get photosInSaga => 'Destandaki fotoğraflar';

  @override
  String teamPhotosTab(int count) {
    return 'Fotoğraflar · $count';
  }

  @override
  String get teamPhotosEmpty => 'Kontrol edilecek fotoğraf yok.';

  @override
  String get approvePhoto => 'Onayla';

  @override
  String get helpFeedback => 'Yardım ve geri bildirim';

  @override
  String get reportBug => 'Hata bildir';

  @override
  String get reportBugCaption => 'Bir şey çalışmıyor mu? Bize haber ver.';

  @override
  String get bugDescribe => 'Ne oldu?';

  @override
  String get bugHint => 'Ne yaptığını ve neyin ters gittiğini kısaca anlat.';

  @override
  String get bugIncludeInfo => 'Uygulama ve cihaz bilgisini ekle';

  @override
  String get bugSend => 'Gönder';

  @override
  String get bugThanks => 'Teşekkürler! İlgileniyoruz.';

  @override
  String get chooseLanguage => 'Dil seç';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beğeni',
      one: '1 beğeni',
      zero: 'Henüz beğeni yok',
    );
    return '$_temp0';
  }
}
