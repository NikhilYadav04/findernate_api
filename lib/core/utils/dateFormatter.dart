import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateToYYMMDD(DateTime date) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String year = twoDigits(date.year % 100); // Get last two digits of year
    String month = twoDigits(date.month);
    String day = twoDigits(date.day);
    return '$day-$month-$year';
  }

  static String formatPostTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 10) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else {
      // Format date as: 24 Jan 04
      return '${dateTime.day} ${_monthAbbr(dateTime.month)} ${dateTime.year.toString().substring(2)}';
    }
  }

  static String _monthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  static String formatCommentFTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }

  static String showUserStatus(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    final duration = diff.abs();

    if (duration.inSeconds < 60) {
      return '${duration.inSeconds} second${duration.inSeconds == 1 ? '' : 's'}';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} minute${duration.inMinutes == 1 ? '' : 's'}';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} hour${duration.inHours == 1 ? '' : 's'}';
    } else if (duration.inDays < 30) {
      return '${duration.inDays} day${duration.inDays == 1 ? '' : 's'}';
    } else if (duration.inDays < 365) {
      final months = (duration.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'}';
    } else {
      final years = (duration.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'}';
    }
  }

  //* Chats Time Formatter
  static String formatLastMessageTime(String isoString) {
    final dateTime = DateTime.parse(isoString);
    final formatter = DateFormat.Hm();
    return formatter.format(dateTime);
  }

  static String formatMessageSentTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String formatStatusTime(int millis) {
    final inputTime = DateTime.fromMillisecondsSinceEpoch(millis);
    final now = DateTime.now();
    final diff = now.difference(inputTime);

    if (diff.inDays >= 365) {
      final years = diff.inDays ~/ 365;
      return '$years year${years > 1 ? 's' : ''}';
    } else if (diff.inDays >= 30) {
      final months = diff.inDays ~/ 30;
      return '$months month${months > 1 ? 's' : ''}';
    } else if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''}';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''}';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''}';
    } else {
      final seconds = diff.inSeconds;
      return '$seconds second${seconds != 1 ? 's' : ''}';
    }
  }
}
