import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Controller/CoinController.dart';
import '../Controller/coinCard.dart';
import 'package:cryptomania/Controller/CoinsModel.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  final CoinController coinController = CoinController();
  late Timer _timer;
  final Duration _refreshInterval = const Duration(hours: 1);

  @override
  void initState() {
    fetchCoins(); // Call function to fetch coins initially
    // Start the timer after the initial fetch
    _timer = Timer.periodic(_refreshInterval, (timer) {
      fetchCoins(); // Call function to fetch coins periodically
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  List<Coin> coinList = [];
  List<Coin> displayedCryptocurrencies = [];

  // Function to fetch coins and update state
  Future<void> fetchCoins() async {
    try {
      List<Coin> fetchedCoins = await coinController.fetchCoin();
      setState(() {
        coinList = fetchedCoins;
        // Initially, display all fetched coins
        displayedCryptocurrencies = List.from(coinList);
      });
    } catch (error) {
      // Handle error
      print('Error fetching coins: $error');
    }
  }
  // Function to filter displayed cryptocurrencies based on search query
  void filterCryptocurrencies(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedCryptocurrencies =
            List.from(coinList); // Reset to original list
      } else {
        displayedCryptocurrencies = coinList
            .where((crypto) =>
                crypto.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    height: 42,
                    width: 300,
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        Expanded(
                          child: TextFormField(
                            onChanged: filterCryptocurrencies,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Cryptocurrency',
                              hintStyle: TextStyle(color: Colors.grey[350]),
                              suffixIcon: InkWell(
                                onTap: () {},
                                child: Icon(Icons.cancel_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text('Cancel'))
                ],
              ),
            ),
            // Crypto Market title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Crypto Market',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: displayedCryptocurrencies.length,
              itemBuilder: (context, index) {
                return CoinCard(
                  price: displayedCryptocurrencies[index].price.toDouble(),
                  changePercentage: displayedCryptocurrencies[index]
                      .changePercentage
                      .toDouble(),
                  change: displayedCryptocurrencies[index].change.toDouble(),
                  symbol: displayedCryptocurrencies[index].symbol,
                  name: displayedCryptocurrencies[index].name,
                  imageUrl: displayedCryptocurrencies[index].imageUrl,
                );
              },
            ),
            SizedBox(height: 90,)
          ],
        ),
      ),
    );
  }
}
