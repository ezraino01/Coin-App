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





