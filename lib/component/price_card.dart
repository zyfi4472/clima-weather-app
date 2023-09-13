import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    super.key,
    required this.cryptoName,
    required this.cryptoPrice,
    required this.selectedCurrency,
  });

  final double cryptoPrice;
  final String selectedCurrency;
  final String cryptoName;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '$cryptoName = ${cryptoPrice.toInt()} $selectedCurrency',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
