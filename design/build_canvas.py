#!/usr/bin/env python3
"""Generates the Valhalla Hero design canvas artboards (.dc.html) + canvas.json.

Run:  python3 design/build_canvas.py
Output goes to design/canvas/. Re-seed with the design helper afterwards.
"""
import json
import os
import urllib.parse

OUT = os.path.join(os.path.dirname(__file__), 'canvas')
os.makedirs(OUT, exist_ok=True)

# ----------------------------------------------------------------- tokens
T = {
    'bg': '#0C0B0A', 's1': '#151311', 's2': '#1D1A17', 's3': '#282420',
    'line': '#2F2A25', 'line2': '#453E36',
    'text': '#EFE7D8', 'text2': '#AFA393', 'muted': '#756B5E',
    'ember': '#E0A045', 'ember2': '#F4BF63', 'emberdim': 'rgba(224,160,69,0.14)',
    'frost': '#8FB8CF', 'moss': '#7FB58A', 'blood': '#C4573F',
}
LEVEL_COLORS = {1: '#8C8377', 2: '#A39A8B', 3: '#7FA894', 4: '#7CA2BF', 5: '#C4573F', 6: '#9C7CC9', 7: '#E0A045', 8: '#F4BF63'}
ROMAN = {1: 'I', 2: 'II', 3: 'III', 4: 'IV', 5: 'V', 6: 'VI', 7: 'VII', 8: 'VIII'}
LEVELS = {1: 'Thrall', 2: 'Karl', 3: 'Drengr', 4: 'Huskarl', 5: 'Berserker', 6: 'Jarl', 7: 'Konungr', 8: 'Einherjar'}

NOISE = urllib.parse.quote(
    '<svg xmlns="http://www.w3.org/2000/svg" width="140" height="140"><filter id="n"><feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" stitchTiles="stitch"/><feColorMatrix values="0 0 0 0 1 0 0 0 0 0.95 0 0 0 0 0.85 0 0 0 0.06 0"/></filter><rect width="140" height="140" filter="url(#n)"/></svg>')

FONTS = '<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cinzel:wght@500;600;700&amp;family=Manrope:wght@400;500;600;700;800&amp;display=swap">'

CSS = f"""
    body {{ margin: 0; background: {T['bg']}; color: {T['text']}; font-family: Manrope, 'Segoe UI', system-ui, sans-serif; -webkit-font-smoothing: antialiased; }}
    a {{ color: {T['ember']}; text-decoration: none; }} a:hover {{ color: {T['ember2']}; }}
    * {{ box-sizing: border-box; }}
    .phone {{ position: relative; width: 390px; height: 844px; overflow: hidden; background: {T['bg']}; background-image: url("data:image/svg+xml,{NOISE}"); }}
    .display {{ font-family: Cinzel, 'Times New Roman', serif; font-weight: 700; letter-spacing: 0.06em; }}
    .eyebrow {{ font-size: 11px; font-weight: 700; letter-spacing: 0.18em; text-transform: uppercase; color: {T['muted']}; }}
    .h1 {{ font-family: Cinzel, 'Times New Roman', serif; font-weight: 700; font-size: 24px; letter-spacing: 0.06em; color: {T['text']}; line-height: 1.1; }}
    .h2 {{ font-size: 18px; font-weight: 800; letter-spacing: -0.01em; }}
    .body {{ font-size: 14px; line-height: 1.45; color: {T['text']}; }}
    .sub {{ font-size: 13px; line-height: 1.4; color: {T['text2']}; }}
    .cap {{ font-size: 11.5px; color: {T['muted']}; }}
    .num {{ font-family: Cinzel, 'Times New Roman', serif; font-weight: 600; letter-spacing: 0.04em; font-variant-numeric: tabular-nums; }}
    .card {{ background: {T['s1']}; border: 1px solid {T['line']}; border-radius: 12px; }}
    .card2 {{ background: {T['s2']}; border: 1px solid {T['line']}; border-radius: 12px; }}
    .btn {{ display: flex; align-items: center; justify-content: center; gap: 10px; height: 52px; padding: 0 20px; border-radius: 8px; font-weight: 800; font-size: 15px; letter-spacing: 0.01em; }}
    .btn-primary {{ background: linear-gradient(180deg, {T['ember2']}, {T['ember']}); color: #1A1308; box-shadow: 0 1px 0 rgba(255,255,255,0.25) inset, 0 8px 24px -10px rgba(224,160,69,0.6); }}
    .btn-secondary {{ background: transparent; color: {T['text']}; border: 1px solid {T['line2']}; }}
    .btn-ghost {{ background: transparent; color: {T['ember']}; height: 44px; }}
    .btn-danger {{ background: {T['blood']}; color: {T['text']}; }}
    .btn-sm {{ height: 44px; font-size: 13.5px; padding: 0 14px; }}
    .input {{ display: flex; align-items: center; height: 52px; padding: 0 16px; background: {T['s2']}; border: 1px solid {T['line']}; border-radius: 8px; color: {T['text']}; font-size: 15px; }}
    .input .lbl {{ position: absolute; top: -8px; left: 12px; padding: 0 5px; background: {T['s2']}; font-size: 11px; letter-spacing: 0.08em; text-transform: uppercase; color: {T['muted']}; font-weight: 700; }}
    .field {{ position: relative; }}
    .input.focus {{ border-color: {T['ember']}; box-shadow: 0 0 0 3px {T['emberdim']}; }}
    .pill {{ display: inline-flex; align-items: center; gap: 6px; height: 26px; padding: 0 10px; border-radius: 6px; font-size: 12px; font-weight: 700; letter-spacing: 0.02em; }}
    .pill-coin {{ background: {T['emberdim']}; color: {T['ember2']}; border: 1px solid rgba(224,160,69,0.35); font-family: Cinzel, serif; letter-spacing: 0.05em; }}
    .pill-ok {{ background: rgba(127,181,138,0.14); color: {T['moss']}; border: 1px solid rgba(127,181,138,0.4); }}
    .pill-off {{ background: rgba(117,107,94,0.14); color: {T['text2']}; border: 1px solid {T['line2']}; }}
    .pill-danger {{ background: rgba(196,87,63,0.14); color: #E27A63; border: 1px solid rgba(196,87,63,0.4); }}
    .pill-frost {{ background: rgba(143,184,207,0.12); color: {T['frost']}; border: 1px solid rgba(143,184,207,0.35); }}
    .level {{ display: inline-flex; align-items: center; gap: 8px; height: 28px; padding: 0 10px 0 8px; border-radius: 6px; border: 1px solid; font-family: Cinzel, serif; font-weight: 700; font-size: 12px; letter-spacing: 0.1em; }}
    .ic {{ width: 22px; height: 22px; flex: none; }}
    .ic-sm {{ width: 18px; height: 18px; }}
    .nav {{ position: absolute; left: 0; right: 0; bottom: 0; height: 84px; padding: 8px 6px 22px; display: flex; justify-content: space-around; align-items: flex-start; background: rgba(12,11,10,0.94); border-top: 1px solid {T['line']}; backdrop-filter: blur(12px); }}
    .nav-item {{ display: flex; flex-direction: column; align-items: center; gap: 4px; width: 62px; color: {T['muted']}; font-size: 10.5px; font-weight: 700; letter-spacing: 0.04em; }}
    .nav-item.on {{ color: {T['ember']}; }}
    .nav-item.on .ic {{ filter: drop-shadow(0 0 6px rgba(224,160,69,0.6)); }}
    .rune {{ display: flex; align-items: center; gap: 8px; color: {T['line2']}; }}
    .rune::before, .rune::after {{ content: ""; flex: 1; height: 1px; background: linear-gradient(90deg, transparent, {T['line2']}); }}
    .rune::after {{ background: linear-gradient(90deg, {T['line2']}, transparent); }}
    .row {{ display: flex; align-items: center; gap: 14px; padding: 14px 16px; }}
    .row + .row {{ border-top: 1px solid {T['line']}; }}
    .xp {{ position: relative; height: 6px; border-radius: 3px; background: {T['s3']}; overflow: hidden; }}
    .xp > div {{ height: 100%; border-radius: 3px; background: linear-gradient(90deg, {T['ember']}, {T['ember2']}); box-shadow: 0 0 12px rgba(224,160,69,0.6); }}
    .ticks {{ display: flex; justify-content: space-between; margin-top: 4px; }}
    .ticks i {{ display: block; width: 1px; height: 4px; background: {T['line2']}; }}
    .tab {{ flex: 1; text-align: center; padding: 15px 0 13px; font-size: 14px; font-weight: 700; color: {T['muted']}; border-bottom: 2px solid transparent; }}
    .tab.on {{ color: {T['ember']}; border-bottom-color: {T['ember']}; }}
    .chip {{ display: inline-flex; align-items: center; gap: 6px; height: 44px; padding: 0 14px; border-radius: 8px; border: 1px solid {T['line2']}; color: {T['text2']}; font-size: 13px; font-weight: 700; }}
    .chip.on {{ background: {T['emberdim']}; border-color: {T['ember']}; color: {T['ember2']}; }}
    .seg {{ display: flex; padding: 3px; background: {T['s2']}; border: 1px solid {T['line']}; border-radius: 8px; }}
    .seg > div {{ flex: 1; text-align: center; padding: 12px 0; border-radius: 6px; font-size: 13px; font-weight: 700; color: {T['text2']}; }}
    .seg > div.on {{ background: {T['s3']}; color: {T['text']}; box-shadow: 0 1px 0 rgba(255,255,255,0.05) inset; }}
    .toggle {{ width: 44px; height: 26px; border-radius: 13px; background: {T['s3']}; border: 1px solid {T['line2']}; position: relative; flex: none; }}
    .toggle::after {{ content: ""; position: absolute; top: 3px; left: 3px; width: 18px; height: 18px; border-radius: 50%; background: {T['text2']}; }}
    .toggle.on {{ background: {T['ember']}; border-color: {T['ember']}; }}
    .toggle.on::after {{ left: 21px; background: #1A1308; }}
    .medal {{ width: 44px; height: 44px; border-radius: 10px; display: flex; align-items: center; justify-content: center; flex: none; }}
    .medal.on {{ background: {T['emberdim']}; border: 1px solid rgba(224,160,69,0.45); color: {T['ember2']}; }}
    .medal.off {{ background: {T['s2']}; border: 1px solid {T['line']}; color: {T['muted']}; }}
    .glow {{ background: radial-gradient(60% 50% at 50% 35%, rgba(224,160,69,0.22), transparent 70%); }}
    .rarity {{ display: inline-flex; align-items: center; gap: 5px; font-size: 11px; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; }}
    .rarity i {{ display: block; width: 7px; height: 7px; transform: rotate(45deg); }}
    .divider {{ height: 1px; background: {T['line']}; }}
"""

