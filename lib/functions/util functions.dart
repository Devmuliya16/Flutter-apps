import 'package:timeago/timeago.dart' as timeago;

class UtilFun {
  static String getRelativeTime(String timestamp) {
    return timeago.format(DateTime.parse(timestamp), locale: 'en_short');
  }
}
