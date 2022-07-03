// implementation of database to obtain the merchants available as
// restaurants to order from

class Restaurant {
  String? merchantId;
  String? merchantName;
  String? waitTime;
  String? distance;
  String? logoUrl;
  String? place;
  bool? isOpenForOrder;

  Restaurant({
    this.merchantId,
    this.merchantName,
    this.waitTime,
    this.distance,
    this.logoUrl,
    this.place,
    this.isOpenForOrder,
  });

  // receiving data from database
  factory Restaurant.fromMap(map) {
    return Restaurant(
      merchantId: map['merchantId'],
      merchantName: map['merchantName'],
      waitTime: map['waitTime'],
      distance: map['distance'],
      logoUrl: map['logoUrl'],
      place: map['place'],
      isOpenForOrder: map['isOpenForOrder'],
    );
  }

  // sending data to the database
  Map<String, dynamic> toMap() {
    return {
      'merchantId': merchantId,
      'merchantName': merchantName,
      'waitTime': waitTime,
      'distance': distance,
      'logoUrl': logoUrl,
      'place': place,
      'isOpenForOrder': isOpenForOrder,
    };
  }

  // check if the restaurants are duplicates

}