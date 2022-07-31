import 'dart:ffi';
import 'dart:typed_data';

class User {
  late int id;
  late String tire;
  late String price;
  User({
    required this.id,
    required this.tire,
    required this.price,
  });
  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'tire': tire,
      'price': price,
    };
  }

  User.toJson(Map<String, dynamic> res)
      : id = res["id"],
        tire = res["tire"],
        price = res["size"];
}
