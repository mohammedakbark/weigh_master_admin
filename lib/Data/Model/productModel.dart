class ProductModel {
  String? id;
  String name;
  String discription;
  String type;
  double rate;
  String image;

  ProductModel(
      {required this.discription,
      this.id,
      required this.image,
      required this.name,
      required this.rate,
      required this.type});
  Map<String, dynamic> toHson(id) => {
        "id": id,
        "image":image,
        "name": name,
        "discription": discription,
        "type": type,
        "rate": rate
      };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      image: json["image"],
        discription: json["discription"],
        id: json["id"],
        name: json["name"],
        rate: json["rate"],
        type: json["type"]);
  }
}
