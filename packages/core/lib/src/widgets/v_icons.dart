import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Stroke icon set of the design system: 24 grid, 1.75 px, round caps.
enum VIcons {
  halle, held, beute, ruhm, saga, seal, horn, anchor, ship, coin, rune, settings, lock, check, ticket,
  chevRight, chevLeft, chevDown, close, heart, calendar, pin, clock, crown, flame, shield, axe, sword, cape,
  raven, frame, key, share, info, mail, user, arrowUp, hourglass, euro, note, logout, trash, download, globe,
  eye, doc, search, map, star, drum, torch, shirt, percent, music, sticker, plus, dots, flag, sparkle, route, apple,
}

const _paths = <VIcons, String>{
  VIcons.halle: '<path d="M2.5 12.5 13.5 3"/><path d="M21.5 12.5 10.5 3"/><path d="M5 10.3v10.2h14V10.3"/><path d="M10 20.5v-5h4v5"/>',
  VIcons.held: '<path d="M4.5 13.5C4.5 8.3 7.9 4 12 4s7.5 4.3 7.5 9.5"/><path d="M4.5 13.5h15"/><path d="M12 4v16"/><path d="M4.5 13.5V17l3 2.5"/><path d="M19.5 13.5V17l-3 2.5"/>',
  VIcons.beute: '<path d="M3.5 10.5h17v9h-17z"/><path d="M3.5 10.5v-2a4 4 0 0 1 4-4h9a4 4 0 0 1 4 4v2"/><path d="M10.5 10.5V14h3v-3.5"/><path d="M7.5 4.8v14.7M16.5 4.8v14.7"/>',
  VIcons.ruhm: '<path d="M3 20.5V14h6V9h6v3h6v8.5z"/><path d="M9 14v6.5M15 12v8.5"/><path d="m12 2.6 1 2 2.2.3-1.6 1.5.4 2.2-2-1.1-2 1.1.4-2.2-1.6-1.5 2.2-.3z"/>',
  VIcons.saga: '<path d="M17 7.5V18a2.5 2.5 0 0 1-2.5 2.5h-8A2.5 2.5 0 0 1 4 18v-.5h10v.5a2.5 2.5 0 0 0 2.5 2.5"/><path d="M17 7.5h3V6a2.5 2.5 0 0 0-2.5-2.5H9A2.5 2.5 0 0 0 6.5 6v11.5"/><path d="M9.5 9h4.5M9.5 12h4.5"/>',
  VIcons.seal: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.8v8.4M7.8 12h8.4"/>',
  VIcons.horn: '<path d="M3.5 3.5c1.2 7.6 6.1 14.2 14.1 16.6"/><path d="M3.5 3.5c3 6.2 8 9.8 15.9 9.6"/><ellipse cx="18.6" cy="16.6" rx="2.1" ry="3.6" transform="rotate(-18 18.6 16.6)"/><path d="M8.2 11.9l2.4-1.8M11.3 15.3l2.1-2.4"/>',
  VIcons.anchor: '<circle cx="12" cy="5" r="2"/><path d="M12 7v14"/><path d="M8.5 10.5h7"/><path d="M4.5 13.5c.4 4.3 3.6 7.5 7.5 7.5s7.1-3.2 7.5-7.5"/><path d="M3 15.2l1.5-1.9 2 1.4M21 15.2l-1.5-1.9-2 1.4"/>',
  VIcons.ship: '<path d="M3 14.5c3 3.3 15 3.3 18 0"/><path d="M21 14.5c.6-2.7-.6-4.6-2.4-4.4"/><path d="M3 14.5c-.6-2.7.6-4.6 2.4-4.4"/><path d="M12 16.9V3.5"/><path d="M7.5 5h9l-1 6.5h-7z"/>',
  VIcons.coin: '<circle cx="12" cy="12" r="8.5"/><circle cx="12" cy="12" r="5.5"/><path d="M10.6 9v6M10.6 11.1l2.8-1.8M10.6 13.2l2.8-1.8"/>',
  VIcons.rune: '<path d="M12 3l6 9-6 9-6-9z"/><path d="M12 3v18"/>',
  VIcons.settings: '<path d="M4 7h9M17 7h3M4 17h3M11 17h9"/><circle cx="15" cy="7" r="2"/><circle cx="9" cy="17" r="2"/>',
  VIcons.lock: '<rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8 10.5V8a4 4 0 0 1 8 0v2.5"/>',
  VIcons.check: '<path d="M5 12.5l4.5 4.5L19 7.5"/>',
  VIcons.ticket: '<path d="M3.5 7h17v3a2 2 0 0 0 0 4v3h-17v-3a2 2 0 0 0 0-4z"/><path d="M14.5 7.5v1.5M14.5 11.25v1.5M14.5 15v1.5"/>',
  VIcons.chevRight: '<path d="M9.5 6l6 6-6 6"/>',
  VIcons.chevLeft: '<path d="M14.5 6l-6 6 6 6"/>',
  VIcons.chevDown: '<path d="M6 9.5l6 6 6-6"/>',
  VIcons.close: '<path d="M6.5 6.5l11 11M17.5 6.5l-11 11"/>',
  VIcons.heart: '<path d="M12 20s-7.5-4.6-7.5-10.3A4.2 4.2 0 0 1 12 7.2a4.2 4.2 0 0 1 7.5 2.5C19.5 15.4 12 20 12 20z"/>',
  VIcons.calendar: '<rect x="4" y="5.5" width="16" height="15" rx="2"/><path d="M4 10h16M8.5 3.5V7M15.5 3.5V7"/>',
  VIcons.pin: '<path d="M12 21s-6.5-6-6.5-11a6.5 6.5 0 0 1 13 0c0 5-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.3"/>',
  VIcons.clock: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
  VIcons.crown: '<path d="M4.5 18 3.5 8l5 4 3.5-6.5 3.5 6.5 5-4-1 10z"/><path d="M4.5 21h15"/>',
  VIcons.flame: '<path d="M12 21c-3.6 0-6.5-2.6-6.5-6.2 0-3.9 3.4-5.3 3.4-9.3 2.6 1.4 4 3.5 4.1 5.6.9-.8 1.4-1.9 1.4-3 2.6 1.9 4.1 4.3 4.1 6.9 0 3.5-2.9 6-6.5 6z"/>',
  VIcons.shield: '<circle cx="12" cy="12" r="8.5"/><circle cx="12" cy="12" r="2.3"/><path d="M9 4.2v15.6M15 4.2v15.6"/>',
  VIcons.axe: '<path d="M6.5 21 15.5 6"/><path d="M13.2 4.6c2.6-1.6 5.6-1 6.8 1.1l-3.9 6.4c-2.1-.7-3.4-2.5-4-4.4"/>',
  VIcons.sword: '<path d="M19.5 4.5 9.2 14.8"/><path d="M19.5 4.5h-3.8M19.5 4.5v3.8"/><path d="M6.8 12.4l4.8 4.8M8.6 15.4l-4.1 4.1"/>',
  VIcons.cape: '<path d="M8.5 4h7l4 16.5c-4.5 1.5-10.5 1.5-15 0z"/><path d="M8.5 4c.5 2 1.8 3 3.5 3s3-1 3.5-3"/>',
  VIcons.raven: '<path d="M3.5 15c3 0 5-1.8 6-4.5.9-2.6 2.9-4.5 5.4-4.5 1.6 0 2.7.8 3.2 2l2.4.6-2.3 1c0 4.6-3.6 8.4-8.6 8.4l-3 2.5.4-3c-1.5-.5-2.7-1.3-3.5-2.5z"/><path d="M15.4 8.4h.01"/>',
  VIcons.frame: '<rect x="4" y="4" width="16" height="16" rx="1.5"/><rect x="7.5" y="7.5" width="9" height="9"/><path d="M4 4l3.5 3.5M20 4l-3.5 3.5M4 20l3.5-3.5M20 20l-3.5-3.5"/>',
  VIcons.key: '<circle cx="8" cy="15" r="4"/><path d="M11 12 20 3M16.5 6.5 19 9M14 9l2 2"/>',
  VIcons.share: '<path d="M12 15V4M8 7.5l4-4 4 4"/><path d="M5.5 12v6.5a2 2 0 0 0 2 2h9a2 2 0 0 0 2-2V12"/>',
  VIcons.info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5.5M12 7.8v.2"/>',
  VIcons.mail: '<rect x="3.5" y="5.5" width="17" height="13" rx="2"/><path d="M4 7l8 6 8-6"/>',
  VIcons.user: '<circle cx="12" cy="8.5" r="3.8"/><path d="M4.5 20c.8-3.8 3.8-6 7.5-6s6.7 2.2 7.5 6"/>',
  VIcons.arrowUp: '<path d="M12 19V5M6.5 10.5 12 5l5.5 5.5"/>',
  VIcons.hourglass: '<path d="M7 3.5h10M7 20.5h10M8 3.5c0 4 4 5 4 8.5s-4 4.5-4 8.5M16 3.5c0 4-4 5-4 8.5s4 4.5 4 8.5"/>',
  VIcons.euro: '<path d="M17.5 6.5a6.5 6.5 0 1 0 0 11"/><path d="M4.5 10.5h8M4.5 13.5h8"/>',
  VIcons.note: '<path d="M5 4.5h10l4 4v11H5z"/><path d="M8.5 11h7M8.5 14.5h5"/>',
  VIcons.logout: '<path d="M14 4.5H6.5a2 2 0 0 0-2 2v11a2 2 0 0 0 2 2H14"/><path d="M10 12h10M16.5 8.5 20 12l-3.5 3.5"/>',
  VIcons.trash: '<path d="M4.5 6.5h15M9.5 6.5v-2h5v2M6.5 6.5l1 13h9l1-13"/>',
  VIcons.download: '<path d="M12 4v11M7.5 10.5 12 15l4.5-4.5"/><path d="M5 19.5h14"/>',
  VIcons.globe: '<circle cx="12" cy="12" r="8.5"/><path d="M3.5 12h17M12 3.5c2.5 2.5 3.5 5.3 3.5 8.5s-1 6-3.5 8.5c-2.5-2.5-3.5-5.3-3.5-8.5s1-6 3.5-8.5z"/>',
  VIcons.eye: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
  VIcons.doc: '<path d="M6 3.5h8l4 4v13H6z"/><path d="M14 3.5v4h4"/>',
  VIcons.search: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
  VIcons.map: '<path d="M3.5 6.5l5-2 7 2.5 5-2v13l-5 2-7-2.5-5 2z"/><path d="M8.5 4.5v13M15.5 7v13"/>',
  VIcons.star: '<path d="M12 3.5l2.6 5.4 5.9.8-4.3 4.1 1 5.8L12 16.8l-5.2 2.8 1-5.8-4.3-4.1 5.9-.8z"/>',
  VIcons.drum: '<ellipse cx="12" cy="7" rx="7.5" ry="3"/><path d="M4.5 7v10c0 1.7 3.4 3 7.5 3s7.5-1.3 7.5-3V7"/><path d="M4.5 7 8 19M19.5 7 16 19M12 10v10"/>',
  VIcons.torch: '<path d="M10 11h4l-1 10h-2z"/><path d="M12 3c-2 2-3 3.5-3 5a3 3 0 0 0 6 0c0-1.5-1-3-3-5z"/>',
  VIcons.shirt: '<path d="M8 4 3.5 6.5l1.5 4 2-.8V20h10V9.7l2 .8 1.5-4L16 4c-.5 1.5-2 2.5-4 2.5S8.5 5.5 8 4z"/>',
  VIcons.percent: '<path d="M18 6 6 18"/><circle cx="7.5" cy="7.5" r="2.5"/><circle cx="16.5" cy="16.5" r="2.5"/>',
  VIcons.music: '<path d="M9 18V5.5l10-2V16"/><circle cx="6.5" cy="18" r="2.5"/><circle cx="16.5" cy="16" r="2.5"/>',
  VIcons.sticker: '<path d="M20 12a8 8 0 1 1-8-8h8z"/><path d="M20 12h-5a3 3 0 0 1-3-3V4"/>',
  VIcons.plus: '<path d="M12 5v14M5 12h14"/>',
  VIcons.dots: '<circle cx="6" cy="12" r="1"/><circle cx="12" cy="12" r="1"/><circle cx="18" cy="12" r="1"/>',
  VIcons.flag: '<path d="M5.5 21V4"/><path d="M5.5 4.5h12l-2.5 4 2.5 4h-12"/>',
  VIcons.sparkle: '<path d="M12 3.5c.6 4.2 2.3 5.9 6.5 6.5-4.2.6-5.9 2.3-6.5 6.5-.6-4.2-2.3-5.9-6.5-6.5 4.2-.6 5.9-2.3 6.5-6.5z"/><path d="M18.5 16.5c.2 1.5.8 2.1 2.3 2.3-1.5.2-2.1.8-2.3 2.3-.2-1.5-.8-2.1-2.3-2.3 1.5-.2 2.1-.8 2.3-2.3z"/>',
  VIcons.route: '<circle cx="6" cy="18" r="2.2"/><circle cx="18" cy="6" r="2.2"/><path d="M8 18h7.5a3.5 3.5 0 0 0 0-7h-7a3.5 3.5 0 0 1 0-7H16"/>',
  VIcons.apple: '<path d="M15.6 3.5c.1 1.3-.4 2.4-1.2 3.2-.8.8-1.8 1.3-2.9 1.2-.1-1.2.4-2.4 1.2-3.1.8-.8 1.9-1.3 2.9-1.3z"/><path d="M19 16.4c-.5 1.1-.8 1.6-1.4 2.6-.9 1.3-2.1 3-3.7 3-1.4 0-1.7-.9-3.6-.9s-2.3.9-3.6.9c-1.5 0-2.6-1.5-3.5-2.8C1.9 16.1 1.6 11.9 3 9.7c1-1.6 2.6-2.5 4.1-2.5s2.5.9 3.8.9c1.2 0 2-.9 3.8-.9 1.3 0 2.8.7 3.8 2-3.3 1.8-2.8 6.6.5 7.2z"/>',
};