# ----------------------------------------------------------------- icons
def icon(name, size=22, cls='ic', extra=''):
    paths = {
        'shield': '<path d="M12 3l7 3v5c0 5-3.5 8.5-7 10-3.5-1.5-7-5-7-10V6l7-3z"/>',
        'book': '<path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v15H6.5A2.5 2.5 0 0 0 4 20.5z"/><path d="M4 20.5V5.5M8 7h8M8 11h6"/>',
        'chest': '<rect x="3" y="8" width="18" height="12" rx="2"/><path d="M3 12h18M12 12v3M7 8V5.5A2.5 2.5 0 0 1 9.5 3h5A2.5 2.5 0 0 1 17 5.5V8"/>',
        'rank': '<path d="M4 20V11M12 20V4M20 20v-7"/><path d="M3 20h18"/>',
        'user': '<circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 3.6-7 8-7s8 3 8 7"/>',
        'badge': '<rect x="3" y="4" width="18" height="16" rx="2"/><circle cx="9" cy="11" r="2"/><path d="M6 17c0-1.7 1.3-3 3-3s3 1.3 3 3M14 9h4M14 13h4"/>',
        'bell': '<path d="M6 16V11a6 6 0 0 1 12 0v5l2 2H4l2-2z"/><path d="M10 20a2 2 0 0 0 4 0"/>',
        'gear': '<circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.7 1.7 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.7 1.7 0 0 0-1.8-.3 1.7 1.7 0 0 0-1 1.5V21a2 2 0 1 1-4 0v-.1a1.7 1.7 0 0 0-1.1-1.5 1.7 1.7 0 0 0-1.8.3l-.1.1a2 2 0 1 1-2.8-2.8l.1-.1a1.7 1.7 0 0 0 .3-1.8 1.7 1.7 0 0 0-1.5-1H3a2 2 0 1 1 0-4h.1a1.7 1.7 0 0 0 1.5-1.1 1.7 1.7 0 0 0-.3-1.8l-.1-.1a2 2 0 1 1 2.8-2.8l.1.1a1.7 1.7 0 0 0 1.8.3H9a1.7 1.7 0 0 0 1-1.5V3a2 2 0 1 1 4 0v.1a1.7 1.7 0 0 0 1 1.5 1.7 1.7 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.7 1.7 0 0 0-.3 1.8V9a1.7 1.7 0 0 0 1.5 1H21a2 2 0 1 1 0 4h-.1a1.7 1.7 0 0 0-1.5 1z"/>',
        'ticket': '<path d="M3 9V7a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v2a2 2 0 0 0 0 6v2a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-2a2 2 0 0 0 0-6z"/><path d="M13 5v14" stroke-dasharray="2 3"/>',
        'receipt': '<path d="M6 3h12v18l-2-1.5L14 21l-2-1.5L10 21l-2-1.5L6 21z"/><path d="M9 8h6M9 12h6M9 16h4"/>',
        'check': '<path d="M5 12.5l4.5 4.5L19 7.5"/>',
        'x': '<path d="M6 6l12 12M18 6L6 18"/>',
        'search': '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
        'ship': '<path d="M3 15h18l-2 4H5l-2-4z"/><path d="M12 15V4l6 9H6"/><path d="M12 4l-4.5 7"/>',
        'coin': '<circle cx="12" cy="12" r="8"/><path d="M12 8v8M9.5 10.5c0-1 1-1.5 2.5-1.5s2.5.5 2.5 1.5-1 1.5-2.5 1.5-2.5.5-2.5 1.5 1 1.5 2.5 1.5 2.5-.5 2.5-1.5"/>',
        'chev': '<path d="M9 6l6 6-6 6"/>',
        'back': '<path d="M15 6l-6 6 6 6"/>',
        'heart': '<path d="M12 20s-7-4.5-7-10a4 4 0 0 1 7-2.5A4 4 0 0 1 19 10c0 5.5-7 10-7 10z"/>',
        'heartf': '<path d="M12 20s-7-4.5-7-10a4 4 0 0 1 7-2.5A4 4 0 0 1 19 10c0 5.5-7 10-7 10z" fill="currentColor"/>',
        'cal': '<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18M8 3v4M16 3v4"/>',
        'plus': '<path d="M12 5v14M5 12h14"/>',
        'logout': '<path d="M10 4H6a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h4M15 8l4 4-4 4M19 12H9"/>',
        'flame': '<path d="M12 3c1 3 4 4.5 4 9a4 4 0 0 1-8 0c0-2 1-3 1-3s.5 2 2 2c0-3 1-5 1-8z"/>',
        'horn': '<path d="M4 6c6 0 12 2 16 8l-3 3C13 12 8 10 4 10z"/><path d="M4 6v4"/>',
        'anchor': '<circle cx="12" cy="5" r="2"/><path d="M12 7v14M5 13a7 7 0 0 0 14 0M3 13h4M17 13h4"/>',
        'glass': '<path d="M6 3h12l-1 8a5 5 0 0 1-10 0z"/><path d="M12 16v5M8 21h8"/>',
        'shirt': '<path d="M8 4l4 2 4-2 4 3-2 3-2-1v11H8V9L6 10 4 7z"/>',
        'crown': '<path d="M4 18h16M4 18L3 8l5 4 4-6 4 6 5-4-1 10"/>',
        'map': '<path d="M3 6l6-2 6 2 6-2v14l-6 2-6-2-6 2z"/><path d="M9 4v14M15 6v14"/>',
        'rune': '<path d="M12 3v18M12 7l5 3M12 7L7 10M12 14l5 3M12 14l-5 3"/>',
        'clock': '<circle cx="12" cy="12" r="8"/><path d="M12 8v4l3 2"/>',
        'download': '<path d="M12 4v11M7 10l5 5 5-5M4 20h16"/>',
        'trash': '<path d="M4 7h16M9 7V4h6v3M6 7l1 13h10l1-13"/>',
        'sparkle': '<path d="M12 3l2 5 5 2-5 2-2 5-2-5-5-2 5-2z"/>',
        'helm': '<path d="M5 13a7 7 0 0 1 14 0v4H5z"/><path d="M12 6v11M5 13h14"/>',
        'axe': '<path d="M14 4l6 6-4 4-6-6z"/><path d="M12 10L4 18l2 2 8-8"/>',
        'wolf': '<path d="M4 7l4 3h8l4-3v6l-3 6H7L4 13z"/><path d="M9 13h.01M15 13h.01"/>',
        'frame': '<rect x="4" y="4" width="16" height="16" rx="2"/><rect x="8" y="8" width="8" height="8" rx="1"/>',
        'cape': '<path d="M8 4h8l3 16H5z"/><path d="M8 4c2 2 6 2 8 0"/>',
        'lock': '<rect x="5" y="11" width="14" height="10" rx="2"/><path d="M8 11V8a4 4 0 0 1 8 0v3"/>',
        'refresh': '<path d="M20 12a8 8 0 1 1-2.3-5.7"/><path d="M20 4v5h-5"/>',
        'share': '<path d="M12 3v12M8 7l4-4 4 4M5 13v6a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-6"/>',
        'globe': '<circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c3 3 3 15 0 18M12 3c-3 3-3 15 0 18"/>',
        'eye': '<path d="M2 12s4-7 10-7 10 7 10 7-4 7-10 7S2 12 2 12z"/><circle cx="12" cy="12" r="3"/>',
        'google': '<path d="M20 12.2c0-.6-.1-1.2-.2-1.7H12v3.3h4.5a3.9 3.9 0 0 1-1.7 2.5v2.1h2.7c1.6-1.5 2.5-3.6 2.5-6.2z" fill="currentColor" stroke="none"/><path d="M12 20c2.2 0 4-.7 5.4-2l-2.7-2.1c-.7.5-1.7.8-2.7.8-2.1 0-3.9-1.4-4.5-3.3H4.7v2.1A8 8 0 0 0 12 20z" fill="currentColor" stroke="none" opacity=".8"/><path d="M7.5 13.4a4.8 4.8 0 0 1 0-3V8.3H4.7a8 8 0 0 0 0 7.2z" fill="currentColor" stroke="none" opacity=".6"/><path d="M12 7.2c1.2 0 2.3.4 3.1 1.2l2.3-2.3A8 8 0 0 0 4.7 8.3l2.8 2.1C8.1 8.6 9.9 7.2 12 7.2z" fill="currentColor" stroke="none" opacity=".9"/>',
        'apple': '<path d="M16.5 12.8c0-2.4 2-3.5 2-3.6-1.1-1.6-2.8-1.8-3.4-1.8-1.5-.2-2.8.8-3.6.8-.7 0-1.9-.8-3.1-.8-1.6 0-3.1.9-3.9 2.4-1.7 2.9-.4 7.2 1.2 9.5.8 1.2 1.8 2.4 3 2.4 1.2 0 1.7-.8 3.1-.8 1.5 0 1.9.8 3.2.8 1.3 0 2.1-1.2 2.9-2.3.9-1.3 1.3-2.6 1.3-2.7-.1 0-2.7-1-2.7-3.9zM14.2 5.8c.6-.8 1.1-1.9 1-3-.9 0-2.1.6-2.8 1.4-.6.7-1.1 1.8-1 2.9 1 .1 2.1-.5 2.8-1.3z" fill="currentColor" stroke="none"/>',
    }
    return (f'<svg class="{cls}" style="width:{size}px;height:{size}px" viewBox="0 0 24 24" fill="none" stroke="currentColor" '
            f'stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round" {extra}>{paths[name]}</svg>')


