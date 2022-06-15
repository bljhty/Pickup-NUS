// placeholder menu items

class Food {
  String imgUrl;
  String name;
  String waitTime;
  num price;
  num quantity;

  Food(
    this.imgUrl,
    this.name,
    this.waitTime,
    this.price,
    this.quantity,
  );

  // factory Food.fromJson(Map<String, dynamic> json) {
  //   return Food(
  //     json['imgUrl'],
  //       json['itemName'],
  //     json['waitTime'],
  //     double.parse(json['itemUnitPrice']),
  //     int.parse(json['quantity'])
  //   );
  // }
  //
  // static List<Food> fromJsonArray(List<dynamic> jsonArray) {
  //   List<Food> foodsFromJson = []; // list to store the foods in the menu
  //
  //   jsonArray.forEach((jsonData) {
  //     foodsFromJson.add(Food.fromJson(jsonData));
  //   });
  // }

  // static list of the foods available from the merchant
  static List<Food> generateFoods(String restaurant, String menuType) {
    if (restaurant == 'Taiwan Ichiban') {
      if (menuType == 'Mains') {
        return [
          Food(
            'assets/images/dish1.png',
            'Honey Chicken Rice',
            '15 min',
            5.10,
            1,
          ),
          Food(
            'assets/images/dish2.png',
            'XXL Chicken Rice',
            '15 min',
            5.50,
            1,
          )
        ];
      }
    } else if (restaurant == 'Pasta Express') {
      if (menuType == 'Pasta') {
        return [
          Food(
            'assets/images/creamy_pasta.png',
            'Creamy Pasta',
            '5 min',
            3.50,
            1,
          )
        ];
      }
    }

    // return error if restaurant/menuType does not exist
    return [
      Food(
        'error',
        'error',
        'error',
        0,
        0,
      )
    ];
  }
}
