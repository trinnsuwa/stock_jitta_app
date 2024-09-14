class Factor {
  final FactorItem? last;

  Factor({
    this.last,
  });

  factory Factor.fromJson(Map<String, dynamic> json) {
    return Factor(
      last: json['last'] != null ? FactorItem.fromJson(json['last']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last': last?.toJson(),
    };
  }
}

class FactorItem {
  final FactorValue growth;
  final FactorValue recent;
  final FactorValue financial;
  final FactorValue returns;
  final FactorValue management;

  FactorItem({
    required this.growth,
    required this.recent,
    required this.financial,
    required this.returns,
    required this.management,
  });

  factory FactorItem.fromJson(Map<String, dynamic> json) {
    return FactorItem(
      growth: FactorValue.fromJson(json['value']['growth']),
      recent: FactorValue.fromJson(json['value']['recent']),
      financial: FactorValue.fromJson(json['value']['financial']),
      returns: FactorValue.fromJson(json['value']['return']),
      management: FactorValue.fromJson(json['value']['management']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'growth': growth.toJson(),
      'recent': recent.toJson(),
      'financial': financial.toJson(),
      'returns': returns.toJson(),
      'management': management.toJson(),
    };
  }
}

class FactorValue {
  final int value;
  final String name;
  final String level;

  FactorValue({
    required this.value,
    required this.name,
    required this.level,
  });

  factory FactorValue.fromJson(Map<String, dynamic> json) {
    return FactorValue(
      value: json['value'],
      name: json['name'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'name': name,
      'level': level,
    };
  }
}
