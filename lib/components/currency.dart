import 'package:intl/intl.dart';

String formatCurrency(number) {
  if (number is String) number = double.tryParse(number);
  String _format =
      NumberFormat.currency(locale: 'vi_VN', symbol: '').format(number);
  return _format;
}
