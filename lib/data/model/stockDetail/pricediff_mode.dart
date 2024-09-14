class PriceDiff {
  final PriceDiffItem? last;
  final List<PriceDiffItem>? values;

  PriceDiff({
    this.last,
    this.values,
  });

  factory PriceDiff.fromJson(Map<String, dynamic> json) {
    return PriceDiff(
      last: json['last'] != null ? PriceDiffItem.fromJson(json['last']) : null,
      values: (json['values'] as List?)?.map((e) => PriceDiffItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last': last?.toJson(),
      'values': values?.map((e) => e.toJson()).toList(),
    };
  }
}

class PriceDiffItem {
  final String? id;
  final double value;
  final String? type;
  final String? percent;

  PriceDiffItem({
    this.id,
    required this.value,
    this.type,
    this.percent,
  });

  factory PriceDiffItem.fromJson(Map<String, dynamic> json) {
    return PriceDiffItem(
      id: json['id'],
      value: json['value'] != null ? (json['value'] is int ?  (json['value'] as int).toDouble() : json['value']): 0.0,
      type: json['type'],
      percent: json['percent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'type': type,
      'percent': percent,
    };
  }
}
