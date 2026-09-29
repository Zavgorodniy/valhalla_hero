// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Valhalla Hero';

  @override
  String get tabShop => 'Botín';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signUp => 'Registrarse';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get email => 'Correo';

  @override
  String get password => 'Contraseña';

  @override
  String get nickname => 'Apodo';

  @override
  String get birthDate => 'Fecha de nacimiento';

  @override
  String get ageGateError => 'Debes tener al menos 18 años.';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta?';

  @override
  String get termsAccept =>
      'Acepto las condiciones de participación y he leído la política de privacidad.';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get signupConfirmTitle => 'Confirma tu correo';

  @override
  String signupConfirmBody(String email) {
    return 'Te enviamos un enlace a $email. Ábrelo y luego inicia sesión aquí.';
  }

  @override
  String get completeProfile => 'Completar perfil';

  @override
  String authError(String message) {
    return 'No se pudo iniciar sesión: $message';
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
    return '$count visitas';
  }

  @override
  String get claimVisit => 'Registrar visita';

  @override
  String get claimVisitTitle => 'Registrar una visita';

  @override
  String get claimVenue => 'Bar';

  @override
  String get claimAmount => 'Rechnungsbetrag (€)';

  @override
  String get claimNote => 'Notiz (optional)';

  @override
  String get claimTooManyPending => 'Tienes demasiadas solicitudes pendientes.';

  @override
  String get claimStatusApproved => 'Bestätigt';

  @override
  String get claimStatusRejected => 'Abgelehnt';

  @override
  String get myClaims => 'Mis solicitudes';

  @override
  String get achievements => 'Logros';

  @override
  String achievementsUnlocked(int unlocked, int total) {
    return '$unlocked de $total desbloqueados';
  }

  @override
  String get locked => 'Bloqueado';

  @override
  String get rewards => 'Recompensas';

  @override
  String get gear => 'Equipo';

  @override
  String get myVouchers => 'Mis vales';

  @override
  String get redeemed => '¡Canjeado! Muestra este código en la barra.';

  @override
  String get insufficientCoins => 'No tienes suficientes monedas.';

  @override
  String get outOfStock => 'Agotado';

  @override
  String stockLeft(int count) {
    return 'Quedan $count';
  }

  @override
  String validUntil(String date) {
    return 'Válido hasta el $date';
  }

  @override
  String get voucherActive => 'Activo';

  @override
  String get voucherRedeemed => 'Canjeado';

  @override
  String get voucherExpired => 'Caducado';

  @override
  String get voucherCancelled => 'Cancelado';

  @override
  String get rewardTypeMerch => 'Merch';

  @override
  String get rewardTypeDrink => 'Bebida';

  @override
  String get rewardTypeDiscount => 'Descuento';

  @override
  String get rewardTypePriorityBooking => 'Reserva';

  @override
  String get rewardTypeEventAccess => 'Evento';

  @override
  String get owned => 'Tuyo';

  @override
  String get equip => 'Equipar';

  @override
  String get equipped => 'Equipado';

  @override
  String get unequip => 'Quitar';

  @override
  String get purchaseDone => 'Comprado. Ya puedes equiparlo.';

  @override
  String unlockAtLevel(int level) {
    return 'Desde el nivel $level';
  }

  @override
  String unlockByAchievement(String name) {
    return 'Logro: $name';
  }

  @override
  String get unlockByEvent => 'Solo en eventos';

  @override
  String get slotHeadgear => 'Cabeza';

  @override
  String get slotHandItem => 'Mano';

  @override
  String get slotCape => 'Capa';

  @override
  String get slotCompanion => 'Compañero';

  @override
  String get slotFrame => 'Marco';

  @override
  String get rarityCommon => 'Común';

  @override
  String get rarityRare => 'Raro';

  @override
  String get rarityLegendary => 'Legendario';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardYou => 'Tú';

  @override
  String get leaderboardHidden => 'Estás oculto/a en la clasificación.';

  @override
  String get postTypeNews => 'Noticias';

  @override
  String get postTypeEvent => 'Evento';

  @override
  String get notifications => 'Mensajes';

  @override
  String get notificationsEmpty => 'No hay mensajes.';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get leaderboardVisible => 'Visible en la clasificación';

  @override
  String get privacy => 'Privacidad';

  @override
  String get exportData => 'Exportar mis datos';

  @override
  String get exportDataDone => 'Exportación creada.';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountTitle => '¿Eliminar de verdad tu cuenta?';

  @override
  String deleteAccountBody(int coins) {
    return 'Todos los datos, la XP y $coins monedas se eliminarán para siempre.';
  }

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get save => 'Guardar';

  @override
  String get close => 'Cerrar';

  @override
  String get gotIt => 'Entendido';

  @override
  String get retry => 'Reintentar';

  @override
  String get staffClaimsEmpty => 'No hay solicitudes pendientes.';

  @override
  String get staffApprove => 'Aprobar';

  @override
  String get staffReject => 'Rechazar';

  @override
  String get staffRejectReason => 'Motivo (opcional)';

  @override
  String get staffVoucherConfirm => 'Marcar como canjeado';

  @override
  String get staffVoucherNotFound => 'No hay ningún vale con este código.';

  @override
  String get staffVoucherDone => 'Vale canjeado.';

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
  String get coinReasonAchievement => 'Logro';

  @override
  String get coinReasonManual => 'Abono del equipo';

  @override
  String get coinReasonReward => 'Recompensa';

  @override
  String get coinReasonItem => 'Equipo';

  @override
  String get coinReasonExpiry => 'Caducidad';

  @override
  String get coinReasonRefund => 'Reembolso';

  @override
  String get coinReasonCheckin => 'Foto en la saga';

  @override
  String get tabHero => 'Héroe';

  @override
  String get heroPath => 'Camino del héroe';

  @override
  String get statStreak => 'Racha';

  @override
  String get statOnBoard => 'A bordo';

  @override
  String get statVisits => 'Visitas';

  @override
  String weeksCount(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks semanas',
      one: '1 semana',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get all => 'Todos';

  @override
  String get claimSheetSub => 'El equipo del bar confirma tu visita.';

  @override
  String get claimWhere => '¿Dónde estás?';

  @override
  String get change => 'Cambiar';

  @override
  String get claimAmountLabel => 'Importe de la cuenta';

  @override
  String get claimAmountHint =>
      'Solo define tus monedas. La XP es por visita, nunca por euro.';

  @override
  String get claimNoteLabel => 'Nota para el equipo (opcional)';

  @override
  String get claimNoteHint => 'p. ej. mesa 7';

  @override
  String get claimPreview => 'Tras la confirmación recibes';

  @override
  String streakBonus(int xp) {
    return '+$xp bonus de racha';
  }

  @override
  String get claimSentTitle => 'Visita registrada';

  @override
  String get claimSentBody =>
      'Muestra este código al equipo: es lo más rápido.';

  @override
  String get yourVisitCode => 'Tu código de visita';

  @override
  String get stepReported => 'Registrada';

  @override
  String get stepChecking => 'En revisión';

  @override
  String get stepCheckingSub => 'Normalmente menos de 5 minutos';

  @override
  String get stepCredited => 'Abonada';

  @override
  String get stepCreditedSub => 'XP, bonus de racha y monedas';

  @override
  String get hornWillCall => 'Tocaremos el cuerno cuando esté listo.';

  @override
  String get toHall => 'Volver al salón';

  @override
  String get claimRejectedTitle => 'Visita rechazada';

  @override
  String get claimRejectedBody => 'Habla un momento con el equipo en la barra.';

  @override
  String get visitConfirmed => 'Visita confirmada';

  @override
  String hallHonours(String name) {
    return 'El salón te honra, $name';
  }

  @override
  String get experience => 'Experiencia';

  @override
  String get coinsWord => 'Monedas';

  @override
  String streakNow(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '¡$weeks semanas a bordo!',
      one: '1 semana a bordo',
    );
    return '$_temp0';
  }

  @override
  String get streakKept => 'Racha mantenida: sigue así.';

  @override
  String get achievementUnlocked => 'Logro desbloqueado';

  @override
  String get continueLabel => 'Continuar';

  @override
  String levelReached(String level) {
    return '¡Nivel $level alcanzado!';
  }

  @override
  String coinBonus(String mult) {
    return 'Bonus de monedas ×$mult';
  }

  @override
  String coinBonusSub(String mult) {
    return 'Antes ×$mult, en cada visita';
  }

  @override
  String get newGear => 'Nuevo en tu equipo';

  @override
  String get newBackdrop => 'Nuevo fondo';

  @override
  String equipItem(String item) {
    return 'Equipar $item';
  }

  @override
  String get later => 'Más tarde';

  @override
  String get shareLevel => 'Compartir nivel';

  @override
  String shareLevelText(String level) {
    return '¡Acabo de convertirme en $level en Valhalla Hero!';
  }

  @override
  String ownedOf(int owned, int total) {
    return '$owned de $total en tu poder';
  }

  @override
  String get cosmeticOnly => 'Solo estético, sin efecto en el juego';

  @override
  String get heroForm => 'Aspecto del héroe';

  @override
  String get heroFormHero => 'Héroe';

  @override
  String get heroFormHeroine => 'Heroína';

  @override
  String get heroFormHint => 'Héroe o heroína: tu progreso se mantiene';

  @override
  String levelOfEight(String roman) {
    return 'Nivel $roman de VIII';
  }

  @override
  String xpToValhalla(String xp, String max) {
    return '$xp de $max XP hasta el Valhalla';
  }

  @override
  String get yourLevel => 'Tu nivel';

  @override
  String get nextUp => 'Siguiente';

  @override
  String fromXp(String xp) {
    return 'desde $xp XP';
  }

  @override
  String xpLeft(String xp) {
    return 'faltan $xp XP';
  }

  @override
  String get reached => 'Desbloqueado';

  @override
  String almostThere(String name) {
    return 'Casi: $name';
  }

  @override
  String longestStreak(int weeks) {
    return 'Récord $weeks';
  }

  @override
  String get rewardsRedeemed => 'Recompensas canjeadas';

  @override
  String get itemsOwned => 'Equipo en tu poder';

  @override
  String get yourBalance => 'Tu saldo';

  @override
  String get coinPurse => 'Monedero';

  @override
  String coinsExpireSoon(int coins, String date) {
    return '$coins monedas caducan el $date';
  }

  @override
  String get redeemBeforeExpiry => 'Gástalas antes en la tienda.';

  @override
  String get segVouchers => 'Vales';

  @override
  String get allRewards => 'Todas las recompensas';

  @override
  String missingCoins(String coins) {
    return 'Te faltan $coins';
  }

  @override
  String get holdToRedeem => 'Mantén pulsado para canjear';

  @override
  String get holdHint =>
      'Sin gastos por error: solo se confirma manteniendo pulsado.';

  @override
  String get priceLabel => 'Precio';

  @override
  String get balanceAfter => 'Saldo después';

  @override
  String get validLabel => 'Validez';

  @override
  String validDays(int days) {
    return '$days días desde el canje';
  }

  @override
  String get redeemHow => 'Cómo canjear';

  @override
  String get showCodeAtBar => 'Muestra el código en la barra';

  @override
  String get noVouchers => 'Aún no tienes vales. Cambia monedas por botín.';

  @override
  String get showThisCode => 'Muestra este código en la barra';

  @override
  String validUntilDays(String date, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'quedan $days días',
      one: 'queda 1 día',
    );
    return 'Válido hasta el $date · $_temp0';
  }

  @override
  String redeemedOn(String date) {
    return 'Canjeado el $date';
  }

  @override
  String exchangedOn(String date, String coins) {
    return 'Canjeado el $date · $coins monedas';
  }

  @override
  String get stepShowCode => 'Mostrar código';

  @override
  String get stepTeamConfirms => 'El equipo confirma';

  @override
  String get stepEnjoy => 'Disfruta';

  @override
  String get voucherLiveNote =>
      'El estado se actualiza en directo en cuanto el equipo confirma.';

  @override
  String expiryInfo(int months) {
    return 'Las monedas caducan a los $months meses';
  }

  @override
  String get xpNeverExpires => 'La XP nunca caduca';

  @override
  String get coinsNoCash =>
      'Las monedas son una ventaja de fidelidad voluntaria sin valor monetario y nunca se pagan.';

  @override
  String get toShop => 'A la tienda';

  @override
  String get fameTitle => 'Salón de la Fama';

  @override
  String get allHeroes => 'Todos los héroes';

  @override
  String get rankHeader => 'PUESTO · HÉROE';

  @override
  String get yourPosition => 'Tu posición';

  @override
  String xpToRank(String xp, int rank) {
    return '$xp XP hasta el puesto $rank';
  }

  @override
  String get alleyTitle => 'Avenida de los Inmortales';

  @override
  String get alleyBody =>
      'Alcanza el nivel VIII, como Einherjar o Valquiria, y tendrás aquí una estatua para siempre.';

  @override
  String get alleyFree => 'Aún libre';

  @override
  String rankInFame(int rank) {
    return 'Puesto $rank en el Salón de la Fama';
  }

  @override
  String get reportName => 'Denunciar nombre';

  @override
  String get reportThanks => 'Gracias, lo revisaremos.';

  @override
  String get share => 'Compartir';

  @override
  String get directions => 'Cómo llegar';

  @override
  String get eventsNews => 'Eventos y noticias';

  @override
  String get optionalRevocable => 'Opcional · revocable en cualquier momento';

  @override
  String get personalOffers => 'Ofertas personales';

  @override
  String get personalOffersCaption => 'Opcional · según tus visitas';

  @override
  String get serviceNotifications => 'Visitas y recompensas';

  @override
  String get serviceNotificationsCaption =>
      'Confirmaciones, subidas de nivel, monedas por caducar';

  @override
  String get alwaysOn => 'Siempre activo';

  @override
  String get showInFame => 'Mostrar en el Salón de la Fama';

  @override
  String get showInFameCaption =>
      'Solo el nombre y el aspecto del héroe, nunca tu nombre real';

  @override
  String get account => 'Cuenta';

  @override
  String get heroName => 'Nombre del héroe';

  @override
  String get editHeroName => 'Cambiar nombre del héroe';

  @override
  String get teamGroup => 'Equipo';

  @override
  String get teamMode => 'Abrir modo equipo';

  @override
  String get teamModeCaption => 'Confirmar visitas, revisar fotos y vales';

  @override
  String get legal => 'Legal';

  @override
  String get terms => 'Condiciones de participación';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get imprint => 'Aviso legal (Impressum)';

  @override
  String get myData => 'Mis datos';

  @override
  String get exportCaption => 'Archivo JSON con todos tus datos';

  @override
  String get deleteCaption => 'Perderás tus monedas y tus vales.';

  @override
  String get hornCalls => 'Llamadas del cuerno';

  @override
  String get markAllRead => 'Marcar todo como leído';

  @override
  String get today => 'Hoy';

  @override
  String get earlier => 'Antes';

  @override
  String get counter => 'Barra';

  @override
  String get teamModeBadge => 'MODO EQUIPO';

  @override
  String get exitTeam => 'Salir';

  @override
  String claimsTab(int count) {
    return 'Visitas · $count';
  }

  @override
  String get voucherCheckTab => 'Comprobar vale';

  @override
  String get highAmount => 'Importe alto: revisa el tique';

  @override
  String get voucherCodeLabel => 'Código del vale del cliente';

  @override
  String get voucherValid => 'Válido';

  @override
  String get voucherUsedHint =>
      'Después el código queda usado. Solo los admins pueden deshacerlo.';

  @override
  String get welcomeHeadline => 'Cada visita escribe tu saga.';

  @override
  String get welcomeBody =>
      'Escanea tiques, comparte momentos del salón y cambia monedas por merch y experiencias exclusivas.';

  @override
  String get continueWithEmail => 'Correo';

  @override
  String get adultsOnlyFooter => 'Solo para mayores de 18';

  @override
  String get emailSignInTitle => 'Iniciar sesión con correo';

  @override
  String get newHereCreate => '¿Nuevo aquí? Crear cuenta';

  @override
  String get beforeYouEnter => 'Antes de entrar al salón';

  @override
  String get ageBody =>
      'Valhalla Hero es solo para mayores de 18 años. Tu fecha de nacimiento es privada.';

  @override
  String get ageOk => 'Todo listo: bienvenido/a.';

  @override
  String get consentsTitle => 'Consentimientos';

  @override
  String get eventsNewsConsentCaption =>
      'Notificaciones push cuando pasa algo en el salón.';

  @override
  String get offersConsentCaption => 'Ofertas según tus visitas.';

  @override
  String get consentsFootnote =>
      'Ambos son opcionales y se pueden cambiar en los ajustes. Las confirmaciones de visitas llegan siempre.';

  @override
  String stepOf(int step, int total) {
    return 'Paso $step de $total';
  }

  @override
  String get heroAwakes => 'Tu héroe despierta';

  @override
  String get chooseForm =>
      'Elige el aspecto de tu héroe. Puedes cambiarlo cuando quieras: tu progreso se mantiene.';

  @override
  String get heroNameLabel => 'Nombre de tu héroe';

  @override
  String get heroNameHint =>
      'Se muestra en el Salón de la Fama. Nada de nombres reales, por favor.';

  @override
  String get startJourney => 'Empezar el viaje';

  @override
  String get eightLevels => '8 niveles';

  @override
  String get appTagline => 'Tus visitas. Tu leyenda.';

  @override
  String get dayMon => 'LUN';

  @override
  String get dayTue => 'MAR';

  @override
  String get dayWed => 'MIÉ';

  @override
  String get dayThu => 'JUE';

  @override
  String get dayFri => 'VIE';

  @override
  String get daySat => 'SÁB';

  @override
  String get daySun => 'DOM';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get tabEvents => 'Eventos';

  @override
  String get tabSaga => 'Saga';

  @override
  String get tabScan => 'Añadir';

  @override
  String get tonight => 'Esta noche';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get liveNow => 'En curso';

  @override
  String get eventsEmpty => 'No hay eventos programados por ahora.';

  @override
  String get eventsPast => 'Eventos pasados';

  @override
  String get catMatch => 'Deporte en directo';

  @override
  String get catLive => 'Música en vivo';

  @override
  String get catQuiz => 'Quiz';

  @override
  String get catParty => 'Fiesta';

  @override
  String get catSpecial => 'Especial';

  @override
  String get scanTitle => 'Escanear tique';

  @override
  String get scanHint => 'Apunta la cámara al código QR de tu tique.';

  @override
  String get scanFromPhotos => 'Desde fotos';

  @override
  String get scanEnterCode => 'Introducir código';

  @override
  String get scanCodeHint => 'Impreso debajo del código QR de tu tique.';

  @override
  String get scanNoQr => 'Registrar sin QR';

  @override
  String get scanDemo => 'Tique demo';

  @override
  String get scanChecking => 'Comprobando tique …';

  @override
  String get torch => 'Linterna';

  @override
  String get scanNoCamera =>
      'No hay cámara disponible. Elige una foto o introduce el código.';

  @override
  String get scanNothingInImage =>
      'No se encontró ningún código QR en la imagen.';

  @override
  String get scanOnce =>
      'Cada tique cuenta una vez: XP por visita, monedas según el importe.';

  @override
  String get receiptErrUsed => 'Este tique ya se ha canjeado.';

  @override
  String get receiptErrInvalid => 'Este no es un tique válido de Valhalla.';

  @override
  String get receiptErrTooOld => 'Este tique es demasiado antiguo.';

  @override
  String get receiptErrUnknownVenue => 'Este tique no es de un bar Valhalla.';

  @override
  String get receiptErrDailyLimit =>
      'Límite diario de tiques alcanzado. ¡Hasta mañana!';

  @override
  String get receiptAdded => 'Tique añadido';

  @override
  String get receiptAddedHint =>
      'La XP es por visita: más tiques el mismo día suman monedas.';

  @override
  String get sagaComposerTitle => 'Comparte tu momento';

  @override
  String sagaComposerSub(int xp, int coins) {
    return 'Foto del salón o con merch de Valhalla · +$xp XP · +$coins monedas';
  }

  @override
  String get checkinNewTitle => 'Compartir foto';

  @override
  String get takePhoto => 'Cámara';

  @override
  String get pickPhoto => 'Galería';

  @override
  String get captionHint => '¿Qué pasa en el salón?';

  @override
  String get tagEvent => 'Vincular un evento';

  @override
  String get noEvent => 'Sin evento';

  @override
  String get checkinRules =>
      'Solo fotos del salón o con merch de Valhalla. El equipo revisa cada foto antes de que aparezca en la saga.';

  @override
  String checkinReward(int xp, int coins) {
    return '+$xp XP · +$coins monedas tras la aprobación (una vez al día)';
  }

  @override
  String get checkinSubmit => 'Enviar a revisión';

  @override
  String get checkinPendingTitle => 'Tu foto está en revisión';

  @override
  String get checkinPendingBody =>
      'En cuanto el equipo la apruebe, aparecerá en la saga. Hasta entonces no puedes enviar otra.';

  @override
  String get checkinWithdraw => 'Retirar';

  @override
  String get checkinRejectedTitle => 'Foto no aprobada';

  @override
  String get checkinErrPending => 'Ya tienes una foto en revisión.';

  @override
  String get sagaEmpty => 'Aún no hay fotos. ¡Empieza tú la saga!';

  @override
  String get justNow => 'ahora mismo';

  @override
  String agoMinutes(int minutes) {
    return 'hace $minutes min';
  }

  @override
  String agoHours(int hours) {
    return 'hace $hours h';
  }

  @override
  String get photosInSaga => 'Fotos en la saga';

  @override
  String teamPhotosTab(int count) {
    return 'Fotos · $count';
  }

  @override
  String get teamPhotosEmpty => 'No hay fotos para revisar.';

  @override
  String get approvePhoto => 'Aprobar';

  @override
  String get helpFeedback => 'Ayuda y comentarios';

  @override
  String get reportBug => 'Informar de un error';

  @override
  String get reportBugCaption => '¿Algo no funciona? Cuéntanoslo.';

  @override
  String get bugDescribe => '¿Qué ha pasado?';

  @override
  String get bugHint => 'Describe brevemente qué hacías y qué salió mal.';

  @override
  String get bugIncludeInfo =>
      'Incluir información de la app y del dispositivo';

  @override
  String get bugSend => 'Enviar';

  @override
  String get bugThanks => '¡Gracias! Nos ponemos con ello.';

  @override
  String get chooseLanguage => 'Elegir idioma';

  @override
  String whoLikes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count me gusta',
      one: '1 me gusta',
      zero: 'Aún sin me gusta',
    );
    return '$_temp0';
  }
}
