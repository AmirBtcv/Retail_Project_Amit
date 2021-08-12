// import 'package:amit_final_project/model/ProductRespone.dart';

class Product {
  Product({
    this.id,
    this.name,
    this.title,
    this.categoryId,
    this.description,
    this.price,
    this.discount,
    this.discountType,
    this.currency,
    this.inStock,
    this.avatar,
    this.priceFinal,
    this.priceFinalText,
  });

  int id;
  String name;
  String title;
  int categoryId;
  String description;
  int price;
  int discount;
  String discountType;
  String currency;
  int inStock;
  String avatar;
  double priceFinal;
  String priceFinalText;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    categoryId: json["category_id"],
    description: json["description"] == null ? " " : json["description"],
    price: json["price"],
    discount: json["discount"],
    discountType: json["discount_type"] == null ? " " : json["discount_type"],
    currency: json["currency"],
    inStock: json["in_stock"],
    avatar: json["avatar"],
    priceFinal: json["price_final"] == null ?0.0:json['price_final'].toDouble(),
    priceFinalText: json["price_final_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "category_id": categoryId,
    "description": description == null ? " " : description,
    "price": price,
    "discount": discount,
    "discount_type": discountType == null ? " " : discountType,
    "currency": currency,
    "in_stock": inStock,
    "avatar": avatar,
    "price_final": priceFinal,
    "price_final_text": priceFinalText,
  };
}
