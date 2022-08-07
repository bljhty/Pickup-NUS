/// Implementation of database to obtain information of restaurants
/// receive/send data from 'restaurants' collection in Firestore Database
///
/// @param merchantId Id of merchant's document in collection 'restaurants'
/// @param merchantName Name of restaurant
/// @param logoUrl Url location of restaurant's logo photo
/// @param place Location of restaurant
/// @param isOrderForOrder Boolean to represent if restaurant is open/closed for
/// ordering

class Restaurant {
  String? merchantId;
  String? merchantName;
  String? logoUrl;
  String? place;
  bool? isOpenForOrder;

  Restaurant({
    this.merchantId,
    this.merchantName,
    this.logoUrl,
    this.place,
    this.isOpenForOrder,
  });

  // Receiving data from database
  factory Restaurant.fromMap(map) {
    return Restaurant(
      merchantId: map['merchantId'],
      merchantName: map['merchantName'],
      logoUrl: map['logoUrl'],
      place: map['place'],
      isOpenForOrder: map['isOpenForOrder'],
    );
  }

  // Sending data to the database
  Map<String, dynamic> toMap() {
    return {
      'merchantId': merchantId,
      'merchantName': merchantName,
      'logoUrl': logoUrl,
      'place': place,
      'isOpenForOrder': isOpenForOrder,
    };
  }
}
