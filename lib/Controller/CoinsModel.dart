


class Coin {
  late String name;
  late String symbol;
  late String? imageUrl; // Making imageUrl optional by adding '?'
  late double price;
  late double change;
  late double changePercentage;

  Coin({
    required this.change,
    required this.changePercentage,
    required this.price,
    required this.symbol,
    required this.name,
    this.imageUrl, // Making imageUrl optional
  });

  factory Coin.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> quoteData = map['quote']['USD'];
    return Coin(
      change: quoteData['volume_change_24h'] != null ? double.parse(quoteData['volume_change_24h'].toString()) : 0.0,
      changePercentage: quoteData['percent_change_24h'] != null ? double.parse(quoteData['percent_change_24h'].toString()) : 0.0,
      price: quoteData['price'] != null ? double.parse(quoteData['price'].toString()) : 0.0,
      symbol: map['symbol'] ?? "",
      name: map['name'] ?? "",
      imageUrl: map['image'], // imageUrl can be null, no need for null check here
    );
  }
}


