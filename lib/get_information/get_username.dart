/// Implementation of database to obtain information of user
/// receive/send data from 'users' collection in Firestore Database
///
/// @param id Id of buyer/restaurant in 'buyers'/'restaurants' collection
/// depending on user type
/// @param name Name of restaurant/buyer
/// @param userType Type of user (Buyer, Merchant, Administrator)

class Username {
  String? id;
  String? name;
  String? userType;

  Username({
    this.id,
    this.name,
    this.userType,
  });

  // Receiving data from the database
  factory Username.fromMap(map) {
    return Username(
      id: map['id'],
      name: map['name'],
      userType: map['userType'],
    );
  }

  // Sending data to the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userType': userType,
    };
  }
}
