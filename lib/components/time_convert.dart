import 'package:get/get.dart';
import 'package:intl/intl.dart';

String convertTimeAgo({int? now, required int time}) {
  now ??= DateTime.now().millisecondsSinceEpoch;
  double _seconds = (now - time) / 1000;
  if (_seconds < 60) {
    return 'now_ago'.tr;
  } else if (_seconds >= 60 && _seconds < 3600) {
    return '${(_seconds / 60).toStringAsFixed(0)} ${'minute_ago'.tr}';
  } else if (_seconds >= 3600 && _seconds < 86400) {
    return '${(_seconds / 3600).toStringAsFixed(0)} ${'hour_ago'.tr}';
  } else {
    return DateFormat('dd-MM-yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(time));
  }
}

String timeCaculate({int? now, required int time}) {
  now ??= DateTime.now().millisecondsSinceEpoch;
  double _seconds = ((time - (now - 86400000)) / 1000).clamp(0.0, 86400);

  return '${(_seconds / 3600).toStringAsFixed(0)} ${'hours'.tr}';
}
