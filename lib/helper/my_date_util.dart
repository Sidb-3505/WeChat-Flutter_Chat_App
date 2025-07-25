import 'package:flutter/material.dart';

class MyDateUtil {
  /// for getting formatted time from MilliSecondsEpoch
  static getFormattedTime({
    required BuildContext context,
    required String time,
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  /// for getting formatted time for sent and read
  static String getMessageTime({required String time}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    // Format hour and minute manually
    final String hour = sent.hour.toString().padLeft(2, '0');
    final String minute = sent.minute.toString().padLeft(2, '0');
    final String formattedTime = '$hour:$minute';

    /// if the msg is sent on today's date
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return formattedTime;
    }

    /// if its of some other day
    return now.year == sent.year
        ? '$formattedTime, ${sent.day} ${_getMonth(sent)}'
        : '$formattedTime, ${sent.day} ${_getMonth(sent)} ${sent.year}';
  }

  /// for getting last message time( used in userchat card)
  static String getLastMessageTime({
    required BuildContext context,
    required String time,
    bool showYear = false,
  }) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    /// if the msg is sent on today's date
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }

    /// if its of some other day
    return showYear
        ? '${sent.day} ${_getMonth(sent)} ${sent.year}'
        : '${sent.day} ${_getMonth(sent)}';
  }

  /// get month name from month number
  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }

  //get formatted last active time of user in chat screen
  static String getLastActiveTime({
    required BuildContext context,
    required String lastActive,
  }) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Last seen not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = _getMonth(time);

    return 'Last seen on ${time.day} $month on $formattedTime';
  }
}