def hero_bust(level, size=120, gear=()):
    """Stylised bust silhouette placeholder for the final Midjourney art."""
    c = LEVEL_COLORS[level]
    horns = ('<path d="M34 46C24 40 20 28 24 16c4 8 10 14 16 18z" fill="#E8DFCC" opacity=".9"/>'
             '<path d="M86 46c10-6 14-18 10-30-4 8-10 14-16 18z" fill="#E8DFCC" opacity=".9"/>') if 'horns' in gear else ''
    crown = '<path d="M38 40l6-16 8 10 8-14 8 14 8-10 6 16z" fill="#F4BF63"/>' if 'crown' in gear else ''
    hood = '<path d="M28 62c0-22 12-38 32-38s32 16 32 38v10H28z" fill="#1D1A17" stroke="#8FB8CF" stroke-width="2"/>' if 'hood' in gear else ''
    return f'''<svg viewBox="0 0 120 140" style="width:{size}px;height:{int(size*140/120)}px;flex:none">
<defs><radialGradient id="g{level}" cx="50%" cy="45%" r="55%"><stop offset="0" stop-color="{c}" stop-opacity=".38"/><stop offset="1" stop-color="{c}" stop-opacity="0"/></radialGradient></defs>
<circle cx="60" cy="66" r="62" fill="url(#g{level})"/>
{hood}
<path d="M22 140c0-26 16-42 38-42s38 16 38 42z" fill="{c}"/>
<path d="M22 140c0-26 16-42 38-42v42z" fill="#0C0B0A" opacity=".18"/>
<path d="M60 22c-18 0-28 14-28 32v12c0 16 12 28 28 28s28-12 28-28V54c0-18-10-32-28-32z" fill="{c}"/>
<path d="M32 60h56" stroke="#0C0B0A" stroke-width="3" opacity=".45"/>
<path d="M44 78c4 5 10 7 16 7s12-2 16-7" stroke="#0C0B0A" stroke-width="3" opacity=".35" fill="none"/>
{horns}{crown}
</svg>'''


def page(body, w=390, h=844, extra_css=''):
    return f'''<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <script src="./support.js"></script>
</head>
<body>
<x-dc>
<helmet>
  {FONTS}
  <style>{extra_css}{CSS}</style>
</helmet>
{body}
</x-dc>
</body>
</html>
'''


# ------------------------------------------------------------ fragments
def nav(active, staff=False):
    items = [('shield', 'Halle', 'halle'), ('book', 'Saga', 'saga'), ('chest', 'Beute', 'beute'), ('rank', 'Rangliste', 'rang'), ('user', 'Profil', 'profil')]
    if staff:
        items.append(('badge', 'Team', 'team'))
    out = []
    for ic, label, key in items:
        on = ' on' if key == active else ''
        badge = '<span style="position:absolute;top:-4px;right:12px;min-width:16px;height:16px;padding:0 4px;border-radius:8px;background:#C4573F;color:#EFE7D8;font-size:10px;font-weight:800;display:flex;align-items:center;justify-content:center">1</span>' if key == 'team' and active != 'team' else ''
        out.append(f'<div class="nav-item{on}" style="position:relative">{icon(ic)}<span>{label}</span>{badge}</div>')
    return f'<div class="nav">{"".join(out)}</div>'


def header(title, right='', back=False):
    left = f'<div style="width:44px;height:44px;display:flex;align-items:center;justify-content:center;color:{T["text2"]}">{icon("back")}</div>' if back else ''
    return f'''<div style="display:flex;align-items:center;gap:8px;padding:58px 16px 12px 20px;min-height:110px">
  {left}<div class="h1" style="flex:1">{title}</div>{right}
</div>'''


def icon_btn(name, badge=None):
    b = f'<span style="position:absolute;top:2px;right:2px;min-width:18px;height:18px;padding:0 5px;border-radius:9px;background:{T["blood"]};color:{T["text"]};font-size:10.5px;font-weight:800;display:flex;align-items:center;justify-content:center">{badge}</span>' if badge else ''
    return f'<div style="position:relative;width:44px;height:44px;display:flex;align-items:center;justify-content:center;border-radius:10px;border:1px solid {T["line"]};background:{T["s1"]};color:{T["text2"]}">{icon(name)}{b}</div>'


def level_badge(level, small=False):
    c = LEVEL_COLORS[level]
    return f'<span class="level" style="color:{c};border-color:{c}66;background:{c}1F;{"height:24px;font-size:11px" if small else ""}"><span>{ROMAN[level]}</span><span style="opacity:.55">·</span><span>{LEVELS[level]}</span></span>'


def fmt(n):
    return f'{n:,}'.replace(',', '\u202f') if isinstance(n, int) else n

def coin_pill(n, big=False):
    n = fmt(n)
    return f'<span class="pill pill-coin" style="{"height:34px;padding:0 14px;font-size:15px" if big else ""}">{icon("coin", 18 if big else 14, "ic-sm")}{n}</span>'


def section(title, action=None):
    a = f'<span style="color:{T["ember"]};font-size:12px;font-weight:700">{action}</span>' if action else ''
    return f'<div style="display:flex;align-items:center;justify-content:space-between;padding:24px 20px 10px"><span class="eyebrow">{title}</span>{a}</div>'


def rune_divider(text=''):
    inner = f'<span class="cap" style="letter-spacing:.14em;text-transform:uppercase">{text}</span>' if text else icon('rune', 14, 'ic-sm')
    return f'<div class="rune" style="padding:0 20px">{inner}</div>'


# ================================================================ SCREENS
screens = {}

# ---- Login
screens['Login'] = page(f'''
<div class="phone">
  <div style="position:absolute;inset:0;background:radial-gradient(70% 40% at 50% 0%, rgba(224,160,69,0.18), transparent 70%)"></div>
  <div style="position:relative;padding:96px 24px 0;display:flex;flex-direction:column;gap:0">
    <div style="display:flex;align-items:center;gap:14px">
      <div style="width:44px;height:44px;border-radius:10px;background:{T['emberdim']};border:1px solid rgba(224,160,69,.4);display:flex;align-items:center;justify-content:center;color:{T['ember2']}">{icon('shield',26)}</div>
      <div>
        <div class="display" style="font-size:22px;color:{T['ember2']};letter-spacing:.14em">VALHALLA</div>
        <div class="eyebrow" style="color:{T['text2']};margin-top:2px">Hero · Treueprogramm</div>
      </div>
    </div>
    <div class="sub" style="margin-top:22px;max-width:320px">Besuche sammeln, Held aufsteigen lassen, Beute holen. Nur für Gäste ab 18 Jahren.</div>
    <div style="display:flex;flex-direction:column;gap:14px;margin-top:36px">
      <div class="field"><div class="input"><span class="lbl">E-Mail</span>ragnar@lothbrok.de</div></div>
      <div class="field"><div class="input"><span class="lbl">Passwort</span><span style="letter-spacing:.3em">••••••••••</span></div></div>
    </div>
    <div class="btn btn-primary" style="margin-top:20px">Anmelden</div>
    <div style="margin:22px 0">{rune_divider('oder')}</div>
    <div style="display:flex;flex-direction:column;gap:10px">
      <div class="btn btn-secondary">{icon('google',20)}Mit Google fortfahren</div>
      <div class="btn btn-secondary">{icon('apple',20)}Mit Apple fortfahren</div>
    </div>
    <div style="display:flex;justify-content:center;gap:6px;margin-top:28px" class="sub">Noch kein Konto? <a style="font-weight:800">Registrieren</a></div>
  </div>
</div>''')

# ---- Sign up
screens['Registrieren'] = page(f'''
<div class="phone">
  {header('Konto erstellen', back=True)}
  <div style="padding:0 24px;display:flex;flex-direction:column;gap:14px">
    <div class="sub" style="margin-bottom:6px">Der Nickname steht in der Rangliste. Dein echter Name bleibt privat.</div>
    <div class="field"><div class="input focus"><span class="lbl">Nickname</span>Ragnar</div></div>
    <div class="field"><div class="input"><span class="lbl">E-Mail</span><span style="color:{T['muted']}">du@beispiel.de</span></div></div>
    <div class="field"><div class="input"><span class="lbl">Passwort</span><span style="color:{T['muted']}">mindestens 8 Zeichen</span></div></div>
    <div class="field"><div class="input" style="justify-content:space-between"><span class="lbl">Geburtsdatum</span><span>22. Nov. 1996</span>{icon('cal',20,'ic-sm')}</div></div>
    <div style="display:flex;gap:8px;align-items:center" class="cap">{icon('lock',14,'ic-sm')}Ab 18 Jahren. Wir speichern nur das Datum, keine Ausweise.</div>
    <div class="divider" style="margin:6px 0"></div>
    <div style="display:flex;gap:12px;align-items:flex-start">
      <div style="width:22px;height:22px;border-radius:6px;background:{T['ember']};display:flex;align-items:center;justify-content:center;color:#1A1308;flex:none">{icon('check',16,'ic-sm')}</div>
      <div class="sub" style="color:{T['text']}">Ich akzeptiere die <a>Teilnahmebedingungen</a> und habe die <a>Datenschutzerklärung</a> gelesen.</div>
    </div>
    <div style="display:flex;gap:12px;align-items:flex-start">
      <div style="width:22px;height:22px;border-radius:6px;border:1px solid {T['line2']};flex:none"></div>
      <div class="sub">Push-Nachrichten zu Aktionen und Events <span class="cap">(optional)</span></div>
    </div>
    <div style="display:flex;gap:12px;align-items:flex-start">
      <div style="width:22px;height:22px;border-radius:6px;border:1px solid {T['line2']};flex:none"></div>
      <div class="sub">Personalisierte Angebote auf Basis meiner Besuche <span class="cap">(optional)</span></div>
    </div>
    <div class="btn btn-primary" style="margin-top:10px">Konto erstellen</div>
    <div class="cap" style="text-align:center">Optionale Einwilligungen kannst du jederzeit in den Einstellungen widerrufen.</div>
  </div>
</div>''')

# ---- Home (Main)
def stat_tile(ic, value, label, color):
    return f'''<div class="card" style="flex:1;padding:14px 12px;display:flex;flex-direction:column;align-items:center;gap:6px">
  <span style="color:{color}">{icon(ic,20)}</span>
  <span class="num" style="font-size:22px">{value}</span>
  <span class="cap" style="letter-spacing:.06em;text-transform:uppercase;font-size:10px">{label}</span>
</div>'''

def achievement_tile(ic, name, on):
    cls = 'on' if on else 'off'
    return f'''<div style="width:96px;flex:none;display:flex;flex-direction:column;align-items:center;gap:8px">
  <div class="medal {cls}" style="width:56px;height:56px;border-radius:14px">{icon(ic,24)}</div>
  <div class="cap" style="text-align:center;color:{T['text'] if on else T['muted']};font-weight:600;line-height:1.2">{name}</div>
</div>'''

