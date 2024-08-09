import 'dart:async';

import 'package:cryptomania/Controller/CoinController.dart';
import 'package:cryptomania/Controller/coinCard.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Controller/CoinsModel.dart';

class HomeView extends StatefulWidget {
  final Users users;
  const HomeView({Key? key, required this.users}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Coin> coinList = [];
  final CoinController coinController= CoinController();
  late  Timer _timer;
  final Duration _duration= Duration(hours: 1);

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
    super.initState();
    fetchCoin();
    _timer=Timer.periodic(_duration, (timer) { fetchCoin();});
  }
  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchCoin() async {
    try {
      List<Coin> fetchedCoin = await coinController.fetchCoin();

      // Update each coin with the corresponding image URL from the map
      List<Coin> updatedCoins = fetchedCoin.map((coin) {
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
      });
    } catch (e) {
      print('Unable to fetch Coin price: $e');
    }
  }

  // Future<void>fetchCoin()async{
  //   try{
  //     List<Coin>fetchedCoin=await coinController.fetchCoin();
  //     setState(() {
  //       coinList=fetchedCoin;
  //     });
  //   } catch(e){
  //     print('unable to fetch Coin price $e');
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Height * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Positioned(
                  left: 25,
                  top: 90,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Container(
                      child: Center(
                          child: Text(
                        'Invest Today',
                        style: TextStyle(color: Colors.green),
                      )),
                      height: 30,
                      width: Width * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Positioned(
                    left: 15,
                    top: 10,
                    child: Column(
                      children: [
                        Text(
                          'Welcome ${widget.users.name},',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Make your first Investment',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Trending Coins',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 14,),
            Container(
              height: Height*0.5,
              child:
              ListView.builder(
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
            )
          ],
        ),
      ),
    ));
  }
}
