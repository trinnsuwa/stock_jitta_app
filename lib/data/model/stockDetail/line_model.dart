import 'package:jitta_app/data/model/stockDetail/monthly_price_model.dart';

class Line {
  final int total;
  final List<PriceItem>? values;

  Line({
    required this.total,
    this.values,
  });

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      total: json['total'],
      values: (json['values'] as List?)?.map((e) => PriceItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'values': values?.map((e) => e.toJson()).toList(),
    };
  }
}