screens['Main'] = page(f'''
<div class="phone">
  <div style="position:absolute;inset:0 0 auto;height:420px;background:radial-gradient(80% 60% at 50% 0%, rgba(124,162,191,0.18), transparent 70%)"></div>
  <div style="position:relative">
  {header('Halle', icon_btn('bell', '3'))}
  <div style="padding:0 20px">
    <div class="card" style="padding:20px 20px 18px;position:relative;overflow:hidden">
      <div class="glow" style="position:absolute;inset:0"></div>
      <div style="position:relative;display:flex;gap:16px;align-items:center">
        <div style="flex:1;display:flex;flex-direction:column;gap:10px">
          <div class="display" style="font-size:26px;letter-spacing:.04em">Ragnar</div>
          {level_badge(4)}
          <div class="sub" style="font-style:italic">„Treu bis zum letzten Horn.“</div>
          <span class="pill pill-ok">{icon('ship',14,'ic-sm')}An Bord · 7 Wochen</span>
        </div>
        {hero_bust(4, 116, ('hood',))}
      </div>
      <div style="position:relative;margin-top:18px">
        <div class="xp"><div style="width:51%"></div></div>
        <div class="ticks"><i></i><i></i><i></i><i></i><i></i><i></i><i></i><i></i><i></i></div>
        <div style="display:flex;justify-content:space-between;margin-top:8px">
          <span class="num" style="font-size:13px;color:{T['ember2']}">1 105 XP</span>
          <span class="cap">Noch 395 XP bis <b style="color:{T['text2']}">Berserker</b></span>
        </div>
      </div>
    </div>
    <div style="display:flex;gap:10px;margin-top:12px">
      {stat_tile('coin','1 786','Münzen',T['ember'])}
      {stat_tile('glass','7','Besuche',T['frost'])}
      {stat_tile('flame','7','Wochen',T['moss'])}
    </div>
    <div class="btn btn-primary" style="margin-top:16px">{icon('receipt',20)}Besuch melden</div>
  </div>
  {section('Erfolge', 'Alle 16 ›')}
  <div style="display:flex;gap:6px;padding:0 20px;overflow:hidden">
    {achievement_tile('horn','Erster Schluck',True)}{achievement_tile('shield','Stammgast',True)}{achievement_tile('ship','An Bord',True)}{achievement_tile('axe','Hallen&shy;bewohner',False)}
  </div>
  {section('Letzte Aktivität')}
  <div class="card" style="margin:0 20px">
    <div class="row"><span style="color:{T['moss']}">{icon('check',20)}</span><div style="flex:1"><div class="body" style="font-weight:700">36,00 €</div><div class="cap">Di., 8. Sept. · Valhalla Bar</div></div><span class="pill pill-ok">+396</span></div>
  </div>
  </div>
  {nav('halle')}
</div>''')

# ---- Claim visit
screens['BesuchMelden'] = page(f'''
<div class="phone">
  {header('Besuch melden', back=True)}
  <div style="padding:0 24px;display:flex;flex-direction:column;gap:18px">
    <div class="sub">Gib den Rechnungsbetrag ein. Das Team bestätigt deinen Besuch, danach bekommst du XP und Münzen.</div>
    <div class="field"><div class="input" style="justify-content:space-between"><span class="lbl">Bar</span><span>Valhalla Bar · Berlin</span>{icon('chev',18,'ic-sm')}</div></div>
    <div class="card2" style="padding:22px 20px;display:flex;flex-direction:column;align-items:center;gap:6px;border-color:{T['ember']};box-shadow:0 0 0 3px {T['emberdim']}">
      <span class="eyebrow">Rechnungsbetrag</span>
      <div class="num" style="font-size:44px;color:{T['text']}">36<span style="color:{T['muted']}">,</span>00<span style="font-size:24px;color:{T['ember']};margin-left:6px">€</span></div>
      <div class="cap">≈ <b style="color:{T['ember2']}">396 Münzen</b> · +50 XP</div>
    </div>
    <div class="field"><div class="input"><span class="lbl">Notiz (optional)</span><span style="color:{T['muted']}">z. B. Tisch 4, Freitag</span></div></div>
    <div class="btn btn-primary">Absenden</div>
    <div style="display:flex;gap:8px;align-items:flex-start" class="cap">{icon('horn',16,'ic-sm')}Genieße verantwortungsvoll. Punkte gibt es für Besuche, nicht fürs Trinken.</div>
  </div>
</div>''')

# ---- Feed
def post(kind, venue, date, title, when, body, likes, liked):
    tag = (f'<span class="pill pill-danger" style="height:22px;font-size:10px;letter-spacing:.12em">EVENT</span>' if kind == 'event'
           else f'<span class="pill pill-frost" style="height:22px;font-size:10px;letter-spacing:.12em">NEWS</span>')
    whenrow = f'<div style="display:flex;align-items:center;gap:6px;color:{T["ember2"]};font-size:13px;font-weight:700">{icon("cal",16,"ic-sm")}{when}</div>' if when else ''
    hcolor = T['blood'] if liked else T['muted']
    return f'''<div class="card" style="overflow:hidden">
  <div style="height:118px;background:linear-gradient(135deg,{T['s3']},{T['s1']});display:flex;align-items:flex-end;padding:12px 16px;position:relative">
    <div style="position:absolute;inset:0;background:radial-gradient(60% 80% at 80% 20%, rgba(224,160,69,.2), transparent)"></div>
    <div style="position:relative;display:flex;gap:8px;align-items:center">{tag}<span class="cap">{venue}</span></div>
  </div>
  <div style="padding:14px 16px 8px;display:flex;flex-direction:column;gap:8px">
    <div class="h2">{title}</div>
    {whenrow}
    <div class="sub">{body}</div>
    <div style="display:flex;justify-content:space-between;align-items:center;margin-top:4px">
      <span class="cap">{date}</span>
      <span style="display:flex;align-items:center;gap:6px;color:{hcolor};font-weight:700;font-size:13px;height:44px;padding:0 8px">{icon('heartf' if liked else 'heart',20)}{likes}</span>
    </div>
  </div>
</div>'''

screens['Saga'] = page(f'''
<div class="phone">
  {header('Saga')}
  <div style="padding:0 20px;display:flex;flex-direction:column;gap:14px">
    {post('event','Valhalla Bar','7. Sept.','Met-Verkostung','Mo., 21. Sept. · 19:00','Sechs Sorten Met aus Skandinavien. Plätze begrenzt.',3,False)}
    {post('event','Valhalla Bar','6. Sept.','Skalden-Nacht: Live-Musik','Fr., 18. Sept. · 21:00','Die „Nordwind“ spielen akustisch. Eintritt frei für alle an Bord.',5,True)}
    {post('news','Alle Bars','4. Sept.','Neuer Hoodie im Shop','','Der schwere Runen-Hoodie ist da. 5 000 Münzen, nur 15 Stück.',5,True)}
  </div>
  {nav('saga')}
</div>''')

# ---- Shop rewards
def reward_card(ic, kind, name, price, note='', affordable=True):
    return f'''<div class="card" style="padding:14px;display:flex;flex-direction:column;gap:10px;opacity:{1 if affordable else .55}">
  <div style="height:96px;border-radius:8px;background:radial-gradient(70% 70% at 50% 40%, {T['s3']}, {T['s2']});display:flex;align-items:center;justify-content:center;color:{T['ember2']}">{icon(ic,40)}</div>
  <div><div class="eyebrow" style="font-size:10px">{kind}</div><div class="body" style="font-weight:700;margin-top:3px;line-height:1.25">{name}</div></div>
  <div style="display:flex;justify-content:space-between;align-items:center;margin-top:auto">{coin_pill(price)}<span class="cap">{note}</span></div>
</div>'''

screens['Beute'] = page(f'''
<div class="phone">
  {header('Beute', coin_pill('1 786', big=True) + icon_btn('ticket'))}
  <div style="display:flex;border-bottom:1px solid {T['line']};margin:0 20px"><div class="tab on">Belohnungen</div><div class="tab">Ausrüstung</div></div>
  <div style="padding:16px 20px;display:grid;grid-template-columns:repeat(2, minmax(0, 1fr));gap:12px">
    {reward_card('glass','Getränk','Ein Bier aufs Haus',300)}
    {reward_card('glass','Getränk','Signature Cocktail',600)}
    {reward_card('shirt','Merch','Valhalla T-Shirt',2500,'Noch 30')}
    {reward_card('sparkle','Merch','Emaille-Pin „Rabe“',900,'Noch 50')}
    {reward_card('cal','Reservierung','Vorrang-Reservierung',1200)}
    {reward_card('shirt','Merch','Runen-Hoodie',5000,'Noch 15',False)}
  </div>
  {nav('beute')}
</div>''')

# ---- Redeem dialog state
screens['BeuteEinloesen'] = page(f'''
<div class="phone">
  {header('Beute', coin_pill('1 486', big=True) + icon_btn('ticket'))}
  <div style="display:flex;border-bottom:1px solid {T['line']};margin:0 20px"><div class="tab on">Belohnungen</div><div class="tab">Ausrüstung</div></div>
  <div style="padding:16px 20px;display:grid;grid-template-columns:repeat(2, minmax(0, 1fr));gap:12px;filter:blur(2px);opacity:.5">
    {reward_card('glass','Getränk','Ein Bier aufs Haus',300)}
    {reward_card('glass','Getränk','Signature Cocktail',600)}
    {reward_card('shirt','Merch','Valhalla T-Shirt',2500,'Noch 30')}
    {reward_card('sparkle','Merch','Emaille-Pin „Rabe“',900,'Noch 50')}
  </div>
  <div style="position:absolute;inset:0;background:rgba(12,11,10,.7);display:flex;align-items:flex-end">
    <div style="width:100%;background:{T['s1']};border-top:1px solid {T['line2']};border-radius:20px 20px 0 0;padding:14px 24px 40px;display:flex;flex-direction:column;align-items:center;gap:14px">
      <div style="width:40px;height:4px;border-radius:2px;background:{T['line2']}"></div>
      <div class="glow" style="width:96px;height:96px;border-radius:50%;display:flex;align-items:center;justify-content:center;color:{T['ember2']};border:1px solid rgba(224,160,69,.35)">{icon('glass',44)}</div>
      <div class="h2" style="text-align:center">Eingelöst! Zeige diesen Code an der Theke.</div>
      <div class="display" style="font-size:40px;color:{T['ember2']};letter-spacing:.3em;padding:14px 22px;border:1px dashed rgba(224,160,69,.5);border-radius:10px;background:{T['emberdim']}">LBW7X5</div>
      <div class="cap">Ein Bier aufs Haus · Gültig bis 8. Okt. 2026</div>
      <div class="btn btn-secondary" style="width:100%">Schließen</div>
    </div>
  </div>
</div>''')

