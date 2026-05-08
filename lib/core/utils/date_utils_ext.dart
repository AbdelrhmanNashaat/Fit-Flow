abstract final class AppDateUtils {
  static DateTime dateForWeekday(int weekday) {
    final now = DateTime.now();
    final diff = weekday - now.weekday;
    return now.add(Duration(days: diff));
  }

  static int currentWeekNumber() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final diff = now.difference(startOfYear).inDays;
    return ((diff + startOfYear.weekday - 1) ~/ 7) + 1;
  }
}
