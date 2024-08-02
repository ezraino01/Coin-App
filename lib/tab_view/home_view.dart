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

  Future<void>fetchCoin()async{
    try{
      List<Coin>fetchedCoin=await coinController.fetchCoin();
      setState(() {
        coinList=fetchedCoin;
      });
    } catch(e){
      print('unable to fetch Coin price $e');
    }

  }

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
              child: ListView.builder(
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
            // ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: 15,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       height: 60,
            //       width: double.infinity,
            //       color: Colors.white,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               children: [
            //                 Container(
            //                   width: 60,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       borderRadius: BorderRadius.circular(10)),
            //                   child: Image.network(
            //                       'https://assets.coingecko.com/coins/images/1/standard/bitcoin.png?1696501400'),
            //                 ),
            //                 SizedBox(
            //                   width: 20,
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       'BTC',
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.w500),
            //                     ),
            //                     Text(
            //                       '10\%',
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.w300),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             width: 20,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Column(
            //               children: [
            //                 Text(
            //                   '\$200',
            //                   style: TextStyle(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w500),
            //                 ),
            //                 Text(
            //                   '10\%',
            //                   style: TextStyle(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400),
            //                 )
            //               ],
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    ));
  }
}