# ---- Gear
def gear_row(ic, name, rarity, slot, right):
    rc = {'Gewöhnlich': T['text2'], 'Selten': T['frost'], 'Legendär': T['ember2']}[rarity]
    return f'''<div class="row" style="padding:12px 16px">
  <div style="width:52px;height:52px;border-radius:10px;background:{T['s2']};border:1px solid {T['line']};display:flex;align-items:center;justify-content:center;color:{rc}">{icon(ic,26)}</div>
  <div style="flex:1"><div class="body" style="font-weight:700">{name}</div><div style="display:flex;gap:10px;margin-top:3px"><span class="rarity" style="color:{rc}"><i style="background:{rc}"></i>{rarity}</span><span class="cap">{slot}</span></div></div>
  {right}
</div>'''

owned = f'<span class="pill pill-ok">{icon("check",14,"ic-sm")}Im Besitz</span>'
locked = lambda t: f'<span class="cap" style="display:flex;align-items:center;gap:5px">{icon("lock",14,"ic-sm")}{t}</span>'
screens['Ausruestung'] = page(f'''
<div class="phone">
  {header('Beute', coin_pill('1 786', big=True) + icon_btn('ticket'))}
  <div style="display:flex;border-bottom:1px solid {T['line']};margin:0 20px"><div class="tab">Belohnungen</div><div class="tab on">Ausrüstung</div></div>
  <div style="padding:16px 20px 0"><div class="btn btn-secondary" style="border-color:{T['ember']}55;color:{T['ember2']}">{icon('helm',20)}Helden anpassen</div></div>
  {section('Im Shop')}
  <div class="card" style="margin:0 20px">
    {gear_row('helm','Eisenhelm','Gewöhnlich','Kopf',coin_pill(400))}
    {gear_row('helm','Hörnerhelm','Selten','Kopf',coin_pill(900))}
    {gear_row('axe','Bartaxt','Selten','Hand',coin_pill(800))}
    {gear_row('cape','Königsmantel','Legendär','Umhang',coin_pill('2 500'))}
  </div>
  {section('Freischalten')}
  <div class="card" style="margin:0 20px">
    {gear_row('helm','Rabenkapuze','Selten','Kopf',owned)}
    {gear_row('crown','Krone des Konungr','Legendär','Kopf',locked('Ab Stufe VII'))}
  </div>
  {nav('beute')}
</div>''')

# ---- Hero customization
def slot_tile(ic, name, rarity=None, on=False, empty=False):
    border = T['ember'] if on else T['line']
    rc = {'Gewöhnlich': T['text2'], 'Selten': T['frost'], 'Legendär': T['ember2'], None: T['muted']}[rarity]
    return f'''<div style="display:flex;flex-direction:column;align-items:center;gap:8px;padding:12px 8px;border-radius:12px;border:{'2px' if on else '1px'} solid {border};background:{T['emberdim'] if on else T['s1']}">
  <div style="color:{rc};height:40px;display:flex;align-items:center">{icon(ic,32)}</div>
  <div class="cap" style="color:{T['text'] if not empty else T['muted']};font-weight:600">{name}</div>
  {'<span class="rarity" style="color:'+rc+'"><i style="background:'+rc+'"></i></span>' if rarity else '<span style="height:14px"></span>'}
</div>'''

screens['HeldAnpassen'] = page(f'''
<div class="phone">
  {header('Helden anpassen', back=True)}
  <div style="display:flex;flex-direction:column;align-items:center;gap:8px;padding:0 20px">
    <div style="position:relative;width:230px;height:250px;border-radius:18px;border:1px solid {T['line2']};background:radial-gradient(70% 60% at 50% 40%, rgba(124,162,191,.25), {T['s1']} 70%);display:flex;align-items:center;justify-content:center;overflow:hidden">
      <div style="position:absolute;inset:8px;border-radius:12px;border:1px solid rgba(224,160,69,.25)"></div>
      {hero_bust(4, 170, ('hood',))}
    </div>
    {level_badge(4)}
  </div>
  <div style="display:flex;gap:8px;padding:18px 20px 0;overflow:hidden">
    <span class="chip on">Kopf</span><span class="chip">Hand</span><span class="chip">Umhang</span><span class="chip">Gefährte</span><span class="chip">Rahmen</span>
  </div>
  <div style="padding:14px 20px;display:grid;grid-template-columns:repeat(3, minmax(0, 1fr));gap:10px">
    {slot_tile('x','Ablegen',None,False,True)}
    {slot_tile('helm','Lederkappe','Gewöhnlich')}
    {slot_tile('helm','Rabenkapuze','Selten',True)}
  </div>
  <div class="cap" style="padding:0 20px;text-align:center">Weitere Kopfbedeckungen im Shop oder ab Stufe VII.</div>
</div>''')

# ---- Leaderboard
def rank_row(rank, name, level, xp, visits, me=False, board=True, gear=()):
    c = LEVEL_COLORS[level]
    top = rank <= 3
    return f'''<div style="display:flex;align-items:center;gap:12px;padding:10px 14px;border-radius:12px;border:1px solid {T['ember']+'66' if me else T['line']};background:{T['emberdim'] if me else T['s1']}">
  <div class="num" style="width:28px;font-size:{20 if top else 15}px;color:{T['ember2'] if top else T['muted']}">{rank}</div>
  {hero_bust(level, 44, gear)}
  <div style="flex:1;display:flex;flex-direction:column;gap:5px">
    <div class="body" style="font-weight:800;display:flex;gap:6px;align-items:center">{name}{'<span class="cap" style="color:'+T['ember']+'">· Du</span>' if me else ''}</div>
    <div style="display:flex;gap:8px;align-items:center">{level_badge(level, True)}{'<span style="color:'+T['moss']+'">'+icon('ship',14,'ic-sm')+'</span>' if board else ''}</div>
  </div>
  <div style="text-align:right"><div class="num" style="font-size:15px;color:{T['ember2']}">{xp} XP</div><div class="cap">{visits} Besuche</div></div>
</div>'''

screens['Rangliste'] = page(f'''
<div class="phone">
  {header('Rangliste')}
  <div style="padding:0 20px 12px;display:flex;justify-content:space-between;align-items:center"><span class="cap">Alle Zeiten · nach XP</span><span class="pill pill-off">{icon('ship',14,'ic-sm')}7 an Bord</span></div>
  <div style="padding:0 20px;display:flex;flex-direction:column;gap:8px">
    {rank_row(1,'Björn',7,'8 745',80,gear=('crown',))}
    {rank_row(2,'Lagertha',7,'6 745',60)}
    {rank_row(3,'Floki',6,'3 295',20)}
    {rank_row(4,'Ubbe',5,'2 095',12)}
    {rank_row(5,'Torvi',4,'1 195',8)}
    {rank_row(6,'Ragnar',4,'1 105',7,me=True,gear=('hood',))}
    {rank_row(7,'Ivar',2,'295',3)}
    {rank_row(8,'Astrid',2,'170',2,board=False)}
  </div>
  {nav('rang')}
</div>''')

# ---- Profile
def menu_row(ic, label, badge=None):
    b = f'<span class="pill pill-danger" style="height:22px;padding:0 8px">{badge}</span>' if badge else ''
    return f'<div class="row"><span style="color:{T["text2"]}">{icon(ic,22)}</span><span class="body" style="flex:1;font-weight:600">{label}</span>{b}<span style="color:{T["muted"]}">{icon("chev",18,"ic-sm")}</span></div>'

screens['Profil'] = page(f'''
<div class="phone">
  {header('Profil', icon_btn('gear'))}
  <div style="display:flex;flex-direction:column;align-items:center;gap:8px;padding:0 20px">
    {hero_bust(4, 130, ('hood',))}
    <div class="display" style="font-size:26px">Ragnar</div>
    {level_badge(4)}
    <div class="num" style="font-size:13px;color:{T['text2']}">1 105 XP · Rang 6</div>
  </div>
  <div class="card" style="margin:18px 20px 0">
    {menu_row('helm','Helden anpassen')}{menu_row('sparkle','Erfolge')}{menu_row('ticket','Meine Gutscheine')}{menu_row('bell','Nachrichten','3')}
  </div>
  {section('1 786 Münzen', 'Verlauf ›')}
  <div class="card" style="margin:0 20px">
    <div class="row" style="padding:12px 16px"><span style="color:{T['blood']}">{icon('chest',20)}</span><div style="flex:1"><div class="body" style="font-weight:600">Belohnung</div><div class="cap">Di., 8. Sept. 15:33</div></div><span class="num" style="font-size:15px">−300</span></div>
    <div class="row" style="padding:12px 16px"><span style="color:{T['moss']}">{icon('glass',20)}</span><div style="flex:1"><div class="body" style="font-weight:600">Besuch</div><div class="cap">Di., 8. Sept. 15:12</div></div><span class="num" style="font-size:15px;color:{T['moss']}">+396</span></div>
  </div>
  {nav('profil')}
</div>''')

# ---- Settings
def toggle_row(label, on, sub=None):
    s = f'<div class="cap" style="margin-top:2px">{sub}</div>' if sub else ''
    return f'<div class="row"><div style="flex:1"><div class="body" style="font-weight:600">{label}</div>{s}</div><div class="toggle{" on" if on else ""}"></div></div>'

screens['Einstellungen'] = page(f'''
<div class="phone">
  {header('Einstellungen', back=True)}
  {section('Sprache')}
  <div style="padding:0 20px"><div class="seg"><div class="on">Deutsch</div><div>English</div></div></div>
  {section('Datenschutz')}
  <div class="card" style="margin:0 20px">
    {toggle_row('In der Rangliste sichtbar', True, 'Nur Nickname und Held, nie dein Name')}
    {toggle_row('Push zu Aktionen und Events', False)}
    {toggle_row('Personalisierte Angebote', False)}
  </div>
  <div class="cap" style="padding:10px 20px 0">Optionale Einwilligungen kannst du jederzeit widerrufen.</div>
  {section('Konto')}
  <div class="card" style="margin:0 20px">
    {menu_row('download','Meine Daten exportieren')}
    <div class="row"><span style="color:{T['blood']}">{icon('trash',22)}</span><span class="body" style="flex:1;font-weight:600;color:#E27A63">Konto löschen</span></div>
  </div>
  <div class="cap" style="padding:24px 20px;text-align:center">Valhalla Hero 0.1 · Teilnahmebedingungen · Datenschutz</div>
</div>''')

