// import 'dart:async';
// // import 'dart:html';
// // import 'package:cryptomania/Withdrawal.dart';
// import 'package:flutter/material.dart';
// import '../Controller/CoinController.dart';
// import '../Controller/CoinsModel.dart';
// import '../Controller/coinCard.dart';
// // import '../Deposit.dart';
// import '../UserModel.dart';
//
// class Portfolio extends StatefulWidget {
//   final Users users;
//   const Portfolio({Key? key, required this.users}) : super(key: key);
//
//   @override
//   State<Portfolio> createState() => _PortfolioState();
// }
//
// class _PortfolioState extends State<Portfolio> {
//   List<Coin> coinList = [];
//   final CoinController coinController = CoinController();
//   late Timer _timer;
//   final Duration _refreshInterval =
//       const Duration(seconds: 1); // Update interval set to 1 second
//   // bool isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     fetchCoins(); // Call function to fetch coins initially
//     // Start the timer after the initial fetch
//     _timer = Timer.periodic(_refreshInterval, (timer) {
//       fetchCoins(); // Call function to fetch coins periodically
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel(); // Cancel the timer to prevent memory leaks
//     super.dispose();
//   }
//
//   // Function to fetch coins and update state
//   Future<void> fetchCoins() async {
//     //  setState(() {
//     //   isLoading = true;
//     // });
//     try {
//       List<Coin> fetchedCoins = await coinController.fetchCoin();
//       setState(() {
//         coinList = fetchedCoins;
//         //  isLoading = false;
//       });
//     } catch (error) {
//       // Handle error
//       print('Error fetching coins: $error');
//       // setState(() {
//       //  isLoading = false;
//       // });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double Height = MediaQuery.of(context).size.height;
//     double Width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Portfolio',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w900),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Holding value',
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           '\$${widget.users.amount}',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           '+9.77\%',
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           'Holding value\n\$1,810',
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Container(
//                           height: 30,
//                           width: 1,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           'Available USD\n\$1,580',
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               height: Height * 0.26,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // MaterialButton(
//                 //   onPressed: () {
//                 //     print('');
//                 //      Navigator.push(context,
//                 //         MaterialPageRoute(builder: (context) => Deposit()));
//                 //   },
//                 // child: Container(
//                 //   height: Height * 0.07,
//                 //   width: Width * 0.36,
//                 //   decoration: BoxDecoration(
//                 //       color: Colors.green[100],
//                 //       borderRadius: BorderRadius.circular(10)),
//                 //   child: Center(
//                 //       child: Text(
//                 //         'Deposit NGN',
//                 //         style: TextStyle(fontWeight: FontWeight.w900),
//                 //       )),
//                 // ),
//                 // ),
//                 // MaterialButton(
//                 //   onPressed: () {
//                 //     Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //             builder: (context) => Withdrawal()));
//                 //   },
//                 //   child: Container(
//                 //     height: Height * 0.07,
//                 //     width: Width * 0.36,
//                 //     decoration: BoxDecoration(
//                 //         color: Colors.green[100],
//                 //         borderRadius: BorderRadius.circular(10)),
//                 //     child: Center(
//                 //         child: Text(
//                 //           'Withdraw NGN',
//                 //           style: TextStyle(fontWeight: FontWeight.w900),
//                 //         )),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Your Coins',
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w900,
//                       color: Colors.black54),
//                 ),
//               ),
//             ],
//           ),
//           //  isLoading
//           //     ? Expanded(
//           //        child: Center(
//           //        child: CircularProgressIndicator(),
//           //     ))
//           // :
//           Expanded(
//             child: ListView.builder(
//               itemCount: coinList.length,
//               itemBuilder: (context, index) {
//                 return CoinCard(
//                   price: coinList[index].price.toDouble(),
//                   changePercentage: coinList[index].changePercentage.toDouble(),
//                   change: coinList[index].change.toDouble(),
//                   symbol: coinList[index].symbol,
//                   name: coinList[index].name,
//                   imageUrl: coinList[index].imageUrl,
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 100,
//           )
//         ],
//       ),
//     );
//   }
// }
