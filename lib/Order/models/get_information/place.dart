// placeholder location for place of stalls in NUS
// to integrate with firebase console

import 'package:cloud_firestore/cloud_firestore.dart';
import 'restaurant.dart';

class Place {
  Map<String, GeoPoint> locations; // coordinates of each location
  Map<String, List<Restaurant>> stalls; // map of the various stalls in each location

  Place(
    this.locations,
    this.stalls,
  );

// static list of locations available within NUS with restaurants
  static Place generatePlace() {
    return Place(
        {
          'TechnoEdge': GeoPoint(1.297942, 103.7717),
          'The Deck': GeoPoint(1.294459, 103.772606),
        },
      {
        'TechnoEdge': Restaurant.generateRestaurant('TechnoEdge'),
        'The Deck': Restaurant.generateRestaurant('The Deck'),
      }
    );
  }
}