class VIcon extends StatelessWidget {
  const VIcon(this.icon, {super.key, this.size = 24, this.color, this.stroke = 1.75});
  final VIcons icon;
  final double size;
  final Color? color;
  final double stroke;

  static String _hex(Color c) => '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

  @override
  Widget build(BuildContext context) {
    final c = color ?? IconTheme.of(context).color ?? const Color(0xFFEDE3D0);
    final svg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="${_hex(c)}" stroke-opacity="${c.a.toStringAsFixed(3)}" '
        'stroke-width="$stroke" stroke-linecap="round" stroke-linejoin="round">${_paths[icon]}</svg>';
    return SvgPicture.string(svg, width: size, height: size, excludeFromSemantics: true);
  }
}

/// Maps achievement icon keys from the database onto the icon set.
VIcons achievementVIcon(String key) => switch (key) {
      'horn' => VIcons.horn,
      'shield' => VIcons.shield,
      'axe' => VIcons.axe,
      'sword' => VIcons.sword,
      'crown' => VIcons.crown,
      'ship' => VIcons.ship,
      'drum' => VIcons.drum,
      'rune' => VIcons.rune,
      'chest' => VIcons.beute,
      'helm' => VIcons.held,
      'star' => VIcons.star,
      'map' => VIcons.map,
      _ => VIcons.star,
    };
