import 'package:intl/intl.dart';

String formatCurrency(number) {
  if (number is String) number = double.tryParse(number);
  String _format =
      NumberFormat.currency(locale: 'vi_VN', symbol: '').format(number);
  return _format;
}

String formatNumberString(num number) {
  double _kNumber = number / 1000;

  if (_kNumber < 1) {
    return number.toStringAsFixed(0);
  } else {
    double _mNumber = _kNumber / 1000;
    if (_mNumber < 1) {
      if (number % 1000 > 100) {
        return _kNumber.toStringAsFixed(1) + 'k';
      } else {
        return _kNumber.toStringAsFixed(0) + 'k';
      }
    } else {
      if (_kNumber % 1000 > 100) {
        return _mNumber.toStringAsFixed(1) + 'm';
      } else {
        return _mNumber.toStringAsFixed(0) + 'm';
      }
    }
  }
}
