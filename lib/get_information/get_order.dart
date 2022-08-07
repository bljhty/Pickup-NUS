/// Implementation of database to obtain information of orders made by buyers
/// receive/send data from 'orders' collection in Firestore Database
///
/// @param orderNum Order number displayed for users, obtained from last 4
/// characters of the order's document Id
/// @param buyerId Id of buyer in collection 'buyer' who made order
/// @param buyerName Name of buyer who made the order
/// @param merchantId Id of merchant in collection 'restaurants' whose food
/// is from
/// @param itemName Name of food item ordered
/// @param itemId Id of food item in collection 'foods'
/// @param instructions Additional instructions for buyer would like to provide
/// to restaurant
/// @param quantity Quantity of food item ordered
/// @param subPrice Total price of the order
/// @param isOrderPlaced Boolean to represent if order has been checked out
/// @param isOrderReady Boolean to represent if order is made by restaurant
/// ready for collection
/// @param isOrderCollected Boolean to represent if order has been collected
/// by buyer

class Order {
  String? orderNum;
  String? buyerId;
  String? buyerName;
  String? merchantId;
  String? itemName;
  String? itemId;
  String? instructions;
  num? quantity;
  num? subPrice;
  bool? isOrderPlaced;
  bool? isOrderReady;
  bool? isOrderCollected;

  Order({
    this.orderNum,
    this.buyerId,
    this.buyerName,
    this.merchantId,
    this.itemName,
    this.itemId,
    this.instructions,
    this.quantity,
    this.subPrice,
    this.isOrderPlaced,
    this.isOrderReady,
    this.isOrderCollected,
  });

  // Receiving data from the database
  factory Order.fromMap(map) {
    return Order(
      orderNum: map['orderNum'],
      buyerId: map['buyerId'],
      buyerName: map['buyerName'],
      merchantId: map['merchantId'],
      itemName: map['itemName'],
      itemId: map['itemId'],
      instructions: map['instructions'],
      quantity: map['quantity'],
      subPrice: map['subPrice'],
      isOrderPlaced: map['isOrderPlaced'],
      isOrderReady: map['isOrderReady'],
      isOrderCollected: map['isOrderCollected'],
    );
  }

  // Sending data to the database
  Map<String, dynamic> toMap() {
    return {
      'orderNum': orderNum,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'merchantId': merchantId,
      'itemName': itemName,
      'itemId': itemId,
      'instructions': instructions,
      'quantity': quantity,
      'subPrice': subPrice,
      'isOrderPlaced': isOrderPlaced,
      'isOrderReady': isOrderReady,
      'isOrderCollected': isOrderCollected,
    };
  }
}
