// implementation of database to obtain the menu items available

class Username {
  String? id;
  String? name;
  String? userType;

  Username({
    this.id,
    this.name,
    this.userType,
  });

  // receiving data from the database
  factory Username.fromMap(map) {
    return Username(
      id: map['id'],
      name: map['name'],
      userType: map['userType'],
    );
  }

  // sending data to the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userType': userType,
    };
  }
}
