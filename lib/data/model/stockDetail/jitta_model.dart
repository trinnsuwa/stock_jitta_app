import 'package:jitta_app/data/model/stockDetail/factor_model.dart';
import 'package:jitta_app/data/model/stockDetail/line_model.dart';
import 'package:jitta_app/data/model/stockDetail/monthly_price_model.dart';
import 'package:jitta_app/data/model/stockDetail/pricediff_mode.dart';
import 'package:jitta_app/data/model/stockDetail/score_model.dart';
import 'package:jitta_app/data/model/stockDetail/sign_model.dart';

class Jitta {
  final PriceDiff? priceDiff;
  final MonthlyPrice? monthlyPrice;
  final Score? score;
  final Line? line;
  final Factor? factor;
  final Sign? sign;

  Jitta({
    this.priceDiff,
    this.monthlyPrice,
    this.score,
    this.line,
    this.factor,
    this.sign,
  });

  factory Jitta.fromJson(Map<String, dynamic> json) {
    return Jitta(
      priceDiff: json['priceDiff'] != null ? PriceDiff.fromJson(json['priceDiff']) : null,
      monthlyPrice: json['monthlyPrice'] != null ? MonthlyPrice.fromJson(json['monthlyPrice']) : null,
      score: json['score'] != null ? Score.fromJson(json['score']) : null,
      line: json['line'] != null ? Line.fromJson(json['line']) : null,
      factor: json['factor'] != null ? Factor.fromJson(json['factor']) : null,
      sign: json['sign'] != null ? Sign.fromJson(json['sign']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'priceDiff': priceDiff?.toJson(),
      'monthlyPrice': monthlyPrice?.toJson(),
      'score': score?.toJson(),
      'line': line?.toJson(),
      'factor': factor?.toJson(),
      'sign': sign?.toJson(),
    };
  }
}
