import 'package:flutter/material.dart';
import 'food.dart';

class FoodImg extends StatelessWidget {
  final Food food;

  FoodImg(this.food);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            Align( // input the image of the food
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(15),
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(food.imgUrl, fit: BoxFit.cover,),
              ),
            )
          ],
        ));
  }
}
