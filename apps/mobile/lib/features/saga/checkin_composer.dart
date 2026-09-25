import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

/// Photo check-in: pick or take a photo, add a caption and an optional
/// event, send it for moderation. Only one photo can wait at a time.
class CheckinComposer extends ConsumerStatefulWidget {
  const CheckinComposer({super.key});
  @override
  ConsumerState<CheckinComposer> createState() => _CheckinComposerState();
}

class _CheckinComposerState extends ConsumerState<CheckinComposer> {
  final _caption = TextEditingController();
  Uint8List? _bytes;
  String _ext = 'jpg';
  String? _eventId;
  bool _busy = false;

  @override
  void dispose() {
    _caption.dispose();
    super.dispose();
  }

  Future<void> _pick(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(source: source, maxWidth: 1600, maxHeight: 1600, imageQuality: 82);
      if (file == null) return;
      final bytes = await file.readAsBytes();
      setState(() {
        _bytes = bytes;
        _ext = file.name.contains('.') ? file.name.split('.').last : 'jpg';
      });
    } catch (e) {
      if (mounted) showSnack(context, '$e', error: true);
    }
  }

  Future<void> _submit() async {
    final t = L10n.of(context);
    setState(() => _busy = true);
    try {
      await ref.read(communityRepoProvider).submit(
            bytes: _bytes!,
            extension: _ext,
            caption: _caption.text.trim().isEmpty ? null : _caption.text.trim(),
            eventId: _eventId,
          );
      ref.invalidate(myCheckinsProvider);
      if (mounted) context.pop();
    } on ApiError catch (e) {
      if (mounted) showSnack(context, e.code == ApiErrorCode.checkinPending ? t.checkinErrPending : e.message, error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final economy = ref.watch(economyProvider).valueOrNull;
    final now = DateTime.now();
    final events = ref.watch(upcomingEventsProvider).where((e) => e.startsAt!.toLocal().difference(now).inHours < 12).toList();

    return VScreen(
      glow: VColors.gold,
      child: SafeArea(
        child: Column(children: [
          VTopBar(title: t.checkinNewTitle, back: true),
          Expanded(
            child: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 24), children: [
              AspectRatio(
                aspectRatio: 4 / 5,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: VColors.field,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _bytes == null ? VColors.border : VColors.gold.withValues(alpha: .5), width: 1.5),
                  ),
                  child: _bytes == null
                      ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const VIcon(VIcons.camera, size: 48, color: VColors.ash2, stroke: 1.4),
                          const SizedBox(height: 18),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            SizedBox(width: 140, child: VSecondaryButton(label: t.takePhoto, icon: VIcons.camera, onPressed: () => _pick(ImageSource.camera))),
                            const SizedBox(width: 10),
                            SizedBox(width: 140, child: VSecondaryButton(label: t.pickPhoto, icon: VIcons.image, onPressed: () => _pick(ImageSource.gallery))),
                          ]),
                        ])
                      : Stack(fit: StackFit.expand, children: [
                          Image.memory(_bytes!, fit: BoxFit.cover),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: VRoundButton(icon: VIcons.close, tooltip: t.close, onTap: () => setState(() => _bytes = null)),
                          ),
                        ]),
                ),
              ),
              const SizedBox(height: 16),
              TextField(controller: _caption, maxLength: 200, maxLines: 3, minLines: 1, style: VType.body(size: 15), decoration: InputDecoration(hintText: t.captionHint)),
              if (events.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(t.tagEvent, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.parchment)),
                const SizedBox(height: 8),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  VChip(label: t.noEvent, active: _eventId == null, onTap: () => setState(() => _eventId = null)),
                  for (final e in events) VChip(label: e.title, icon: VIcons.calendar, active: _eventId == e.id, onTap: () => setState(() => _eventId = e.id)),
                ]),
              ],
              const SizedBox(height: 18),
              VCard(
                color: const Color(0xFF161110),
                padding: const EdgeInsets.all(14),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const VIcon(VIcons.info, size: 18, color: VColors.ash, stroke: 1.8),
                    const SizedBox(width: 10),
                    Expanded(child: Text(t.checkinRules, style: VType.body(size: 12.5, color: VColors.ash, height: 1.45))),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const VGem(size: 15),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(t.checkinReward(economy?.checkinXp ?? 30, economy?.checkinCoins ?? 50),
                          style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.frostBright)),
                    ),
                  ]),
                ]),
              ),
              const SizedBox(height: 18),
              VPrimaryButton(label: t.checkinSubmit, icon: VIcons.seal, busy: _busy, onPressed: _bytes == null ? null : _submit),
            ]),
          ),
        ]),
      ),
    );
  }
}
