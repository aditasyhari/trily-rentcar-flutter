class Car {
  final String name;
  final String brand;
  final String imageURL;
  final int price;
  final String ket;

  Car(this.name, this.brand, this.imageURL, this.price, this.ket);

  factory Car.fromJson(Map<String, dynamic> json) {
    return new Car(
      json["name"],
      json["brand"],
      json["imageURL"],
      json["price"],
      json["ket"]
    );
  }
}
