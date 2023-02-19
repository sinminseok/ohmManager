

class GymPriceDto{
  int? id;
  String? during;
  String? price;

  GymPriceDto(
      {required this.during, required this.price,required this.id});



  factory GymPriceDto.fromJson(Map<String, dynamic> json) {
    return GymPriceDto(
      id:json['id'],
      during: json['during'],
      price: json['price'],
    );
  }
}