

class GymPriceDto{
  int? id;
  String? during;
  String? price;

  GymPriceDto(
      {required this.id, required this.during, required this.price});

  factory GymPriceDto.fromJson(Map<String, dynamic> json,imgs) {
    return GymPriceDto(
      id: json['id'],
      during: json['during'],
      price: json['price'],
    );
  }
}