import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import '../../shared/locale.dart';
import '../../shared/sheets.dart';
import '../auth/auth_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final profile = ref.watch(profileProvider).valueOrNull;
    final email = ref.watch(currentUserProvider)?.email;
    final levels = ref.watch(levelMapProvider);
    if (profile == null) return const SizedBox.shrink();
    final notifier = ref.read(profileProvider.notifier);

    Future<void> run(Future<void> Function() fn) async {
      try {
        await fn();
      } on ApiError catch (e) {
        if (context.mounted) showSnack(context, e.message, error: true);
      }
    }

    Future<void> editName() async {
      final ctrl = TextEditingController(text: profile.nickname);
      final name = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(t.editHeroName),
          content: TextField(controller: ctrl, maxLength: 20, autofocus: true, style: VType.cinzel(size: 18), decoration: InputDecoration(helperText: t.heroNameHint, helperMaxLines: 2)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(t.cancel)),
            TextButton(onPressed: () => Navigator.pop(ctx, ctrl.text.trim()), child: Text(t.save)),
          ],
        ),
      );
      if (name != null && name.length >= 3 && name != profile.nickname) await run(() => notifier.updateProfile(nickname: name));
    }

    return VScreen(
      child: SafeArea(
        child: Column(children: [
          VTopBar(title: t.settings, back: true),
          Expanded(
            child: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 40), children: [
              VCard(
                onTap: editName,
                padding: const EdgeInsets.all(14),
                child: Row(children: [
                  VPortrait(level: profile.level, form: profile.heroForm, size: 52),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(profile.nickname, style: VType.cinzel(size: 19)),
                      Text(email ?? levelName(levels, profile.level, profile.heroForm), style: VType.body(size: 13, weight: FontWeight.w600, color: VColors.ash)),
                    ]),
                  ),
                  const VIcon(VIcons.chevRight, size: 18, color: VColors.ash2, stroke: 2),
                ]),
              ),
              _Group(title: t.language, children: [
                _Row(icon: VIcons.globe, title: t.chooseLanguage, value: languageName(ref.watch(uiLocaleProvider)), onTap: () => showLanguageSheet(context, ref)),
              ]),
              _Group(title: t.heroForm, children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      for (final f in HeroForm.values) ...[
                        if (f != HeroForm.values.first) const SizedBox(width: 10),
                        Expanded(
                          child: _FormOption(
                            form: f,
                            level: profile.level,
                            label: f == HeroForm.hero ? t.heroFormHero : t.heroFormHeroine,
                            sub: levelName(levels, profile.level, f),
                            selected: profile.heroForm == f,
                            onTap: () => run(() => notifier.updateProfile(heroForm: f).then((_) => ref.invalidate(leaderboardProvider))),
                          ),
                        ),
                      ],
                    ]),
                    const SizedBox(height: 10),
                    Text(t.heroFormHint, style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash)),
                  ]),
                ),
              ]),
              _Group(title: t.hornCalls, children: [
                _Row(icon: VIcons.horn, title: t.serviceNotifications, caption: t.serviceNotificationsCaption, trailing: Text(t.alwaysOn, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.ash))),
                _Row(
                  icon: VIcons.calendar,
                  title: t.eventsNews,
                  caption: t.optionalRevocable,
                  trailing: Switch(value: profile.pushMarketingConsent, onChanged: (v) => run(() => notifier.updateProfile(pushMarketingConsent: v))),
                ),
                _Row(
                  icon: VIcons.sparkle,
                  title: t.personalOffers,
                  caption: t.personalOffersCaption,
                  trailing: Switch(value: profile.personalisedOffersConsent, onChanged: (v) => run(() => notifier.updateProfile(personalisedOffersConsent: v))),
                ),
              ]),
              _Group(title: t.privacy, children: [
                _Row(
                  icon: VIcons.eye,
                  title: t.showInFame,
                  caption: t.showInFameCaption,
                  trailing: Switch(
                    value: profile.leaderboardVisible,
                    onChanged: (v) => run(() => notifier.updateProfile(leaderboardVisible: v).then((_) {
                          ref.invalidate(leaderboardProvider);
                          ref.invalidate(myRankProvider);
                        })),
                  ),
                ),
              ]),
              _Group(title: t.account, children: [
                _Row(icon: VIcons.held, title: t.heroName, value: profile.nickname, onTap: editName),
                _Row(icon: VIcons.calendar, title: t.birthDate, value: formatDate(profile.birthDate, locale: profile.locale), trailing: const VIcon(VIcons.lock, size: 16, color: VColors.ash2)),
              ]),
              if (profile.role.isStaff)
                _Group(title: t.teamGroup, accent: VColors.frost, children: [
                  _Row(icon: VIcons.key, iconColor: VColors.frostBright, title: t.teamMode, caption: t.teamModeCaption, onTap: () => context.push('/team')),
                ]),
              _Group(title: t.helpFeedback, children: [
                _Row(icon: VIcons.bug, title: t.reportBug, caption: t.reportBugCaption, onTap: () => showBugReportSheet(context, ref)),
              ]),
              _Group(title: t.legal, children: [
                for (final s in [t.terms, t.privacyPolicy, t.imprint]) _Row(icon: VIcons.doc, title: s, onTap: () => showSnack(context, t.comingSoon)),
              ]),
              _Group(title: t.myData, children: [
                _Row(
                  icon: VIcons.download,
                  title: t.exportData,
                  caption: t.exportCaption,
                  onTap: () => run(() async {
                    final data = await ref.read(profileRepoProvider).exportMyData();
                    await Share.share(const JsonEncoder.withIndent('  ').convert(data), subject: 'valhalla-hero-export.json');
                    if (context.mounted) showSnack(context, t.exportDataDone);
                  }),
                ),
                _Row(icon: VIcons.logout, title: t.signOut, onTap: () => ref.read(authServiceProvider).signOut()),
                _Row(
                  icon: VIcons.trash,
                  title: t.deleteAccount,
                  caption: t.deleteCaption,
                  danger: true,
                  onTap: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(t.deleteAccountTitle),
                        content: Text(t.deleteAccountBody(profile.coinBalance), style: VType.body(size: 14, color: VColors.ash)),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.cancel)),
                          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.delete, style: VType.body(size: 14, weight: FontWeight.w800, color: VColors.bloodText))),
                        ],
                      ),
                    );
                    if (ok == true) await run(() => ref.read(profileRepoProvider).deleteMyAccount());
                  },
                ),
              ]),
              const SizedBox(height: 18),
              Center(child: Text('Valhalla Hero 2.0 · ${Env.isLocal ? 'local' : 'cloud'}', style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash2))),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.children, this.accent});
  final String title;
  final List<Widget> children;
  final Color? accent;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.only(left: 4, bottom: 8), child: VEyebrow(title, color: accent ?? const Color(0xFFC9B89A), size: 11.5)),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1C1511), Color(0xFF161110)]),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: accent?.withValues(alpha: .4) ?? VColors.border),
            ),
            child: Column(children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const Divider(height: 1, color: Color(0x993A302A)),
                children[i],
              ],
            ]),
          ),
        ]),
      );
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.title, this.caption, this.value, this.trailing, this.onTap, this.danger = false, this.iconColor});
  final VIcons icon;
  final String title;
  final String? caption;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool danger;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    final c = danger ? VColors.bloodText : (iconColor ?? const Color(0xFFCDBFA8));
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: caption == null ? 8 : 12),
          child: Row(children: [
            VIcon(icon, size: 20, color: c, stroke: 1.8),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: VType.body(size: 15, weight: FontWeight.w700, color: danger ? VColors.bloodText : VColors.bone)),
                if (caption != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(caption!, style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash))),
              ]),
            ),
            if (value != null) Padding(padding: const EdgeInsets.only(left: 8), child: Text(value!, style: VType.body(size: 14, weight: FontWeight.w700, color: VColors.ash))),
            if (trailing != null) Padding(padding: const EdgeInsets.only(left: 8), child: trailing!) else if (onTap != null) const VIcon(VIcons.chevRight, size: 18, color: VColors.ash2, stroke: 2),
          ]),
        ),
      ),
    );
  }
}

class _FormOption extends StatelessWidget {
  const _FormOption({required this.form, required this.level, required this.label, required this.sub, required this.selected, required this.onTap});
  final HeroForm form;
  final int level;
  final String label;
  final String sub;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        selected: selected,
        label: label,
        child: GestureDetector(
          onTap: selected ? null : onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF120E0B),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: selected ? VColors.goldBright : VColors.border, width: selected ? 1.5 : 1),
            ),
            child: Row(children: [
              VPortrait(level: level, form: form, size: 40, ring: false),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(label, style: VType.body(size: 14.5, weight: FontWeight.w800)),
                  Text(sub, maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.cinzel(size: 10.5, color: VColors.level(level), spacing: .8)),
                ]),
              ),
              if (selected) const VIcon(VIcons.check, size: 18, color: VColors.goldBright, stroke: 2.4),
            ]),
          ),
        ),
      );
}
