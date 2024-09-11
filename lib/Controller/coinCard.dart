import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final String name;
  final String symbol;
  final double price;
  final double change;
  final double changePercentage;
  final String? imageUrl; // Making imageUrl optional by adding '?'

  CoinCard({
    required this.price,
    required this.changePercentage,
    required this.change,
    required this.symbol,
    required this.name,
    this.imageUrl, // Making imageUrl optional
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
             // offset: Offset(4, 4),
            //  blurRadius: 20,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
             // offset: Offset(-4, -4),
            //  blurRadius: 20,
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 85,
              width: 85,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: imageUrl != null
                    ? Image.network(imageUrl!)
                    : Placeholder(), // Placeholder widget when imageUrl is null
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(symbol),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    price.toStringAsFixed(2), // Formatting price to two decimal places
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    change < 8
                        ? '-' + change.toStringAsFixed(2)
                        : '+' + change.toStringAsFixed(2),
                    style: TextStyle(
                      color: change < 8 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    changePercentage < 8
                        ? '-' + changePercentage.toStringAsFixed(2) + '%'
                        : '+' + changePercentage.toStringAsFixed(2) + '%',
                    style: TextStyle(
                      color: changePercentage < 8 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
