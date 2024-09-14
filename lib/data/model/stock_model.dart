import 'package:jitta_app/data/model/sector_model.dart';

class Stock {
  final String id;
  final int? stockId;
  final int? rank;
  final String? symbol;
  final String? exchange;
  final String? title;
  final double? jittaScore;
  final String? nativeName;
  final Sector? sector;
  final String? industry;

  Stock({
    required this.id,
    this.stockId,
    this.rank,
    this.symbol,
    this.exchange,
    this.title,
    this.jittaScore,
    this.nativeName,
    this.sector,
    this.industry,
  });

  factory Stock.fromJson(Map<dynamic, dynamic> json) {
    return Stock(
      id: json['id'],
      stockId: json['stockId'],
      rank: json['rank'],
      symbol: json['symbol'],
      exchange: json['exchange'],
      title: json['title'],
      jittaScore: json['jittaScore'].toDouble(),
      nativeName: json['nativeName'],
      sector: Sector.fromJson(json['sector']),
      industry: json['industry'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'stockId': stockId,
      'rank': rank,
      'symbol': symbol,
      'exchange': exchange,
      'title': title,
      'jittaScore': jittaScore,
      'nativeName': nativeName,
      'sector': sector?.toJson(),
      'industry': industry,
    };
  }
}