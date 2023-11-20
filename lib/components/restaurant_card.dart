import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {

  final String eatery;
  final String Name;
  final int price;

  const RestaurantCard(
      {super.key,
      required this.eatery,
      required this.Name,
      required this.price});

  @override

  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrangeAccent,
      child: Container(
        height: 80,
        width: 300,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    eatery,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  Name,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '₹$price',
                  style: const TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
