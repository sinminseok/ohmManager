class GymTimeDto {
  int? id;

  //휴관일
  String? closeddays;

  String? sunday;

  String? saturday;

  //평일
  String? weekday;

  //공휴일
  String? holiday;

  GymTimeDto(
      {required this.id,
      required this.closeddays,
      required this.sunday,
      required this.saturday,
      required this.holiday,
      required this.weekday});

  factory GymTimeDto.fromJson(Map<String, dynamic> json, imgs) {
    return GymTimeDto(
      id: json['id'],
      closeddays: json['closeddays'],
      sunday: json['sunday'],
      saturday: json['saturday'],
      weekday: json['weekday'],
      holiday: json['holiday'],
    );
  }
}
