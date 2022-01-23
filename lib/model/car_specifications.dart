class Specifications {
  final String seat;
  final String type;
  final String bt;
  final String ac;
  final String usb;
  final String android;

  Specifications(this.seat, this.type, this.bt, this.ac, this.usb, this.android);

  factory Specifications.fromJson(Map<String, dynamic> json) {
    return new Specifications(
      json["seat"], 
      json["type"], 
      json["bt"], 
      json["ac"],
      json["usb"],
      json["android"],
    );
  }
}
