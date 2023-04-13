class TrainerDto {
  int? id;

  String? name;

  String? profile;

  String? position;

  String? oneline_introduce;

  //자기소개
  String? introduce;

  bool? showProfile;


  String? nickname;

  String? role;

  bool? available;

  TrainerDto(
      {required this.showProfile,
      required this.role,
      required this.position,
      required this.id,
      required this.name,
        required this.available,
      required this.profile,
      required this.oneline_introduce,
      required this.introduce,
      required this.nickname});

  factory TrainerDto.fromJson(Map<String, dynamic> json) {
    return TrainerDto(
      id: json['id'],
      showProfile: json['showProfile'],
      position: json['position'],
      name: json['username'],
      profile: json['profile'],
      available : json['available'],
      oneline_introduce: json['onelineIntroduce'],
      introduce: json['introduce'],
      nickname: json['nickname'],
      role: json['role'],
    );
  }
}
