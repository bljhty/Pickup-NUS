/// Implementation of database to obtain information of the food items
/// receive/send data from 'foods' collection in Firestore Database
///
/// @param merchantId Id of document storing merchant's information
/// @param itemName Name of food item
/// @param itemId Id of food item in collection 'foods'
/// @param menuType Menu type of food item (i.e. Mains, Sides, etc.)
/// @param imgUrl Url link of the image for the food item
/// @param waitTime estimated waiting time for making food item
/// @param price Price of food item

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

  // Receiving data from the database
  factory Food.fromMap(map) {
    return Food(
      merchantId: map['merchantId'],
      itemName: map['itemName'],
      itemId: map['itemId'],
      menuType: map['menuType'],
      imgUrl: map['imgUrl'],
      waitTime: map['waitTime'],
      price: map['price'],
    );
  }

  // Sending data to the database
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
