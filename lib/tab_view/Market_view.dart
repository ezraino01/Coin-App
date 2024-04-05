import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:   SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Crypto Market',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
            ),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.grey[700],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.network(
                                  'https://assets.coingecko.com/coins/images/1/standard/bitcoin.png?1696501400'),
                            ),
                            SizedBox(width: 20,),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ggg',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text('10\%',style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('\$200',style: TextStyle(color: Colors.white),),
                            Text('10\%',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
