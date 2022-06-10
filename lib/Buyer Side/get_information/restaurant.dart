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
      this.menu,);

  // static list of restaurants available to order from
  static List<Restaurant> generateRestaurant(String place) {
    if (place == 'TechnoEdge') {
      return [
        Restaurant(
            'Taiwan Ichiban',
            '15 - 30 min',
            '900m',
            'assets/images/res_logo.png',
          {
            'Mains': Food.generateFoods('Taiwan Ichiban', 'Mains'),
          }
        ),
      ];
    } else if (place == 'The Deck') {
      return [
        Restaurant(
            'Pasta Express', 
            '5-10 min',
            '1.1km', 
            'assets/images/pasta_express.png',
          {
            'Pasta': Food.generateFoods('Pasta Express', 'Pasta')
          }
        )
      ];
    } else {
      return [
      Restaurant(
          'error',
          'error',
          'error',
          'error',
          {
            'Error': Food.generateFoods('error', 'error'),
          }
      )
      ];
    }
  }
}
