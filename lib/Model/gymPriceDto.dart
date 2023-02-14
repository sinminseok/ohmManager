

class GymPriceDto{
  int? id;
  String? during;
  String? price;

  GymPriceDto(
      {required this.during, required this.price});



  factory GymPriceDto.fromJson(Map<String, dynamic> json) {
    return GymPriceDto(
      during: json['during'],
      price: json['price'],
    );
  }
}