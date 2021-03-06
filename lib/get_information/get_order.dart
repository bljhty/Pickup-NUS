// implementation of database to obtain the orders placed by buyers
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

  // receiving data from the database
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

  // sending data to the database
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
