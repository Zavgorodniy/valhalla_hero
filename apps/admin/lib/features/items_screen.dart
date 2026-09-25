import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shell/admin_shell.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  Future<void> _edit(BuildContext context, WidgetRef ref, Item? it) async {
    final t = L10n.of(context);
    final achievements = await ref.read(achievementsProvider.future);
    if (!context.mounted) return;
    ItemSlot slot = it?.slot ?? ItemSlot.headgear;
    ItemRarity rarity = it?.rarity ?? ItemRarity.common;
    ItemSource source = it?.source ?? ItemSource.shop;
    String? achievementKey = it?.unlockAchievementKey;
    bool active = it?.isActive ?? true;
    final nameDe = TextEditingController(text: it?.nameDe);
    final nameEn = TextEditingController(text: it?.nameEn);
    final asset = TextEditingController(text: it?.assetKey);
    final price = TextEditingController(text: it?.priceCoins?.toString() ?? '');
    final level = TextEditingController(text: it?.unlockLevel?.toString() ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text(it == null ? t.adminItems : it.nameDe),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(children: [
                  Expanded(child: DropdownButtonFormField<ItemSlot>(initialValue: slot, items: [for (final v in ItemSlot.values) DropdownMenuItem(value: v, child: Text(v.name))], onChanged: (v) => setS(() => slot = v!), decoration: const InputDecoration(labelText: 'Slot', isDense: true))),
                  const SizedBox(width: 10),
                  Expanded(child: DropdownButtonFormField<ItemRarity>(initialValue: rarity, items: [for (final v in ItemRarity.values) DropdownMenuItem(value: v, child: Text(v.name))], onChanged: (v) => setS(() => rarity = v!), decoration: const InputDecoration(labelText: 'Rarity', isDense: true))),
                ]),
                const SizedBox(height: 10),
                DropdownButtonFormField<ItemSource>(initialValue: source, items: [for (final v in ItemSource.values) DropdownMenuItem(value: v, child: Text(v.name))], onChanged: (v) => setS(() => source = v!), decoration: const InputDecoration(labelText: 'Source', isDense: true)),
                const SizedBox(height: 10),
                Field('${t.adminTitle} (DE)', nameDe),
                Field('${t.adminTitle} (EN)', nameEn),
                Field('Asset key (assets/items/<key>.svg)', asset),
                if (source == ItemSource.shop) Field(t.adminPrice, price, number: true),
                if (source == ItemSource.level) Field(t.adminLevelThreshold, level, number: true),
                if (source == ItemSource.achievement)
                  DropdownButtonFormField<String>(
                    initialValue: achievementKey,
                    items: [for (final a in achievements) DropdownMenuItem(value: a.key, child: Text(a.nameDe))],
                    onChanged: (v) => setS(() => achievementKey = v),
                    decoration: InputDecoration(labelText: t.achievements, isDense: true),
                  ),
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
      await ref.read(adminRepoProvider).upsertItem({
        if (it != null) 'id': it.id,
        'slot': enumWire(slot),
        'rarity': enumWire(rarity),
        'source': enumWire(source),
        'name_de': nameDe.text.trim(),
        'name_en': nameEn.text.trim(),
        'asset_key': asset.text.trim(),
        'price_coins': source == ItemSource.shop ? int.tryParse(price.text) : null,
        'unlock_level': source == ItemSource.level ? int.tryParse(level.text) : null,
        'unlock_achievement_key': source == ItemSource.achievement ? achievementKey : null,
        'is_active': active,
      });
      ref.invalidate(allItemsProvider);
      ref.invalidate(itemsProvider);
    }, success: t.adminSaved);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final items = ref.watch(allItemsProvider);
    return AdminPage(
      title: t.adminItems,
      actions: [FilledButton.icon(onPressed: () => _edit(context, ref, null), icon: const Icon(Icons.add), label: Text(t.adminItems))],
      child: AsyncView(
        value: items,
        onRetry: () => ref.invalidate(allItemsProvider),
        data: (list) => ListView(children: [
          for (final slot in ItemSlot.values) ...[
            SectionTitle(slot.name),
            for (final it in list.where((i) => i.slot == slot))
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: ItemPreview(assetKey: it.assetKey, slot: it.slot, size: 44),
                  title: Text(it.name(locale), style: TextStyle(color: it.isActive ? VColors.bone : VColors.ash)),
                  subtitle: Row(children: [
                    RarityDot(rarity: it.rarity, label: it.rarity.name),
                    const SizedBox(width: 10),
                    Text('${it.source.name}${it.unlockLevel != null ? ' · L${it.unlockLevel}' : ''}${it.unlockAchievementKey != null ? ' · ${it.unlockAchievementKey}' : ''}', style: const TextStyle(color: VColors.ash, fontSize: 12)),
                  ]),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    if (it.priceCoins != null) CoinChip(amount: it.priceCoins!),
                    const SizedBox(width: 12),
                    IconButton(onPressed: () => _edit(context, ref, it), icon: const Icon(Icons.edit_outlined)),
                  ]),
                ),
              ),
          ],
        ]),
      ),
    );
  }
}
