import 'dart:convert';
import 'package:http/http.dart' as http;
import 'CoinsModel.dart';


class CoinController{
  Future<List<Coin>> fetchCoin() async {
    List<Coin> coinList = [];
    final url = Uri.parse("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=50&convert=USD");

    const apiKey = "b0f87c4d-8b6c-42bb-b5ed-c5ec0987f59d";
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'X-CMC_PRO_API_KEY': apiKey,
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        // Assuming the data structure is like: {"data": [ ... ]}
        if (data.containsKey("data")) {
          List<dynamic> values = data["data"];
          if (values.length > 0) {
            for (int i = 0; i < values.length; i++) {
              if (values[i] != null) {
                Map<String, dynamic> map = values[i];
                coinList.add(Coin.fromMap(map));
              }
            }
            print(coinList.first.changePercentage);
            return coinList;
          } else {
            throw Exception('No data available');
          }
        } else {
          throw Exception('Invalid data structure in response');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error: return an empty list or rethrow the exception
      throw Exception('Failed to fetch data: $error');
    }
  }
  Future<double?> fetchCoinPrice(String coinName) async {
    final url = Uri.parse(
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=50&convert=USD");

    const apiKey = "b0f87c4d-8b6c-42bb-b5ed-c5ec0987f59d";
    try {
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'X-CMC_PRO_API_KEY': apiKey,
      });
      if (response.statusCode == 200) {
        return parseResponse(response.body, coinName);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching coin price: $e');
      return null;
    }
  }
  double? parseResponse(String responseBody, String coinName) {
    try {
      // Parse the JSON response
      var data = json.decode(responseBody);
      // Extract the price of the specified coin from the response
      var coinData = data['data'].firstWhere(
            (coin) => coin['name'].toString().toLowerCase() == coinName.toLowerCase(),
        orElse: () => null,
      );
      if (coinData != null) {
        // Extract the price from the coin data
        return double.parse(coinData['quote']['USD']['price'].toString());
      } else {
        print('Coin not found in response.');
        return null;
      }
    } catch (e) {
      print('Error parsing response: $e');
      return null;
    }
  }
}




// import 'dart:convert';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'CoinsModel.dart';
//
// class CoinController {
//   final String apiKey = "b0f87c4d-8b6c-42bb-b5ed-c5ec0987f59d";
//   final Uri apiUrl = Uri.parse("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=50&convert=USD");
//
//   Future<List<Coin>> fetchCoin() async {
//     List<Coin> coinList = [];
//     int retries = 5;
//     int retryDelay = 1; // initial delay in seconds
//
//     for (int i = 0; i < retries; i++) {
//       try {
//         final response = await http.get(
//           apiUrl,
//           headers: {
//             "Content-Type": "application/json",
//             'X-CMC_PRO_API_KEY': apiKey,
//           },
//         ).timeout(Duration(seconds: 20));
//
//         if (response.statusCode == 200) {
//           Map<String, dynamic> data = json.decode(response.body);
//           if (data.containsKey("data")) {
//             List<dynamic> values = data["data"];
//             for (var value in values) {
//               if (value != null) {
//                 coinList.add(Coin.fromMap(value));
//               }
//             }
//             print('Coins fetched successfully: ${coinList.length} coins found.');
//             return coinList;
//           } else {
//             throw Exception('Invalid data structure in response');
//           }
//         } else if (response.statusCode == 429) {
//           // Too Many Requests, wait and retry
//           print('Rate limit exceeded. Waiting for ${retryDelay} seconds before retrying...');
//           await Future.delayed(Duration(seconds: retryDelay));
//           retryDelay *= 2; // exponential backoff
//         } else {
//           throw Exception('Failed to load data: ${response.statusCode}');
//         }
//       } on TimeoutException catch (_) {
//         throw Exception('Request timed out. Please try again.');
//       } on http.ClientException catch (e) {
//         throw Exception('Client exception: $e');
//       } catch (error) {
//         throw Exception('Failed to fetch data: $error');
//       }
//     }
//
//     throw Exception('Failed to fetch data after $retries retries.');
//   }
//
//   Future<double?> fetchCoinPrice(String coinName) async {
//     int retries = 5;
//     int retryDelay = 1; // initial delay in seconds
//
//     for (int i = 0; i < retries; i++) {
//       try {
//         final response = await http.get(
//           apiUrl,
//           headers: {
//             "Content-Type": "application/json",
//             'X-CMC_PRO_API_KEY': apiKey,
//           },
//         ).timeout(Duration(seconds: 20));
//
//         if (response.statusCode == 200) {
//           return parseResponse(response.body, coinName);
//         } else if (response.statusCode == 429) {
//           // Too Many Requests, wait and retry
//           print('Rate limit exceeded. Waiting for ${retryDelay} seconds before retrying...');
//           await Future.delayed(Duration(seconds: retryDelay));
//           retryDelay *= 2; // exponential backoff
//         } else {
//           throw Exception('Failed to fetch data: ${response.statusCode}');
//         }
//       } on TimeoutException catch (_) {
//         throw Exception('Request timed out. Please try again.');
//       } on http.ClientException catch (e) {
//         throw Exception('Client exception: $e');
//       } catch (e) {
//         print('Error fetching coin price: $e');
//         return null;
//       }
//     }
//
//     throw Exception('Failed to fetch coin price after $retries retries.');
//   }
//
//   double? parseResponse(String responseBody, String coinName) {
//     try {
//       var data = json.decode(responseBody);
//       var coinData = data['data'].firstWhere(
//             (coin) => coin['name'].toString().toLowerCase() == coinName.toLowerCase(),
//         orElse: () => null,
//       );
//
//       if (coinData != null) {
//         return double.parse(coinData['quote']['USD']['price'].toString());
//       } else {
//         print('Coin not found in response.');
//         return null;
//       }
//     } catch (e) {
//       print('Error parsing response: $e');
//       return null;
//     }
//   }
// }
