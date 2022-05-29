// placeholder restaurant

import 'food.dart';

class Restaurant {
  String merchantName;
  String waitTime;
  String distance;
  String logoURL;
  Map<String, List<Food>> menu;

  Restaurant(
      this.merchantName,
      this.waitTime,
      this.distance,
      this.logoURL,
      this.menu,
      );

  // static list of restaurants available to order from
  static Restaurant generateRestaurant() {
    return Restaurant(
        'Taiwan Ichiban',
        '15 - 30 mins',
        '900m',
        'assets/images/res_logo.png',
        {
          'Recommended': Food.generateFoods()
        }
    );
  }
}