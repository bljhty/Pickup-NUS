class Food{
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

  // static list of the foods available from the merchant
  static List<Food> generateFoods() {
    return [
      Food(
        'assets/images/dish1.png',
        'Honey Glazed Chicken Rice',
        '15 min',
        5.10,
        0,
      ),
      Food(
        'assets/images/dish2.png',
        'XXL Chicken Rice',
        '15 min',
        5.50,
        0,
      )
    ];
  }
}