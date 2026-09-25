import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shell/admin_shell.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  Future<void> _edit(BuildContext context, WidgetRef ref, Post? p) async {
    final t = L10n.of(context);
    final venues = await ref.read(venuesProvider.future);
    if (!context.mounted) return;
    PostType type = p?.type ?? PostType.news;
    String? venueId = p?.venueId;
    DateTime? startsAt = p?.startsAt;
    final title = TextEditingController(text: p?.title);
    final body = TextEditingController(text: p?.body);
    final image = TextEditingController(text: p?.imageUrl);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text(p == null ? t.adminNewPost : p.title),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(children: [
                  Expanded(child: DropdownButtonFormField<PostType>(initialValue: type, items: [for (final v in PostType.values) DropdownMenuItem(value: v, child: Text(v == PostType.news ? t.postTypeNews : t.postTypeEvent))], onChanged: (v) => setS(() => type = v!), decoration: const InputDecoration(isDense: true))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String?>(
                      initialValue: venueId,
                      items: [DropdownMenuItem<String?>(value: null, child: Text('— ${t.claimVenue} —')), for (final v in venues) DropdownMenuItem<String?>(value: v.id, child: Text(v.name))],
                      onChanged: (v) => setS(() => venueId = v),
                      decoration: InputDecoration(labelText: t.claimVenue, isDense: true),
                    ),
                  ),
                ]),
                const SizedBox(height: 10),
                Field(t.adminTitle, title),
                Field(t.adminBody, body, lines: 5),
                Field(t.adminImageUrl, image),
                if (type == PostType.event)
                  OutlinedButton.icon(
                    onPressed: () async {
                      final d = await showDatePicker(context: ctx, initialDate: startsAt ?? DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 1)), lastDate: DateTime.now().add(const Duration(days: 365)));
                      if (d == null || !ctx.mounted) return;
                      final tm = await showTimePicker(context: ctx, initialTime: TimeOfDay.fromDateTime(startsAt ?? DateTime.now()));
                      if (tm == null) return;
                      setS(() => startsAt = DateTime(d.year, d.month, d.day, tm.hour, tm.minute));
                    },
                    icon: const Icon(Icons.event),
                    label: Text(startsAt == null ? t.adminStartsAt : formatDateTime(startsAt!)),
                  ),
              ]),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(t.cancel)),
            OutlinedButton(onPressed: () => Navigator.pop(ctx, 'draft'), child: Text(t.adminDraft)),
            FilledButton(onPressed: () => Navigator.pop(ctx, 'publish'), child: Text(t.adminPublish)),
          ],
        ),
      ),
    );
    if (result == null || !context.mounted) return;
    await runAction(context, () async {
      await ref.read(feedRepoProvider).upsert(
            id: p?.id,
            type: type,
            title: title.text.trim(),
            body: body.text.trim(),
            imageUrl: image.text.trim().isEmpty ? null : image.text.trim(),
            venueId: venueId,
            startsAt: type == PostType.event ? startsAt : null,
            publish: result == 'publish' || (p?.isPublished ?? false),
          );
      ref.invalidate(adminPostsProvider);
      ref.invalidate(feedProvider);
    }, success: t.adminSaved);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final posts = ref.watch(adminPostsProvider);
    return AdminPage(
      title: t.adminPosts,
      actions: [FilledButton.icon(onPressed: () => _edit(context, ref, null), icon: const Icon(Icons.add), label: Text(t.adminNewPost))],
      child: AsyncView(
        value: posts,
        onRetry: () => ref.invalidate(adminPostsProvider),
        data: (list) => ListView(children: [
          for (final p in list)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(p.type == PostType.event ? Icons.event : Icons.article_outlined, color: p.isPublished ? VColors.gold : VColors.ash),
                title: Text(p.title, style: TextStyle(color: p.isPublished ? VColors.bone : VColors.ash)),
                subtitle: Text('${p.isPublished ? formatDate(p.publishedAt!, locale: locale) : t.adminDraft}${p.startsAt != null ? ' · ${formatDateTime(p.startsAt!, locale: locale)}' : ''} · ♥ ${p.likeCount}'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(onPressed: () => _edit(context, ref, p), icon: const Icon(Icons.edit_outlined)),
                  IconButton(
                    onPressed: () => runAction(context, () async {
                      await ref.read(feedRepoProvider).delete(p.id);
                      ref.invalidate(adminPostsProvider);
                      ref.invalidate(feedProvider);
                    }),
                    icon: const Icon(Icons.delete_outline, color: VColors.blood),
                  ),
                ]),
              ),
            ),
        ]),
      ),
    );
  }
}
