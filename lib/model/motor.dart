class Motor {
  final String name;
  final String brand;
  final String imageURL;
  final int price;
  final String ket;

  Motor(this.name, this.brand, this.imageURL, this.price, this.ket);

  factory Motor.fromJson(Map<String, dynamic> json) {
    return new Motor(
      json["name"], 
      json["brand"], 
      json["imageURL"], 
      json["price"],
      json["ket"],
    );
  }
}
