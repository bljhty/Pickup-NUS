// implementation of database to obtain the menu items available
class Food {
  String? merchantId;
  String? itemName;
  String? menuType;
  String? imgUrl;
  String? waitTime;
  num? price;
  num? quantity; // to be removed later on

  Food({
    this.merchantId,
    this.itemName,
    this.menuType,
    this.imgUrl,
    this.waitTime,
    this.price,
    this.quantity,
  });

  // receiving data from the database
  factory Food.fromMap(map) {
    return Food(
      merchantId: map['merchantId'],
      itemName: map['itemName'],
      menuType: map['menuType'],
      imgUrl: map['imgUrl'],
      waitTime: map['waitTime'],
      price: map['price'], // if don't work try double.parse(map['price'])
      quantity: map['quantity'], // if don't work try int.parse(map['quantity'])
    );
  }

  // sending data to the database
  Map<String, dynamic> toMap() {
    return {
      'merchantId': merchantId,
      'itemName': itemName,
      'menuType': menuType,
      'imgUrl': imgUrl,
      'waitTime': waitTime,
      'price': price,
      'quantity': quantity,
    };
  }
}
