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

  final Map<String, String> cryptoImages = {
    'BTC': 'https://cryptologos.cc/logos/bitcoin-btc-logo.png',
    'ETH': 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
    'LTC': 'https://cryptologos.cc/logos/litecoin-ltc-logo.png',
    'USDT': 'https://cryptologos.cc/logos/tether-usdt-logo.png',
    'SOL': 'https://cryptologos.cc/logos/solana-sol-logo.png',
    'BNB': 'https://cryptologos.cc/logos/binance-coin-bnb-logo.png',
    'USDC': 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png',
    'XRP': 'https://cryptologos.cc/logos/xrp-xrp-logo.png',
    'TON': 'https://cryptologos.cc/logos/ton-crystal-ton-logo.png',
    'DOGE': 'https://cryptologos.cc/logos/dogecoin-doge-logo.png',
    'ADA': 'https://cryptologos.cc/logos/cardano-ada-logo.png',
    'TRX': 'https://cryptologos.cc/logos/tron-trx-logo.png',
    'SHIB': 'https://cryptologos.cc/logos/shiba-inu-shib-logo.png',
    'BCH': 'https://cryptologos.cc/logos/bitcoin-cash-bch-logo.png',
    'BONK': 'https://cryptologos.cc/logos/bonk-bonk-logo.png',
    'UNI': 'https://cryptologos.cc/logos/uniswap-uni-logo.png',
    'NEAR': 'https://cryptologos.cc/logos/near-protocol-near-logo.png',
    'MATIC': 'https://cryptologos.cc/logos/polygon-matic-logo.png',
    'ICP': 'https://cryptologos.cc/logos/internet-computer-icp-logo.png',
    'PEPE': 'https://cryptologos.cc/logos/pepe-pepe-logo.png',
    'XLM': 'https://cryptologos.cc/logos/stellar-xlm-logo.png',
    'ETC': 'https://cryptologos.cc/logos/ethereum-classic-etc-logo.png',
    'XMR': 'https://cryptologos.cc/logos/monero-xmr-logo.png',
    'APT': 'https://cryptologos.cc/logos/aptos-apt-logo.png',
    'CRO': 'https://cryptologos.cc/logos/cronos-cro-logo.png',
    'STX': 'https://cryptologos.cc/logos/stacks-stx-logo.png',
    'OKB': 'https://cryptologos.cc/logos/okb-okb-logo.png',
    'FIL': 'https://cryptologos.cc/logos/filecoin-fil-logo.png',
    'MNT': 'https://cryptologos.cc/logos/mantle-mnt-logo.png',
    'TAO': 'https://cryptologos.cc/logos/bittensor-tao-logo.png',
    'ATOM': 'https://cryptologos.cc/logos/cosmos-atom-logo.png',
    'HBAR': 'https://cryptologos.cc/logos/hedera-hbar-logo.png',
    'VET': 'https://cryptologos.cc/logos/vechain-vet-logo.png',
    'FDUSD': 'https://cryptologos.cc/logos/first-digital-usd-fdusd-logo.png',
    'RNDR': 'https://cryptologos.cc/logos/render-token-rndr-logo.png',
    'MKR': 'https://cryptologos.cc/logos/maker-mkr-logo.png',
    'IMX': 'https://cryptologos.cc/logos/immutable-imx-logo.png',
    'ARB': 'https://cryptologos.cc/logos/arbitrum-arb-logo.png',
    'SUI': 'https://cryptologos.cc/logos/sui-sui-logo.png',
    'OP': 'https://cryptologos.cc/logos/optimism-op-logo.png',
    'INJ': 'https://cryptologos.cc/logos/injective-inj-logo.png',
    'KAS': 'https://cryptologos.cc/logos/kaspa-kas-logo.png',
    'DAI': 'https://cryptologos.cc/logos/multi-collateral-dai-dai-logo.png',
    'LINK': 'https://cryptologos.cc/logos/chainlink-link-logo.png',
    'LEO': 'https://cryptologos.cc/logos/unus-sed-leo-leo-logo.png',
    'DOT': 'https://cryptologos.cc/logos/polkadot-new-dot-logo.png',
    'AVAX': 'https://cryptologos.cc/logos/avalanche-avax-logo.png',

  };


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

  Future<void> fetchCoins() async {
    try {
      List<Coin> fetchedCoins = await coinController.fetchCoin();
      List<Coin> updatedCoins = fetchedCoins.map((coin) {
        String imageUrl = cryptoImages[coin.symbol] ?? 'https://cryptologos.cc/logos/default.png'; // Fallback image
        return Coin(
          name: coin.name,
          symbol: coin.symbol,
          price: coin.price,
          changePercentage: coin.changePercentage,
          change: coin.change,
          imageUrl: imageUrl,
        );
      }).toList();

      setState(() {
        coinList = updatedCoins;
          displayedCryptocurrencies = List.from(coinList);
      });
    } catch (e) {
      print('Unable to fetch Coin price: $e');
    }
  }


  // Function to fetch coins and update state
  // Future<void> fetchCoins() async {
  //   try {
  //     List<Coin> fetchedCoins = await coinController.fetchCoin();
  //     setState(() {
  //       coinList = fetchedCoins;
  //       // Initially, display all fetched coins
  //       displayedCryptocurrencies = List.from(coinList);
  //     });
  //   } catch (error) {
  //     // Handle error
  //     print('Error fetching coins: $error');
  //   }
  // }
  //Function to filter displayed cryptocurrencies based on search query
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
