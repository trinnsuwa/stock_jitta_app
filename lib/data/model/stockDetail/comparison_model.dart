class Comparison {
  final MarketComparison? market;

  Comparison({
    this.market,
  });

  factory Comparison.fromJson(Map<String, dynamic> json) {
    return Comparison(
      market: json['market'] != null
          ? MarketComparison.fromJson(json['market'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'market': market?.toJson(),
    };
  }
}

class MarketComparison {
  final int rank;
  final int member;

  MarketComparison({
    required this.rank,
    required this.member,
  });

  factory MarketComparison.fromJson(Map<String, dynamic> json) {
    return MarketComparison(
      rank: json['rank'] ?? 0,
      member: json['member'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'member': member,
    };
  }
}
