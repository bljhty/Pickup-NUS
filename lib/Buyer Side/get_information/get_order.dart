// implementation of database to obtain the orders placed by buyers
class Order {
  String? buyerId;
  String? buyerName;
  String? merchantId;
  String? itemId;
  String? instructions;
  num? quantity;
  num? subPrice;
  bool? isOrderPlaced;
  bool? isOrderReady;
  bool? isOrderCollected;

  Order({
    this.buyerId,
    this.buyerName,
    this.merchantId,
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
      buyerId: map['buyerId'],
      buyerName: map['buyerName'],
      merchantId: map['merchantId'],
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
      'buyerId': buyerId,
      'buyerName': buyerName,
      'merchantId': merchantId,
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