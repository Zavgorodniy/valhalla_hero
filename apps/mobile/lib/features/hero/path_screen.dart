import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import 'hero_screen.dart';

/// Heldenweg as its own screen (opened from the XP bar on the Held tab).
class PathScreen extends ConsumerWidget {
  const PathScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider).valueOrNull;
    return VScreen(
      glow: VColors.frost,
      child: CustomScrollView(slivers: [
        SliverSafeArea(bottom: false, sliver: SliverToBoxAdapter(child: VTopBar(title: L10n.of(context).heroPath, back: true))),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        if (profile != null) PathSliver(profile: profile),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ]),
    );
  }
}
