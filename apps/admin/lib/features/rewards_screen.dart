import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shell/admin_shell.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  Future<void> _edit(BuildContext context, WidgetRef ref, Reward? r) async {
    final t = L10n.of(context);
    RewardType type = r?.type ?? RewardType.merch;
    bool active = r?.isActive ?? true;
    final nameDe = TextEditingController(text: r?.nameDe);
    final nameEn = TextEditingController(text: r?.nameEn);
    final descDe = TextEditingController(text: r?.descriptionDe);
    final descEn = TextEditingController(text: r?.descriptionEn);
    final image = TextEditingController(text: r?.imageUrl);
    final price = TextEditingController(text: r?.priceCoins.toString());
    final stock = TextEditingController(text: r?.stock?.toString() ?? '');
    final validity = TextEditingController(text: (r?.validityDays ?? 30).toString());
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text(r == null ? t.adminRewards : r.nameDe),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                DropdownButtonFormField<RewardType>(
                  initialValue: type,
                  items: [for (final v in RewardType.values) DropdownMenuItem(value: v, child: Text(v.name))],
                  onChanged: (v) => setS(() => type = v!),
                  decoration: const InputDecoration(labelText: 'Type', isDense: true),
                ),
                const SizedBox(height: 10),
                Field('${t.adminTitle} (DE)', nameDe),
                Field('${t.adminTitle} (EN)', nameEn),
                Field('${t.adminBody} (DE)', descDe, lines: 2),
                Field('${t.adminBody} (EN)', descEn, lines: 2),
                Field(t.adminImageUrl, image),
                Field(t.adminPrice, price, number: true),
                Field(t.adminStock, stock, number: true),
                Field(t.adminValidityDays, validity, number: true),
                SwitchListTile(title: Text(t.adminActive), value: active, onChanged: (v) => setS(() => active = v), contentPadding: EdgeInsets.zero),
              ]),
            ),
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.cancel)), FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.save))],
        ),
      ),
    );
    if (ok != true || !context.mounted) return;
    await runAction(context, () async {
      await ref.read(adminRepoProvider).upsertReward({
        if (r != null) 'id': r.id,
        'type': enumWire(type),
        'name_de': nameDe.text.trim(),
        'name_en': nameEn.text.trim(),
        'description_de': descDe.text.trim().isEmpty ? null : descDe.text.trim(),
        'description_en': descEn.text.trim().isEmpty ? null : descEn.text.trim(),
        'image_url': image.text.trim().isEmpty ? null : image.text.trim(),
        'price_coins': int.tryParse(price.text) ?? 0,
        'stock': stock.text.trim().isEmpty ? null : int.tryParse(stock.text),
        'validity_days': int.tryParse(validity.text) ?? 30,
        'is_active': active,
      });
      ref.invalidate(allRewardsProvider);
      ref.invalidate(rewardsProvider);
    }, success: t.adminSaved);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final rewards = ref.watch(allRewardsProvider);
    return AdminPage(
      title: t.adminRewards,
      actions: [FilledButton.icon(onPressed: () => _edit(context, ref, null), icon: const Icon(Icons.add), label: Text(t.adminRewards))],
      child: AsyncView(
        value: rewards,
        onRetry: () => ref.invalidate(allRewardsProvider),
        data: (list) => ListView(children: [
          for (final r in list)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: RewardImage(type: r.type, imageUrl: r.imageUrl, size: 44),
                title: Text(r.name(locale), style: TextStyle(color: r.isActive ? VColors.bone : VColors.ash)),
                subtitle: Text('${r.type.name} · ${r.stock ?? '∞'} · ${r.validityDays} d'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  CoinChip(amount: r.priceCoins),
                  const SizedBox(width: 12),
                  IconButton(onPressed: () => _edit(context, ref, r), icon: const Icon(Icons.edit_outlined)),
                ]),
              ),
            ),
        ]),
      ),
    );
  }
}