# ---- Vouchers
def voucher(name, code, status, sub, ic='glass'):
    colors = {'Aktiv': (T['ember2'], 'pill-coin'), 'Eingelöst': (T['moss'], 'pill-ok'), 'Abgelaufen': (T['muted'], 'pill-off')}
    c, pill = colors[status]
    strike = 'text-decoration:line-through;opacity:.5' if status != 'Aktiv' else ''
    return f'''<div class="card" style="display:flex;overflow:hidden">
  <div style="width:76px;background:{T['s2']};border-right:1px dashed {T['line2']};display:flex;align-items:center;justify-content:center;color:{c}">{icon(ic,30)}</div>
  <div style="flex:1;padding:14px 16px;display:flex;flex-direction:column;gap:4px">
    <div style="display:flex;justify-content:space-between;align-items:center"><span class="body" style="font-weight:700">{name}</span><span class="pill {pill}" style="height:22px">{status}</span></div>
    <div class="display" style="font-size:22px;color:{c};letter-spacing:.22em;{strike}">{code}</div>
    <div class="cap">{sub}</div>
  </div>
</div>'''

screens['Gutscheine'] = page(f'''
<div class="phone">
  {header('Meine Gutscheine', back=True)}
  <div style="padding:0 20px;display:flex;flex-direction:column;gap:10px">
    {voucher('Ein Bier aufs Haus','LBW7X5','Aktiv','Gültig bis 8. Okt. 2026')}
    {voucher('Valhalla Sticker-Set','K4NQ2R','Aktiv','Gültig bis 7. Nov. 2026','sparkle')}
    {voucher('Ein Bier aufs Haus','PE6NC2','Eingelöst','Eingelöst am 8. Sept. 2026')}
    {voucher('Signature Cocktail','TZ8M3H','Abgelaufen','Abgelaufen am 1. Aug. 2026')}
  </div>
</div>''')

# ---- Achievements
def ach_row(ic, name, desc, xp, coins, on, date=None):
    d = f'<div class="cap" style="color:{T["ember"]}">{date}</div>' if date else ''
    return f'''<div class="row">
  <div class="medal {'on' if on else 'off'}">{icon(ic,22)}</div>
  <div style="flex:1"><div class="body" style="font-weight:700;color:{T['text'] if on else T['text2']}">{name}</div><div class="cap">{desc}</div>{d}</div>
  <div style="text-align:right"><div class="cap" style="color:{T['frost']}">+{xp} XP</div>{'<div class="cap" style="color:'+T['ember']+'">+'+str(coins)+'</div>' if coins else ''}</div>
</div>'''

screens['Erfolge'] = page(f'''
<div class="phone">
  {header('Erfolge', back=True)}
  <div style="padding:0 20px 14px;display:flex;align-items:center;gap:14px">
    <div class="xp" style="flex:1"><div style="width:44%"></div></div><span class="num" style="font-size:13px;color:{T['ember2']}">7 / 16</span>
  </div>
  <div class="card" style="margin:0 20px">
    {ach_row('horn','Erster Schluck','Dein erster Besuch wurde gutgeschrieben.',20,50,True,'8. Sept. 2026')}
    {ach_row('shield','Stammgast','5 Besuche.',50,100,True,'8. Sept. 2026')}
    {ach_row('ship','An Bord','4 Wochen in Folge an Bord.',100,150,True,'8. Sept. 2026')}
    {ach_row('sparkle','Huskarl','Stufe IV erreicht.',0,200,True,'8. Sept. 2026')}
    {ach_row('axe','Hallenbewohner','25 Besuche.',150,250,False)}
    {ach_row('crown','Legende der Halle','100 Besuche.',600,'1 000',False)}
    {ach_row('map','Weltenbummler','Alle Bars der Kette besucht.',200,300,False)}
  </div>
</div>''')

# ---- Notifications
def notif(ic, title, body, when, unread):
    return f'''<div class="row" style="align-items:flex-start">
  <div class="medal {'on' if unread else 'off'}" style="width:40px;height:40px">{icon(ic,20)}</div>
  <div style="flex:1"><div class="body" style="font-weight:{800 if unread else 600}">{title}</div><div class="sub" style="margin-top:2px">{body}</div><div class="cap" style="margin-top:4px">{when}</div></div>
  {'<span style="width:8px;height:8px;border-radius:50%;background:'+T['ember']+';margin-top:6px"></span>' if unread else ''}
</div>'''

screens['Nachrichten'] = page(f'''
<div class="phone">
  {header('Nachrichten', back=True)}
  <div class="card" style="margin:0 20px">
    {notif('glass','Besuch gutgeschrieben','+50 XP, +396 Münzen','vor 12 Min.',True)}
    {notif('sparkle','Erfolg · Stammgast','5 Besuche. Skål!','vor 12 Min.',True)}
    {notif('crown','Neue Stufe: Huskarl','Du bist jetzt Huskarl. Treu bis zum letzten Horn.','Gestern',True)}
    {notif('cal','Skalden-Nacht am Freitag','Live-Musik ab 21 Uhr. Eintritt frei für alle an Bord.','Mo.',False)}
    {notif('clock','Münzen laufen bald ab','120 Münzen verfallen ab dem 30.09. Löse sie ein!','vor 1 Woche',False)}
  </div>
</div>''')

# ---- Staff claims
def claim_card(name, level, amount, when, note=None):
    n = f'<div class="sub" style="font-style:italic;margin-top:6px">„{note}“</div>' if note else ''
    return f'''<div class="card" style="padding:14px 16px">
  <div style="display:flex;align-items:center;gap:12px">
    {hero_bust(level, 40)}
    <div style="flex:1"><div class="body" style="font-weight:800">{name}</div><div class="cap">Valhalla Bar · {when}</div></div>
    <div class="num" style="font-size:22px;color:{T['ember2']}">{amount}</div>
  </div>
  {n}
  <div style="display:flex;gap:10px;margin-top:14px">
    <div class="btn btn-secondary btn-sm" style="flex:1;height:44px">{icon('x',18,'ic-sm')}Ablehnen</div>
    <div class="btn btn-primary btn-sm" style="flex:1.4;height:44px">{icon('check',18,'ic-sm')}Bestätigen</div>
  </div>
</div>'''

screens['TeamMeldungen'] = page(f'''
<div class="phone">
  {header('Team-Bereich', icon_btn('refresh'))}
  <div style="display:flex;border-bottom:1px solid {T['line']};margin:0 20px"><div class="tab on">Offene Meldungen <span class="pill pill-danger" style="height:18px;padding:0 6px;margin-left:4px">2</span></div><div class="tab">Gutschein einlösen</div></div>
  <div style="padding:16px 20px;display:flex;flex-direction:column;gap:10px">
    {claim_card('Ivar',2,'42,50 €','Di., 15:12','Freitag, Tisch 4')}
    {claim_card('Ragnar',4,'18,90 €','Di., 15:12')}
  </div>
  {nav('team', staff=True)}
</div>''')

# ---- Staff voucher
screens['TeamGutschein'] = page(f'''
<div class="phone">
  {header('Team-Bereich', icon_btn('refresh'))}
  <div style="display:flex;border-bottom:1px solid {T['line']};margin:0 20px"><div class="tab">Offene Meldungen</div><div class="tab on">Gutschein einlösen</div></div>
  <div style="padding:18px 20px;display:flex;flex-direction:column;gap:14px">
    <div class="field"><div class="input focus" style="height:64px;justify-content:space-between"><span class="lbl">Code eingeben</span><span class="display" style="font-size:28px;letter-spacing:.28em">LBW7X5</span><span style="display:flex;gap:4px;color:{T['muted']}">{icon('x',20)}{icon('search',20)}</span></div></div>
    <div class="card" style="padding:16px;display:flex;gap:14px;align-items:center;border-color:rgba(127,181,138,.4)">
      <div class="medal on" style="width:52px;height:52px;color:{T['ember2']}">{icon('glass',26)}</div>
      <div style="flex:1"><div class="body" style="font-weight:800">Ein Bier aufs Haus</div><div class="cap">Ragnar · Stufe IV · Gültig bis 8. Okt.</div></div>
      <span class="pill pill-ok">Aktiv</span>
    </div>
    <div class="btn btn-primary">{icon('check',20)}Als eingelöst markieren</div>
    <div class="cap" style="text-align:center">Der Code wird nach dem Einlösen ungültig.</div>
  </div>
  {nav('team', staff=True)}
</div>''')

# ================================================================ DESIGN SYSTEM
def swatch(name, hex_, role, text_dark=False):
    return f'''<div style="display:flex;flex-direction:column;gap:8px;width:132px">
  <div style="height:72px;border-radius:10px;background:{hex_};border:1px solid {T['line2']}"></div>
  <div><div class="body" style="font-weight:700">{name}</div><div class="cap" style="font-family:ui-monospace,monospace">{hex_}</div><div class="cap">{role}</div></div>
</div>'''

def ds_section(title, sub, inner):
    return f'''<div style="display:flex;flex-direction:column;gap:18px;padding:36px 0;border-top:1px solid {T['line']}">
  <div><div class="h1" style="font-size:20px">{title}</div>{f'<div class="sub" style="margin-top:6px;max-width:640px">{sub}</div>' if sub else ''}</div>
  {inner}
</div>'''

def labeled(label, inner):
    return f'<div style="display:flex;flex-direction:column;gap:10px"><span class="eyebrow">{label}</span>{inner}</div>'

ds_colors = f'''<div style="display:flex;flex-wrap:wrap;gap:20px">
{swatch('Grund','#0C0B0A','Hintergrund, warmes Schwarz')}{swatch('Fläche 1','#151311','Karten')}{swatch('Fläche 2','#1D1A17','Eingaben, Kacheln')}{swatch('Fläche 3','#282420','Angehoben')}
{swatch('Linie','#2F2A25','Rahmen')}{swatch('Linie stark','#453E36','Sekundäre Buttons')}{swatch('Knochen','#EFE7D8','Text')}{swatch('Asche','#AFA393','Sekundärtext')}{swatch('Gedämpft','#756B5E','Captions, Eyebrows')}
{swatch('Glut','#E0A045','Primäre Aktion, Münzen, XP')}{swatch('Glut hell','#F4BF63','Hover, Zahlen')}{swatch('Frost','#8FB8CF','Info, News, Selten')}{swatch('Moos','#7FB58A','Erfolg, An Bord')}{swatch('Blut','#C4573F','Fehler, Events, Ablehnen')}{swatch('Blut hell','#E27A63','Fehlertext')}
</div>
<div style="display:flex;gap:10px;flex-wrap:wrap;margin-top:8px">{''.join(f'<div style="display:flex;align-items:center;gap:8px;padding:8px 12px;border-radius:8px;border:1px solid {T["line"]}"><span style="width:14px;height:14px;border-radius:3px;background:{c}"></span><span class="cap">Stufe {ROMAN[l]} · {LEVELS[l]}</span></div>' for l, c in LEVEL_COLORS.items())}</div>'''

