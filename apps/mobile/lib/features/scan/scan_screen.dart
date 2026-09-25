import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import '../claim/claim_sheet.dart';
import '../claim/claim_status_screen.dart';

/// Centre action: scan the TSE QR on the receipt (or type its one-time code).
/// The server credits the visit instantly; the amount comes from the receipt.
class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});
  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final _controller = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates, formats: const [BarcodeFormat.qrCode]);
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _redeem(String payload) async {
    if (_busy) return;
    setState(() => _busy = true);
    HapticFeedback.mediumImpact();
    await _controller.stop();
    try {
      final result = await ref.read(communityRepoProvider).redeemReceipt(payload);
      ref.read(lastReceiptProvider.notifier).state = result;
      invalidateUserData(ref);
      if (mounted) context.pushReplacement('/credited');
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      await _showError(e);
      if (!mounted) return;
      // nothing more to scan today: leave the scanner
      if (e.code == ApiErrorCode.receiptDailyLimit) {
        context.pop();
      } else {
        await _controller.start();
      }
    }
  }

  Future<void> _showError(ApiError e) {
    final t = L10n.of(context);
    final dayDone = e.code == ApiErrorCode.receiptDailyLimit;
    final msg = switch (e.code) {
      ApiErrorCode.receiptUsed => t.receiptErrUsed,
      ApiErrorCode.receiptTooOld => t.receiptErrTooOld,
      ApiErrorCode.receiptUnknownVenue => t.receiptErrUnknownVenue,
      ApiErrorCode.receiptDailyLimit => t.receiptErrDailyLimit,
      ApiErrorCode.receiptInvalid => t.receiptErrInvalid,
      _ => e.message,
    };
    return showVSheet<void>(
      context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: VColors.bloodText, width: 2)),
            child: const Center(child: VIcon(VIcons.close, size: 28, color: VColors.bloodText, stroke: 2.2)),
          ),
          const SizedBox(height: 14),
          Text(msg, textAlign: TextAlign.center, style: VType.body(size: 16, weight: FontWeight.w700, height: 1.4)),
          const SizedBox(height: 20),
          VPrimaryButton(label: dayDone ? t.gotIt : t.retry, onPressed: () => Navigator.pop(ctx)),
          if (!dayDone)
            VGhostButton(
              label: t.scanNoQr,
              onPressed: () {
                Navigator.pop(ctx);
                openClaimSheet(context);
              },
            ),
        ]),
      ),
    );
  }

  Future<void> _fromPhotos() async {
    final t = L10n.of(context);
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    String? value;
    try {
      final res = await _controller.analyzeImage(file.path, formats: const [BarcodeFormat.qrCode]);
      value = res?.barcodes.map((b) => b.rawValue).whereType<String>().firstOrNull;
    } catch (_) {
      // e.g. unsupported on the iOS simulator – treat like "no code found"
    }
    if (value == null) {
      if (mounted) showSnack(context, t.scanNothingInImage, error: true);
      return;
    }
    await _redeem(value);
  }

  Future<void> _enterCode() async {
    final t = L10n.of(context);
    final ctrl = TextEditingController();
    final code = await showVSheet<String>(
      context,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + MediaQuery.viewInsetsOf(ctx).bottom),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(t.scanEnterCode, style: VType.cinzel(size: 22)),
          const SizedBox(height: 14),
          TextField(
            controller: ctrl,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
            style: VType.body(size: 22, weight: FontWeight.w800, spacing: 2, tabular: true),
            decoration: InputDecoration(hintText: 'VH-XXXX-XX', helperText: t.scanCodeHint),
            onSubmitted: (v) => Navigator.pop(ctx, v),
          ),
          const SizedBox(height: 16),
          VPrimaryButton(label: t.confirm, onPressed: () => Navigator.pop(ctx, ctrl.text)),
        ]),
      ),
    );
    if (code != null && code.trim().isNotEmpty) await _redeem(code);
  }

  /// Local stack only: a valid DSFinV-K style payload for the demo register.
  String _demoPayload() {
    final r = Random();
    final food = (r.nextInt(3000) + 900) / 100;
    final drinks = (r.nextInt(2000) + 400) / 100;
    final now = DateTime.now().toUtc().toIso8601String();
    return 'V0;VH-BERLIN-KASSE-1;Kassenbeleg-V1;Beleg^${food.toStringAsFixed(2)}_${drinks.toStringAsFixed(2)}_0.00_0.00_0.00^'
        '${(food + drinks).toStringAsFixed(2)}:Bar;${r.nextInt(900000) + 100000};${r.nextInt(9000)};$now;$now;ecdsa-plain-SHA256;utcTime;DEMO;DEMO';
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(fit: StackFit.expand, children: [
        MobileScanner(
          controller: _controller,
          onDetect: (capture) {
            final value = capture.barcodes.map((b) => b.rawValue).whereType<String>().firstOrNull;
            if (value != null) _redeem(value);
          },
          errorBuilder: (context, error) => _NoCamera(message: t.scanNoCamera),
        ),
        const _Frame(),
        SafeArea(
          child: Column(children: [
            VTopBar(
              leading: VRoundButton(icon: VIcons.close, tooltip: t.close, onTap: () => context.pop()),
              title: t.scanTitle,
              actions: [VRoundButton(icon: VIcons.torch, tooltip: t.torch, onTap: () => _controller.toggleTorch())],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(t.scanHint, textAlign: TextAlign.center, style: VType.body(size: 15, weight: FontWeight.w700).copyWith(shadows: const [Shadow(blurRadius: 8)])),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(t.scanOnce, textAlign: TextAlign.center, style: VType.body(size: 12.5, color: VColors.ash).copyWith(shadows: const [Shadow(blurRadius: 8)])),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Expanded(child: VSecondaryButton(label: t.scanFromPhotos, icon: VIcons.image, onPressed: _busy ? null : _fromPhotos)),
                const SizedBox(width: 10),
                Expanded(child: VSecondaryButton(label: t.scanEnterCode, icon: VIcons.ticket, onPressed: _busy ? null : _enterCode)),
              ]),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              VGhostButton(label: t.scanNoQr, onPressed: _busy ? null : () => openClaimSheet(context)),
              if (Env.isLocal) VGhostButton(label: t.scanDemo, color: VColors.frostBright, onPressed: _busy ? null : () => _redeem(_demoPayload())),
            ]),
            const SizedBox(height: 8),
          ]),
        ),
        if (_busy)
          Container(
            color: const Color(0xB3070504),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 14),
              Text(t.scanChecking, style: VType.body(size: 15, weight: FontWeight.w700)),
            ]),
          ),
      ]),
    );
  }
}

