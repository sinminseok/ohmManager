

class WeekData {
  WeekData({required this.days});
  List<DayData> days;

}

class DayData {
  DayData({required this.hour, required this.laughs});
  double hour;
  int laughs;
}