ds_type = f'''<div style="display:grid;grid-template-columns:repeat(2, minmax(0, 1fr));gap:28px">
  <div style="display:flex;flex-direction:column;gap:14px">
    <div class="display" style="font-size:40px;letter-spacing:.14em;color:{T['ember2']}">VALHALLA</div>
    <div class="cap">Cinzel 700 · Wortmarke, Screentitel, Stufen, große Zahlen (tabular)</div>
    <div class="h1">Screentitel · 24/1.1</div>
    <div class="num" style="font-size:44px">1 105</div>
    <div class="cap">Zahlen: Cinzel 600, tabular-nums. Tausender mit schmalem Leerzeichen.</div>
  </div>
  <div style="display:flex;flex-direction:column;gap:14px">
    <div class="h2">Manrope 800 · Titel 18</div>
    <div class="body">Manrope 400 · Fließtext 14/1.45. Jeder Weg beginnt am Ufer. Treu bis zum letzten Horn.</div>
    <div class="sub">Manrope 400 · Sekundär 13/1.4 in Asche</div>
    <div class="cap">Manrope 400 · Caption 11.5 in Gedämpft</div>
    <div class="eyebrow">Eyebrow 11 · 0.18em · Versalien</div>
  </div>
</div>'''

ds_buttons = f'''<div style="display:grid;grid-template-columns:repeat(2, minmax(0, 1fr));gap:28px">
  {labeled('Buttons · 52px, Radius 8', f'<div style="display:flex;flex-direction:column;gap:10px;max-width:340px"><div class="btn btn-primary">{icon("receipt",20)}Primär · Glut</div><div class="btn btn-secondary">Sekundär · Outline</div><div class="btn btn-primary" style="opacity:.4">Deaktiviert</div><div class="btn btn-danger">Destruktiv</div><div class="btn btn-ghost">Ghost / Textlink</div><div style="display:flex;gap:10px"><div class="btn btn-secondary btn-sm" style="flex:1">Klein</div><div class="btn btn-primary btn-sm" style="flex:1">Klein primär</div></div></div>')}
  {labeled('Eingaben · 52px, Label als Eyebrow', f'<div style="display:flex;flex-direction:column;gap:16px;max-width:340px"><div class="field"><div class="input"><span class="lbl">Standard</span>Wert</div></div><div class="field"><div class="input focus"><span class="lbl">Fokus</span>Wert</div></div><div class="field"><div class="input" style="border-color:{T["blood"]}"><span class="lbl" style="color:#E27A63">Fehler</span>Wert</div><div class="cap" style="color:#E27A63;margin-top:6px">Du musst mindestens 18 Jahre alt sein.</div></div><div class="seg"><div class="on">Deutsch</div><div>English</div></div><div style="display:flex;gap:8px"><span class="chip on">Kopf</span><span class="chip">Hand</span><span class="chip">Umhang</span></div><div style="display:flex;gap:16px;align-items:center"><div class="toggle on"></div><div class="toggle"></div><span class="cap">Schalter</span></div></div>')}
</div>'''

ds_badges = f'''<div style="display:flex;flex-wrap:wrap;gap:12px;align-items:center">
  {coin_pill(1786)}{coin_pill('1 786', True)}
  <span class="pill pill-ok">{icon('ship',14,'ic-sm')}An Bord</span><span class="pill pill-off">{icon('anchor',14,'ic-sm')}Von Bord</span>
  <span class="pill pill-frost" style="height:22px;font-size:10px;letter-spacing:.12em">NEWS</span><span class="pill pill-danger" style="height:22px;font-size:10px;letter-spacing:.12em">EVENT</span>
  <span class="pill pill-off">Prüfung</span><span class="pill pill-ok">Bestätigt</span><span class="pill pill-danger">Abgelehnt</span>
  <span class="rarity" style="color:{T['text2']}"><i style="background:{T['text2']}"></i>Gewöhnlich</span><span class="rarity" style="color:{T['frost']}"><i style="background:{T['frost']}"></i>Selten</span><span class="rarity" style="color:{T['ember2']}"><i style="background:{T['ember2']}"></i>Legendär</span>
</div>
<div style="display:flex;flex-wrap:wrap;gap:10px">{''.join(level_badge(l) for l in range(1, 9))}</div>'''

ds_cards = f'''<div style="display:grid;grid-template-columns:repeat(3, minmax(0, 1fr));gap:20px">
  {labeled('Heldenkarte · Halle', f'<div class="card" style="padding:18px;position:relative;overflow:hidden"><div class="glow" style="position:absolute;inset:0"></div><div style="position:relative;display:flex;gap:12px;align-items:center"><div style="flex:1;display:flex;flex-direction:column;gap:8px"><div class="display" style="font-size:22px">Ragnar</div>{level_badge(4)}<span class="pill pill-ok">{icon("ship",14,"ic-sm")}An Bord</span></div>{hero_bust(4, 90, ("hood",))}</div><div style="position:relative;margin-top:14px"><div class="xp"><div style="width:51%"></div></div><div class="ticks">{"<i></i>"*9}</div></div></div>')}
  {labeled('Belohnung · Grid 2', reward_card('shirt','Merch','Valhalla T-Shirt',2500,'Noch 30'))}
  {labeled('Gutschein', voucher('Ein Bier aufs Haus','LBW7X5','Aktiv','Gültig bis 8. Okt. 2026'))}
  {labeled('Listenzeilen · 14/16 Padding', f'<div class="card">{menu_row("helm","Helden anpassen")}{menu_row("bell","Nachrichten","3")}{gear_row("axe","Bartaxt","Selten","Hand",coin_pill(800))}</div>')}
  {labeled('Kacheln', f'<div style="display:flex;gap:10px">{stat_tile("coin","1 786","Münzen",T["ember"])}{stat_tile("glass","7","Besuche",T["frost"])}</div>')}
  {labeled('Rangzeile', rank_row(6,'Ragnar',4,'1 105',7,me=True,gear=('hood',)))}
</div>'''

ds_hero = f'''<div style="display:flex;gap:18px;flex-wrap:wrap;align-items:flex-end">
  {''.join(f'<div style="display:flex;flex-direction:column;align-items:center;gap:6px">{hero_bust(l, 84, ("hood",) if l==4 else ("horns",) if l==5 else ("crown",) if l>=7 else ())}<span class="cap" style="font-family:Cinzel,serif;letter-spacing:.1em;color:{LEVEL_COLORS[l]}">{ROMAN[l]} {LEVELS[l]}</span></div>' for l in range(1, 9))}
</div>
<div class="sub" style="max-width:720px">Platzhalter-Büsten bis die finalen Illustrationen (Midjourney, einheitliche Frontalpose, 4:5) da sind. Jede Stufe hat eine Kennfarbe, die in Badge, Glow und Rang wiederkehrt. Slots: Kopf, Hand, Umhang, Gefährte, Rahmen als transparente Ebenen über demselben Raster.</div>'''

ds_icons = f'''<div style="display:flex;flex-wrap:wrap;gap:14px">{''.join(f'<div style="width:64px;display:flex;flex-direction:column;align-items:center;gap:6px;color:{T["text2"]}">{icon(n,24)}<span class="cap" style="font-size:10px">{n}</span></div>' for n in ['shield','book','chest','rank','user','badge','bell','gear','ticket','receipt','check','x','search','ship','anchor','coin','chev','heart','cal','flame','horn','glass','shirt','crown','map','rune','clock','download','trash','sparkle','helm','axe','wolf','cape','lock','refresh'])}</div>
<div class="cap">Stroke 1.75 · 24px-Raster · abgerundete Kappen. Keine Emoji.</div>'''

ds_nav = f'''<div style="display:flex;gap:28px;flex-wrap:wrap">
  {labeled('Bottom-Navigation · 84px inkl. Home-Indicator', f'<div style="position:relative;width:390px;height:84px;background:{T["bg"]};border-radius:12px;overflow:hidden">{nav("halle", staff=True)}</div>')}
  {labeled('Tabs · Unterstrich', f'<div style="width:340px;display:flex;border-bottom:1px solid {T["line"]}"><div class="tab on">Belohnungen</div><div class="tab">Ausrüstung</div></div>')}
  {labeled('Abschnitt · Eyebrow + Aktion', f'<div style="width:340px;background:{T["bg"]}">{section("Erfolge","Alle 16 ›")}{rune_divider("oder")}</div>')}
</div>'''

ds_spacing = f'''<div style="display:flex;gap:40px;flex-wrap:wrap">
  {labeled('Abstände', '<div style="display:flex;gap:10px;align-items:flex-end">' + ''.join(f'<div style="display:flex;flex-direction:column;align-items:center;gap:6px"><div style="width:{s}px;height:{s}px;background:{T["emberdim"]};border:1px solid {T["ember"]}66"></div><span class="cap">{s}</span></div>' for s in [4,8,12,16,20,24,32]) + '</div>')}
  {labeled('Radien', '<div style="display:flex;gap:14px">' + ''.join(f'<div style="display:flex;flex-direction:column;align-items:center;gap:6px"><div style="width:56px;height:56px;border-radius:{r}px;background:{T["s2"]};border:1px solid {T["line2"]}"></div><span class="cap">{r} · {n}</span></div>' for r, n in [(6,'Pill/Badge'),(8,'Button/Input'),(12,'Karte'),(20,'Sheet')]) + '</div>')}
  {labeled('Touch-Ziele', f'<div style="display:flex;gap:14px;align-items:flex-end"><div style="width:44px;height:44px;border:1px dashed {T["frost"]};border-radius:8px"></div><span class="cap">min. 44px</span><div style="width:52px;height:52px;border:1px dashed {T["ember"]};border-radius:8px"></div><span class="cap">Button 52</span></div>')}
</div>'''