class _Frame extends StatelessWidget {
  const _Frame();
  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: LayoutBuilder(builder: (context, c) {
          const size = 250.0;
          final top = c.maxHeight * .38 - size / 2;
          return Stack(children: [
            // dim everything outside the frame
            ColorFiltered(
              colorFilter: const ColorFilter.mode(Color(0x99000000), BlendMode.srcOut),
              child: Stack(children: [
                Container(decoration: const BoxDecoration(color: Colors.black, backgroundBlendMode: BlendMode.dstOut)),
                Positioned(
                  left: (c.maxWidth - size) / 2,
                  top: top,
                  child: Container(width: size, height: size, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(24))),
                ),
              ]),
            ),
            Positioned(
              left: (c.maxWidth - size) / 2,
              top: top,
              child: SizedBox(width: size, height: size, child: CustomPaint(painter: _CornerFrame())),
            ),
          ]);
        }),
      );
}

class _CornerFrame extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()
      ..color = VColors.goldBright
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    const l = 34.0, r = 24.0;
    void corner(double x, double y, double sx, double sy) {
      final path = Path()
        ..moveTo(x, y + sy * l)
        ..lineTo(x, y + sy * r)
        ..arcToPoint(Offset(x + sx * r, y), radius: const Radius.circular(r), clockwise: sx * sy > 0)
        ..lineTo(x + sx * l, y);
      canvas.drawPath(path, p);
    }

    corner(0, 0, 1, 1);
    corner(s.width, 0, -1, 1);
    corner(0, s.height, 1, -1);
    corner(s.width, s.height, -1, -1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NoCamera extends StatelessWidget {
  const _NoCamera({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(gradient: RadialGradient(center: Alignment(0, -.3), colors: [Color(0xFF2A1F16), VColors.bg])),
        // centred inside the scan frame (frame centre sits at 38 % height)
        child: Align(
          alignment: const Alignment(0, -.24),
          child: SizedBox(
            width: 200,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const VIcon(VIcons.camera, size: 30, color: VColors.ash2, stroke: 1.5),
              const SizedBox(height: 10),
              Text(message, textAlign: TextAlign.center, style: VType.body(size: 13, color: VColors.ash, height: 1.45)),
            ]),
          ),
        ),
      );
}
