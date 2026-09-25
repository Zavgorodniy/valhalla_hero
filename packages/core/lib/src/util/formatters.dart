import 'package:intl/intl.dart';

String formatEuro(int cents, {String locale = 'de'}) =>
    NumberFormat.currency(locale: locale, symbol: '€').format(cents / 100);

String formatDate(DateTime d, {String locale = 'de'}) => DateFormat.yMMMd(locale).format(d.toLocal());

String formatDateTime(DateTime d, {String locale = 'de'}) => DateFormat.yMMMEd(locale).add_Hm().format(d.toLocal());

String formatNumber(int n, {String locale = 'de'}) => NumberFormat.decimalPattern(locale).format(n);

/// Parses "12,50" / "12.50" / "12" into cents; null when invalid.
int? parseEuroToCents(String input) {
  final s = input.trim().replaceAll('€', '').replaceAll(' ', '').replaceAll(',', '.');
  final v = double.tryParse(s);
  if (v == null || v <= 0) return null;
  return (v * 100).round();
}
