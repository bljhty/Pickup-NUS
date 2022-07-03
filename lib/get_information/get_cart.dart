// implementation of database to obtain the cart of buyers
class Cart {
  String? buyerId;
  String? buyerName;
  String? orderId;
  num? totalPrice;

  Cart({
    this.buyerId,
    this.buyerName,
    this.orderId,
    this.totalPrice,
  });

  // receiving data from the database
  factory Cart.fromMap(map) {
    return Cart(
      buyerId: map['buyerId'],
      buyerName: map['buyerName'],
      orderId: map['orderId'],
      totalPrice: map['totalPrice'],
    );
  }

  // sending data to the database
  Map<String, dynamic> toMap() {
    return {
      'buyerId': buyerId,
      'buyerName': buyerName,
      'orderId': orderId,
      'totalPrice': totalPrice
    };
  }
}
