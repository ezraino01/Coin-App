import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptomania/Controller/CoinController.dart';
import 'package:cryptomania/Controller/coinCard.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'CoinsModel.dart';

class CryptoChat extends StatefulWidget {
  const CryptoChat({super.key});

  @override
  State<CryptoChat> createState() => _CryptoChatState();
}
class _CryptoChatState extends State<CryptoChat> {
  List<Coin> coinList = [];
  final CoinController coinController = CoinController();

  @override
  void initState() {
    super.initState();
    fetchCoins(); // Call function to fetch coins
  }
  // Function to fetch coins and update state
  Future<void> fetchCoins() async {
    try {
      List<Coin> fetchedCoins = await coinController.fetchCoin();
      setState(() {
        coinList = fetchedCoins;
      });
    } catch (error) {
      // Handle error
      print('Error fetching coins: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Center(
          child: Text(
            'CryptoCurrencies',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: coinList.length,
        itemBuilder: (context, index) {
          return CoinCard(
            price: coinList[index].price.toDouble(),
            changePercentage: coinList[index].changePercentage.toDouble(),
            change: coinList[index].change.toDouble(),
            symbol: coinList[index].symbol,
            name: coinList[index].name,
            imageUrl: coinList[index].imageUrl,
          );
        },
      ),
    );
  }
}

