class Cart {
  final String name;
  final String type;
  final String brand;
  final String imageURL;
  final int price;
  final String ket;

  Cart(this.name, this.type,this.brand, this.imageURL, this.price, this.ket);

  factory Cart.fromJson(Map<String, dynamic> json) {
    return new Cart(
      json["name"],
      json["type"],
      json["brand"],
      json["imageURL"],
      json["price"],
      json["ket"]
    );
  }
}
