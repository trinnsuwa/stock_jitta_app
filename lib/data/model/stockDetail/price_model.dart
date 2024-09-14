class Price {
  final LatestPrice? latest;

  Price({
    this.latest,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      latest: json['latest'] != null
          ? LatestPrice.fromJson(json['latest'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latest': latest?.toJson(),
    };
  }
}

class LatestPrice {
  final double close;
  final String? datetime;

  LatestPrice({
    required this.close,
    this.datetime,
  });

  factory LatestPrice.fromJson(Map<String, dynamic> json) {
    return LatestPrice(
      close: json['close'] is int ? (json['close'] as int).toDouble() : json['close'],
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'close': close,
      'datetime': datetime,
    };
  }
}