screens['DesignSystem'] = page(f'''
<div style="width:1240px;min-height:3900px;background:{T['bg']};background-image:url(&quot;data:image/svg+xml,{NOISE}&quot;);padding:56px 64px 80px;color:{T['text']}">
  <div style="display:flex;justify-content:space-between;align-items:flex-end;padding-bottom:28px">
    <div><div class="eyebrow" style="color:{T['ember']}">Design-System · v1</div><div class="display" style="font-size:44px;letter-spacing:.12em;margin-top:8px">VALHALLA HERO</div><div class="sub" style="margin-top:8px;max-width:620px">Dunkel, warm, nordisch. Glut als einzige Aktionsfarbe, Cinzel für Wortmarke, Titel, Stufen und Zahlen, alles andere ruhig in Manrope. Kein Chrome, kein Glanz: Kontrast, Rhythmus, eine Ornamentlinie.</div></div>
    <div style="display:flex;gap:10px">{level_badge(4)}{coin_pill('1 786')}</div>
  </div>
  {ds_section('Farben', 'Warme Schwarztöne statt Grau. Glut ist die einzige Aktionsfarbe und steht für Münzen und XP; Frost, Moos und Blut sind Zustandsfarben. Jede Stufe hat eine Kennfarbe.', ds_colors)}
  {ds_section('Typografie', 'Cinzel trägt den Mythos: Wortmarke, Screentitel, Stufennamen, Zahlen. Manrope trägt den Alltag. Zwei Familien, nie mehr.', ds_type)}
  {ds_section('Abstände, Radien, Ziele', 'Vierer-Raster. Leichte Rundungen, keine Pillen außer bei Status-Pills. Kein Element unter 44px.', ds_spacing)}
  {ds_section('Icons', '36 Stroke-Icons in einem Stil, alle im Code als Inline-SVG.', ds_icons)}
  {ds_section('Helden und Stufen', 'Acht Stufen, acht Kennfarben, eine Pose.', ds_hero)}
  {ds_section('Buttons und Eingaben', '', ds_buttons)}
  {ds_section('Pills, Badges, Seltenheit', '', ds_badges)}
  {ds_section('Karten und Zeilen', '', ds_cards)}
  {ds_section('Navigation', '', ds_nav)}
</div>''', w=1240, h=3900)

# ================================================================ DIRECTIONS (low-fi)
screens['RichtungB'] = page(f'''
<div class="phone" style="background:#1A120C;background-image:none;font-family:'Cormorant Garamond',Georgia,serif;color:#F1E3C8">
  <div style="padding:58px 22px 0">
    <div style="font-size:30px;font-weight:700;letter-spacing:.02em;border-bottom:2px solid #8A5A2B;padding-bottom:8px;display:flex;justify-content:space-between;align-items:flex-end"><span>Die Halle</span><span style="font-size:13px;letter-spacing:.2em;font-family:Manrope,sans-serif;opacity:.7">RAGNAR</span></div>
    <div style="margin-top:18px;border:2px solid #8A5A2B;padding:18px;background:#22170F;display:flex;gap:14px;align-items:center;box-shadow:6px 6px 0 #0E0906">
      <div style="width:110px;height:130px;background:repeating-linear-gradient(45deg,#3A2716 0 6px,#2B1D10 6px 12px);border:2px solid #C9A063"></div>
      <div style="flex:1"><div style="font-size:26px;font-weight:700">Huskarl</div><div style="font-size:15px;font-style:italic;opacity:.8">Treu bis zum letzten Horn.</div><div style="margin-top:10px;height:8px;background:#0E0906;border:1px solid #8A5A2B"><div style="width:51%;height:100%;background:#C9A063"></div></div><div style="font-family:Manrope,sans-serif;font-size:11px;letter-spacing:.14em;margin-top:6px;opacity:.7">1105 XP · NOCH 395</div></div>
    </div>
    <div style="display:flex;gap:10px;margin-top:14px">{''.join(f'<div style="flex:1;border:2px solid #8A5A2B;background:#22170F;padding:12px;text-align:center"><div style="font-size:26px;font-weight:700">{v}</div><div style="font-family:Manrope,sans-serif;font-size:10px;letter-spacing:.16em;opacity:.7">{l}</div></div>' for v,l in [('1786','MÜNZEN'),('7','BESUCHE'),('7','WOCHEN')])}</div>
    <div style="margin-top:16px;height:54px;background:#C9A063;color:#1A120C;display:flex;align-items:center;justify-content:center;font-family:Manrope,sans-serif;font-weight:800;letter-spacing:.14em;box-shadow:5px 5px 0 #0E0906">BESUCH MELDEN</div>
    <div style="margin-top:26px;font-size:13px;letter-spacing:.2em;font-family:Manrope,sans-serif;opacity:.6">ERFOLGE</div>
    <div style="display:flex;gap:10px;margin-top:10px">{''.join(f'<div style="width:78px;height:78px;border:2px solid #8A5A2B;background:{"#3A2716" if i<3 else "#22170F"}"></div>' for i in range(4))}</div>
    <div style="position:absolute;left:0;right:0;bottom:0;height:80px;border-top:2px solid #8A5A2B;background:#0E0906;display:flex;justify-content:space-around;align-items:center;font-family:Manrope,sans-serif;font-size:10px;letter-spacing:.14em">{''.join(f'<span style="opacity:{1 if i==0 else .5}">{t}</span>' for i,t in enumerate(['HALLE','SAGA','BEUTE','RANG','PROFIL']))}</div>
  </div>
</div>''', extra_css="@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&display=swap');")

screens['RichtungC'] = page(f'''
<div class="phone" style="background:#0A0D12;background-image:none;color:#E6EEF5;font-family:Manrope,sans-serif">
  <div style="position:absolute;inset:0;background:radial-gradient(60% 40% at 50% 0%, rgba(143,184,207,.18), transparent)"></div>
  <div style="position:relative;padding:58px 24px 0">
    <div style="font-size:13px;letter-spacing:.24em;opacity:.55">HALLE</div>
    <div style="margin-top:36px;display:flex;flex-direction:column;align-items:center;gap:14px">
      <div style="width:150px;height:150px;border-radius:50%;border:1px solid rgba(143,184,207,.5);display:flex;align-items:center;justify-content:center"><div style="width:120px;height:120px;border-radius:50%;background:linear-gradient(180deg,#1C2733,#0F151C)"></div></div>
      <div style="font-size:30px;font-weight:300;letter-spacing:.04em">Ragnar</div>
      <div style="font-size:12px;letter-spacing:.24em;color:#8FB8CF">IV · HUSKARL</div>
      <div style="width:220px;height:2px;background:#1C2733"><div style="width:51%;height:100%;background:#8FB8CF"></div></div>
      <div style="font-size:12px;opacity:.6">1 105 XP · noch 395</div>
    </div>
    <div style="display:flex;justify-content:space-around;margin-top:40px">{''.join(f'<div style="text-align:center"><div style="font-size:30px;font-weight:300">{v}</div><div style="font-size:10px;letter-spacing:.2em;opacity:.5">{l}</div></div>' for v,l in [('1786','MÜNZEN'),('7','BESUCHE'),('7','WOCHEN')])}</div>
    <div style="margin-top:40px;height:52px;border:1px solid #8FB8CF;border-radius:26px;display:flex;align-items:center;justify-content:center;font-size:13px;letter-spacing:.2em;color:#8FB8CF">BESUCH MELDEN</div>
    <div style="margin-top:40px;display:flex;gap:16px;justify-content:center">{''.join(f'<div style="width:52px;height:52px;border-radius:50%;border:1px solid {"#8FB8CF" if i<3 else "#1C2733"}"></div>' for i in range(4))}</div>
    <div style="position:absolute;left:0;right:0;bottom:0;height:84px;display:flex;justify-content:space-around;align-items:center;font-size:10px;letter-spacing:.2em;color:#5B6B7A">{''.join(f'<span style="color:{"#8FB8CF" if i==0 else "inherit"}">{t}</span>' for i,t in enumerate(['HALLE','SAGA','BEUTE','RANG','PROFIL']))}</div>
  </div>
</div>''')

# ================================================================ write + canvas.json
for name, html in screens.items():
    with open(os.path.join(OUT, f'{name}.dc.html'), 'w') as f:
        f.write(html)

order = ['Login', 'Registrieren', 'Main', 'BesuchMelden', 'Saga', 'Beute', 'BeuteEinloesen', 'Ausruestung', 'HeldAnpassen',
         'Rangliste', 'Profil', 'Einstellungen', 'Gutscheine', 'Erfolge', 'Nachrichten', 'TeamMeldungen', 'TeamGutschein']
titles = {'Main': 'Halle', 'BesuchMelden': 'Besuch melden', 'BeuteEinloesen': 'Beute · Einlösen', 'Ausruestung': 'Beute · Ausrüstung',
          'HeldAnpassen': 'Helden anpassen', 'TeamMeldungen': 'Team · Meldungen', 'TeamGutschein': 'Team · Gutschein'}
artboards = []
for i, n in enumerate(order):
    row, col = divmod(i, 9)
    artboards.append({'file': f'{n}.dc.html', 'title': titles.get(n, n), 'x': col * 480, 'y': row * 1000, 'w': 390, 'h': 844, 'page': 'screens'})
artboards.append({'file': 'DesignSystem.dc.html', 'title': 'Design-System', 'x': 0, 'y': 0, 'w': 1240, 'h': 3900, 'page': 'system', 'expand': 'fill'})
artboards.append({'file': 'RichtungB.dc.html', 'title': 'Richtung B · Taverne / Holzschnitt', 'x': 0, 'y': 0, 'w': 390, 'h': 844, 'page': 'alt'})
artboards.append({'file': 'RichtungC.dc.html', 'title': 'Richtung C · Frost / Minimal', 'x': 480, 'y': 0, 'w': 390, 'h': 844, 'page': 'alt'})

canvas = {
    'pages': [{'id': 'screens', 'name': 'Screens'}, {'id': 'system', 'name': 'Design-System'}, {'id': 'alt', 'name': 'Alternativen'}],
    'artboards': artboards,
    'annotations': [
        {'id': 'note-brief', 'x': 0, 'y': -170, 'w': 460, 'page': 'screens',
         'text': 'Richtung A „Glut & Asche“: warmes Schwarz, eine Aktionsfarbe (Glut), Cinzel für Titel, Stufen und Zahlen, Manrope für alles andere.\nStatische Mockups, 390×844. Heldenbüsten sind Platzhalter bis die Illustrationen da sind.'},
        {'id': 'note-alt', 'x': 0, 'y': -150, 'w': 420, 'page': 'alt',
         'text': 'Zwei Low-Fi-Alternativen nur für den Home-Screen.\nB: Taverne/Holzschnitt, Serif, harte Kanten, Ocker. Wärmer, rustikaler, weniger „App“.\nC: Frost/Minimal, kühles Blau, dünne Linien, viel Luft. Edler, aber weniger Bar.'},
    ],
    'launch': {'view': 'canvas', 'page': 'screens'},
}
with open(os.path.join(OUT, 'canvas.json'), 'w') as f:
    json.dump(canvas, f, ensure_ascii=False, indent=2)
print('wrote', len(screens), 'artboards to', OUT)
