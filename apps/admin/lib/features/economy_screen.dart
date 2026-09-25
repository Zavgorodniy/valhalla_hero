import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shell/admin_shell.dart';

class EconomyScreen extends ConsumerStatefulWidget {
  const EconomyScreen({super.key});
  @override
  ConsumerState<EconomyScreen> createState() => _EconomyScreenState();
}

class _EconomyScreenState extends ConsumerState<EconomyScreen> {
  final _ctrls = <String, TextEditingController>{};
  final _levelCtrls = <int, (TextEditingController, TextEditingController, TextEditingController)>{};

  TextEditingController _c(String key, String value) => _ctrls.putIfAbsent(key, () => TextEditingController(text: value));

  Future<void> _saveConfig(EconomyConfig cfg) async {
    final t = L10n.of(context);
    await runAction(context, () async {
      await ref.read(adminRepoProvider).updateEconomy(cfg.copyWith(
            xpPerVisit: int.tryParse(_ctrls['xp']!.text) ?? cfg.xpPerVisit,
            coinsPerEuro: num.tryParse(_ctrls['cpe']!.text.replaceAll(',', '.')) ?? cfg.coinsPerEuro,
            dailyCoinCap: int.tryParse(_ctrls['cap']!.text) ?? cfg.dailyCoinCap,
            coinExpiryMonths: int.tryParse(_ctrls['exp']!.text) ?? cfg.coinExpiryMonths,
            onboardWindowDays: int.tryParse(_ctrls['onb']!.text) ?? cfg.onboardWindowDays,
            streakBonusXp: int.tryParse(_ctrls['streak']!.text) ?? cfg.streakBonusXp,
          ));
      ref.invalidate(economyProvider);
    }, success: t.adminSaved);
  }

  Future<void> _saveLevels(List<Level> levels) async {
    final t = L10n.of(context);
    await runAction(context, () async {
      for (final l in levels) {
        final c = _levelCtrls[l.level];
        if (c == null) continue;
        await ref.read(adminRepoProvider).updateLevel(l.copyWith(
              name: c.$1.text.trim(),
              xpThreshold: int.tryParse(c.$2.text) ?? l.xpThreshold,
              coinMultiplier: num.tryParse(c.$3.text.replaceAll(',', '.')) ?? l.coinMultiplier,
            ));
      }
      ref.invalidate(levelsProvider);
    }, success: t.adminSaved);
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final economy = ref.watch(economyProvider);
    final levels = ref.watch(levelsProvider);
    return AdminPage(
      title: t.adminEconomy,
      child: ListView(children: [
        AsyncView(
          value: economy,
          compact: true,
          data: (cfg) => Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Wrap(spacing: 16, runSpacing: 4, children: [
                  for (final f in [
                    ('xp', t.adminEconomyXpPerVisit, '${cfg.xpPerVisit}'),
                    ('cpe', t.adminEconomyCoinsPerEuro, '${cfg.coinsPerEuro}'),
                    ('cap', t.adminEconomyDailyCap, '${cfg.dailyCoinCap}'),
                    ('exp', t.adminEconomyExpiryMonths, '${cfg.coinExpiryMonths}'),
                    ('onb', t.adminEconomyOnboardDays, '${cfg.onboardWindowDays}'),
                    ('streak', t.adminEconomyStreakBonus, '${cfg.streakBonusXp}'),
                  ])
                    SizedBox(width: 220, child: Field(f.$2, _c(f.$1, f.$3), number: true)),
                ]),
                Align(alignment: Alignment.centerRight, child: FilledButton(onPressed: () => _saveConfig(cfg), child: Text(t.save))),
              ]),
            ),
          ),
        ),
        SectionTitle(t.adminLevels),
        AsyncView(
          value: levels,
          compact: true,
          data: (list) => Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                for (final l in list)
                  Row(children: [
                    SizedBox(width: 90, child: HeroAvatar(heroAsset: l.heroAsset, size: 56, level: l.level)),
                    SizedBox(width: 36, child: Text('${l.level}', style: const TextStyle(fontWeight: FontWeight.w800, color: VColors.gold))),
                    Expanded(child: Field(t.adminTitle, _levelCtrls.putIfAbsent(l.level, () => (TextEditingController(text: l.name), TextEditingController(text: '${l.xpThreshold}'), TextEditingController(text: '${l.coinMultiplier}'))).$1)),
                    const SizedBox(width: 10),
                    SizedBox(width: 140, child: Field(t.adminLevelThreshold, _levelCtrls[l.level]!.$2, number: true)),
                    const SizedBox(width: 10),
                    SizedBox(width: 140, child: Field(t.adminLevelMultiplier, _levelCtrls[l.level]!.$3, number: true)),
                  ]),
                Align(alignment: Alignment.centerRight, child: FilledButton(onPressed: () => _saveLevels(list), child: Text(t.save))),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ]),
    );
  }
}
