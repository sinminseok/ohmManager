class GymTimeDto {
  int? id;

  //휴관일
  String? closeddays;

  String? sunday;

  String? saturday;

  //평일
   String? monday;

   String? tuesday;

   String? wednesday;

   String? thursday;

   String? friday;

  //공휴일
  String? holiday;

  GymTimeDto(
      {required this.id,
      required this.closeddays,
      required this.sunday,
      required this.saturday,
      required this.holiday,
        required this.monday,
        required this.tuesday,
        required this.wednesday,
        required this.thursday,
        required this.friday,});

  factory GymTimeDto.fromJson(Map<String, dynamic> json) {
    return GymTimeDto(
      id: json['id'],
      closeddays: json['closeddays'],
      sunday: json['sunday'],
      saturday: json['saturday'],
      monday: json['monday'],
      friday: json['friday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      holiday: json['holiday'],
    );
  }
}
