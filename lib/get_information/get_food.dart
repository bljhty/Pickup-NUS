// implementation of database to obtain the menu items available
class Food {
  String? merchantId;
  String? itemName;
  String? itemId;
  String? menuType;
  String? imgUrl;
  String? waitTime;
  num? price;

  Food({
    this.merchantId,
    this.itemName,
    this.itemId,
    this.menuType,
    this.imgUrl,
    this.waitTime,
    this.price,
  });

  // receiving data from the database
  factory Food.fromMap(map) {
    return Food(
      merchantId: map['merchantId'],
      itemName: map['itemName'],
      itemId: map['itemId'],
      menuType: map['menuType'],
      imgUrl: map['imgUrl'],
      waitTime: map['waitTime'],
      price: map['price'], // if don't work try double.parse(map['price'])
    );
  }

  // sending data to the database
  Map<String, dynamic> toMap() {
    return {
      'merchantId': merchantId,
      'itemName': itemName,
      'itemId': itemId,
      'menuType': menuType,
      'imgUrl': imgUrl,
      'waitTime': waitTime,
      'price': price,
    };
  }
}
