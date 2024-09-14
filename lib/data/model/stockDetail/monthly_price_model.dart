class MonthlyPrice {
 //final PriceItem? last;
  final int total;
  final List<PriceItem>? values;

  MonthlyPrice({
   // this.last,
    required this.total,
    this.values,
  });

  factory MonthlyPrice.fromJson(Map<String, dynamic> json) {
    return MonthlyPrice(
     // last: json['last'] != null ? PriceItem.fromJson(json['last']) : null,
      total: json['total'],
      values: (json['values'] as List?)?.map((e) => PriceItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
     // 'last': last?.toJson(),
      'total': total,
      'values': values?.map((e) => e.toJson()).toList(),
    };
  }
}

class PriceItem {
  final String id;
  final double value;
  final int? year;
  final int? month;

  PriceItem({
    required this.id,
    required this.value,
    this.year,
    this.month,
  });

  factory PriceItem.fromJson(Map<String, dynamic> json) {
    return PriceItem(
      id: json['id'],
      value:json['value'] != null ? ( json['value'] is int ? (json['value'] as int).toDouble() : json['value']) : 0.0,
      year: json['year'],
      month: json['month'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'year': year,
      'month': month,
    };
  }
}
