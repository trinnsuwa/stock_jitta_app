import 'package:jitta_app/data/model/sector_model.dart';
import 'package:jitta_app/data/model/stockDetail/company_model.dart';
import 'package:jitta_app/data/model/stockDetail/comparison_model.dart';
import 'package:jitta_app/data/model/stockDetail/jitta_model.dart';
import 'package:jitta_app/data/model/stockDetail/price_model.dart';

class StockDetail {
  final int stockId;
  final String id;
  final String? alias;
  final String symbol;
  final String title;
  final String? summary;
  final Sector? sector;
  final Company? company;
  final Price? price;
  final String market;
  final String? industry;
  final String? exchange;
  final String? currency;
  final String? currencySign;
  final String? priceCurrency;
  final String? status;
  final String? nativeName;
  final String? name;
  final Comparison? comparison;
  final String? updatedFinancialComplete;
  final Jitta? jitta;

  StockDetail({
    required this.stockId,
    required this.id,
    this.alias,
    required this.symbol,
    required this.title,
    this.summary,
    this.sector,
    this.company,
    required this.market,
    this.industry,
    this.exchange,
    this.currency,
    this.currencySign,
    this.priceCurrency,
    this.status,
    this.nativeName,
    this.name,
    this.price,
    this.comparison,
    this.updatedFinancialComplete,
    this.jitta,
  });

  factory StockDetail.fromJson(Map<String, dynamic> json) {
    return StockDetail(
      stockId: json['stockId'],
      id: json['id'],
      alias: json['alias'],
      symbol: json['symbol'],
      title: json['title'],
      summary: json['summary'],
      sector: json['sector'] != null ? Sector.fromJson(json['sector']) : null,
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      market: json['market'],
      industry: json['industry'],
      exchange: json['exchange'],
      currency: json['currency'],
      currencySign: json['currency_sign'],
      priceCurrency: json['price_currency'],
      status: json['status'],
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      nativeName: json['nativeName'],
      name: json['name'],
      comparison: json['comparison'] != null
          ? Comparison.fromJson(json['comparison'])
          : null,
      updatedFinancialComplete: json['updatedFinancialComplete'],
      jitta: json['jitta'] != null ? Jitta.fromJson(json['jitta']) : null,
    );
  }

  get website => null;

  Map<String, dynamic> toJson() {
    return {
      'stockId': stockId,
      'id': id,
      'alias': alias,
      'symbol': symbol,
      'title': title,
      'summary': summary,
      'sector': sector?.toJson(),
      'market': market,
      'industry': industry,
      'exchange': exchange,
      'currency': currency,
      'currency_sign': currencySign,
      'price_currency': priceCurrency,
      'status': status,
      'price': price?.toJson(),
      'nativeName': nativeName,
      'name': name,
      'comparison': comparison?.toJson(),
      'updatedFinancialComplete': updatedFinancialComplete,
      'jitta': jitta?.toJson(),
    };
  }
}
