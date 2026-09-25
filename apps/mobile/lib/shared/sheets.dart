import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import 'locale.dart';

/// Language list with native names; applies immediately.
Future<void> showLanguageSheet(BuildContext context, WidgetRef ref) {
  final t = L10n.of(context);
  final current = ref.read(uiLocaleProvider);
  return showVSheet<void>(
    context,
    builder: (ctx) => ListView(shrinkWrap: true, padding: const EdgeInsets.fromLTRB(20, 0, 20, 16), children: [
      Padding(padding: const EdgeInsets.only(bottom: 12, left: 4), child: Text(t.chooseLanguage, style: VType.cinzel(size: 20))),
      for (final (code, name) in appLanguages)
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: VCard(
            radius: 14,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            borderColor: code == current ? VColors.goldBright : null,
            onTap: () async {
              Navigator.pop(ctx);
              await setAppLanguage(ref, code);
            },
            child: Row(children: [
              Container(
                width: 34,
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: VColors.border)),
                child: Text(code.toUpperCase(), textAlign: TextAlign.center, style: VType.body(size: 11, weight: FontWeight.w800, color: VColors.ash)),
              ),
              const SizedBox(width: 14),
              Expanded(child: Text(name, style: VType.body(size: 16, weight: FontWeight.w700))),
              if (code == current) const VIcon(VIcons.check, size: 20, color: VColors.goldBright, stroke: 2.4),
            ]),
          ),
        ),
    ]),
  );
}

/// "Fehler melden": free text plus optional app/device context.
Future<void> showBugReportSheet(BuildContext context, WidgetRef ref) {
  return showVSheet<void>(context, builder: (_) => const _BugReport());
}

class _BugReport extends ConsumerStatefulWidget {
  const _BugReport();
  @override
  ConsumerState<_BugReport> createState() => _BugReportState();
}

class _BugReportState extends ConsumerState<_BugReport> {
  final _text = TextEditingController();
  bool _includeInfo = true;
  bool _busy = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final t = L10n.of(context);
    setState(() => _busy = true);
    try {
      final info = _includeInfo
          ? <String, dynamic>{
              'app': 'mobile 2.0',
              'platform': Platform.operatingSystem,
              'os': Platform.operatingSystemVersion,
              'locale': ref.read(uiLocaleProvider),
              'backend': Env.isLocal ? 'local' : 'cloud',
            }
          : <String, dynamic>{};
      await ref.read(communityRepoProvider).sendFeedback(_text.text.trim(), info);
      if (mounted) {
        Navigator.pop(context);
        showSnack(context, t.bugThanks);
      }
    } on ApiError catch (e) {
      if (mounted) showSnack(context, e.message, error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            const VIcon(VIcons.bug, size: 22, color: VColors.goldBright, stroke: 1.8),
            const SizedBox(width: 10),
            Text(t.reportBug, style: VType.cinzel(size: 21)),
          ]),
          const SizedBox(height: 14),
          Text(t.bugDescribe, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.parchment)),
          const SizedBox(height: 8),
          TextField(
            controller: _text,
            autofocus: true,
            minLines: 4,
            maxLines: 8,
            maxLength: 2000,
            onChanged: (_) => setState(() {}),
            style: VType.body(size: 15),
            decoration: InputDecoration(hintText: t.bugHint),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _includeInfo,
            onChanged: (v) => setState(() => _includeInfo = v),
            title: Text(t.bugIncludeInfo, style: VType.body(size: 14, weight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          VPrimaryButton(label: t.bugSend, busy: _busy, onPressed: _text.text.trim().length < 3 ? null : _send),
        ]),
      ),
    );
  }
}
