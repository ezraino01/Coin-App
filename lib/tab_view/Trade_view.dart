import 'dart:async';
import 'package:cryptomania/Controller/CoinController.dart';
import 'package:cryptomania/Controller/UserController.dart';
import 'package:flutter/material.dart';
import '../Controller/CoinsModel.dart';
import '../UserModel.dart';

class Trade extends StatefulWidget {
  final Users users;
  const Trade({Key? key, required this.users}) : super(key: key);

  @override
  State<Trade> createState() => _TradeState();
}

class _TradeState extends State<Trade> {
  late UserController userController;
  List<Coin> coinList = [];
  final CoinController coinController = CoinController();

  String? selectedCoin;
  double? currentPrice;
  double userBalance = 0.0; // Default balance
  double? tradeAmountInDollars;
  Map<String, double> purchasedCoins = {}; // Tracks the amount of each purchased coin in units
  List<String> trades = []; // Stores the trades information
  Timer? priceUpdateTimer;

  @override
  void initState() {
    super.initState();
    userController = UserController();
    userBalance = double.parse(widget.users.amount);
    fetchCoins(); // Fetch coins on initialization
    startPriceUpdateTimer(); // Start periodic price updates
  }

  @override
  void dispose() {
    priceUpdateTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchCoins() async {
    try {
      List<Coin> fetchedCoins = await coinController.fetchCoin();
      setState(() {
        coinList = fetchedCoins;
      });
      print('Coins fetched successfully: $coinList');
    } catch (e) {
      print('Error fetching coins: $e');
    }
  }

  Future<void> fetchCurrentPrice(String coinName) async {
    try {
      double? price = await coinController.fetchCoinPrice(coinName);
      setState(() {
        currentPrice = price;
      });
      print('Current price of $coinName: $currentPrice');
    } catch (e) {
      print('Error fetching current price: $e');
    }
  }

  void startPriceUpdateTimer() {
    priceUpdateTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      await updateCoinPrices();
    });
  }

  Future<void> updateCoinPrices() async {
    Map<String, double> newPrices = {};
    for (String coin in purchasedCoins.keys) {
      double? price = await coinController.fetchCoinPrice(coin);
      if (price != null) {
        newPrices[coin] = price;
      }
    }

    setState(() {
      purchasedCoins.updateAll((coin, amount) => amount * (newPrices[coin] ?? 1));
    });
  }

  void placeOrder() async {
    if (tradeAmountInDollars != null &&
        currentPrice != null &&
        selectedCoin != null) {
      double totalCost = tradeAmountInDollars!;
      double unitsToPurchase = tradeAmountInDollars! / currentPrice!;
      print('Trade Amount in USD: $tradeAmountInDollars');
      print('Current Price: $currentPrice');
      print('Total Cost: $totalCost');
      print('User Balance: $userBalance');

      if (totalCost <= userBalance) {
        // Call the buyCrypto method from UserController
        List result = await userController.buyCrypto(
          currentPrice: currentPrice!.toString(),
          selectedCoin: selectedCoin!,
          amount: totalCost,
          userDocId: widget.users.ID,
        );

        if (result[0]) {
          setState(() {
            userBalance -= totalCost;
            if (purchasedCoins.containsKey(selectedCoin!)) {
              purchasedCoins[selectedCoin!] =
                  purchasedCoins[selectedCoin!]! + unitsToPurchase;
            } else {
              purchasedCoins[selectedCoin!] = unitsToPurchase;
            }
            trades.add(
                'Purchased $unitsToPurchase units of $selectedCoin for \$${totalCost.toStringAsFixed(2)}');
            tradeAmountInDollars = null;
          });

          print('Order placed for $selectedCoin');
        } else {
          print(result[1]); // Show error message
        }
      } else {
        print('Insufficient balance');
      }
    } else {
      print('Trade amount in dollars, current price, or selected coin is null');
    }
  }

  Future<double> calculateTotalValue() async {
    double totalValue = userBalance;
    for (String coin in purchasedCoins.keys) {
      double? currentPrice = await coinController.fetchCoinPrice(coin);
      if (currentPrice != null) {
        totalValue += purchasedCoins[coin]! * currentPrice;
      }
    }
    return totalValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<double>(
        future: calculateTotalValue(),
        builder: (context, snapshot) {
          double totalValue = snapshot.data ?? userBalance;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Coin',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedCoin,
                    onChanged: (value) {
                      setState(() {
                        selectedCoin = value;
                        fetchCurrentPrice(value!);
                      });
                      print('Selected coin: $selectedCoin');
                    },
                    items: coinList.map<DropdownMenuItem<String>>((Coin coin) {
                      return DropdownMenuItem<String>(
                        value: coin.name,
                        child: Text(coin.name),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Select Coin',
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Current Price',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Container(
                    height: 40,
                    width: 90,
                    color: Colors.green,
                    child: Center(
                      child: Text(currentPrice != null
                          ? '\$${currentPrice!.toStringAsFixed(2)}'
                          : 'Loading...'),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Your Balance: \$${userBalance.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  SizedBox(height: 15),
                  Text('Enter Amount in USD',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        tradeAmountInDollars = double.tryParse(value);
                      });
                      print(
                          'Trade Amount in Dollars entered: $tradeAmountInDollars');
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Amount in Dollars',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'Enter Amount in USD',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: placeOrder,
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Remaining Balance: \$${userBalance.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  SizedBox(height: 20),
                  if (trades.isNotEmpty) ...[
                    Text('Trades:',
                        style: TextStyle(fontWeight: FontWeight.w900)),
                    ...trades.map((trade) => Text(trade)).toList(),
                  ],
                  SizedBox(height: 20),
                  if (purchasedCoins.isNotEmpty) ...[
                    Text('Purchased Coins:',
                        style: TextStyle(fontWeight: FontWeight.w900)),
                    ...purchasedCoins.entries.map((entry) {
                      return Text(
                          '${entry.key}: ${entry.value.toStringAsFixed(2)} units');
                    }).toList(),
                  ],
                  SizedBox(height: 20),
                  Text('Total Portfolio Value: \$${totalValue.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
