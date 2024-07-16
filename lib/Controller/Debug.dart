// // Future<List<Coin>> fetchCoin() async {
// //   final url = Uri.parse(
// //       "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=50&convert=USD");
// //   const apiKey = "b0f87c4d-8b6c-42bb-b5ed-c5ec0987f59d";
// //   try {
// //     final response = await http.get(
// //       url,
// //       headers: {
// //         "Content-Type": "application/json",
// //         'X-CMC_PRO_API_KEY': apiKey,
// //       },
// //     );
// //     if (response.statusCode == 200) {
// //       List<dynamic> values = json.decode(response.body);
// //       List<Coin> coinList = [];
// //       if (values.isNotEmpty) {
// //         for (int i = 0; i < values.length; i++) {
// //           if (values[i] != null) {
// //             Map<String, dynamic> map = values[i];
// //             coinList.add(Coin.fromMap(map));
// //           }
// //         }
// //         print(coinList.first.name);
// //         setState(() {
// //           coinList;
// //         });
// //         return coinList; // Return coinList after setState
// //       } else {
// //         throw Exception('No data available');
// //       }
// //     } else {
// //       throw Exception(
// //           'Failed to load coins. Status code: ${response.statusCode}');
// //     }
// //   } catch (e) {
// //     print('Error fetching coins: $e');
// //     throw Exception('Failed to load coins');
// //   }
// // }
//
//
//
//
//
//
//
//
//
// Future<List<Coin>> fetchCoin() async {
//   List<Coin> coinList=[];
//   final url = Uri.parse(
//       "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=50&convert=USD");
//   const apiKey = "b0f87c4d-8b6c-42bb-b5ed-c5ec0987f59d";
//   try {
//     final response = await http.get(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         'X-CMC_PRO_API_KEY': apiKey,
//       },
//     );
//     if (response.statusCode == 200) {
//       List<dynamic> values = [];
//       values = json.decode(response.body);
//       if (values.length > 0) {
//         for (int i = 0; i < values.length; i++) {
//           if (values[i] != null) {
//             Map<String, dynamic> map = values[i];
//             coinList.add(Coin.fromMap(map));
//           }
//         }
//         // print(coinList.first.name);
//         // setState(() {
//         //   coinList;
//         // });
//         setState(() {
//           coinList;
//         });}
//       return coinList;
//     }
//
//     else {
//       throw Exception('No data available');
//     }
//   }catch(error){}
// }