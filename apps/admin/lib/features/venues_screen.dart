import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shell/admin_shell.dart';

class VenuesScreen extends ConsumerWidget {
  const VenuesScreen({super.key});

  Future<void> _edit(BuildContext context, WidgetRef ref, Venue? v) async {
    final t = L10n.of(context);
    bool active = v?.isActive ?? true;
    final name = TextEditingController(text: v?.name);
    final slug = TextEditingController(text: v?.slug);
    final address = TextEditingController(text: v?.address);
    final city = TextEditingController(text: v?.city);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text(v?.name ?? t.adminVenues),
          content: SizedBox(
            width: 420,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Field(t.adminTitle, name),
              Field('Slug', slug),
              Field('Adresse', address),
              Field('Stadt', city),
              SwitchListTile(title: Text(t.adminActive), value: active, onChanged: (x) => setS(() => active = x), contentPadding: EdgeInsets.zero),
            ]),
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.cancel)), FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.save))],
        ),
      ),
    );
    if (ok != true || !context.mounted) return;
    await runAction(context, () async {
      await ref.read(adminRepoProvider).upsertVenue({
        if (v != null) 'id': v.id,
        'name': name.text.trim(),
        'slug': slug.text.trim().isEmpty ? name.text.trim().toLowerCase().replaceAll(RegExp('[^a-z0-9]+'), '-') : slug.text.trim(),
        'address': address.text.trim(),
        'city': city.text.trim(),
        'is_active': active,
      });
      ref.invalidate(venuesProvider);
      ref.invalidate(activeVenuesProvider);
    }, success: t.adminSaved);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final venues = ref.watch(venuesProvider);
    return AdminPage(
      title: t.adminVenues,
      actions: [FilledButton.icon(onPressed: () => _edit(context, ref, null), icon: const Icon(Icons.add), label: Text(t.adminVenues))],
      child: AsyncView(
        value: venues,
        onRetry: () => ref.invalidate(venuesProvider),
        data: (list) => ListView(children: [
          for (final v in list)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(Icons.store, color: v.isActive ? VColors.gold : VColors.ash),
                title: Text(v.name),
                subtitle: Text('${v.address ?? ''}, ${v.city ?? ''} · ${v.slug}'),
                trailing: IconButton(onPressed: () => _edit(context, ref, v), icon: const Icon(Icons.edit_outlined)),
              ),
            ),
        ]),
      ),
    );
  }
}
