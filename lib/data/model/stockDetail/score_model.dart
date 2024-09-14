class Score {
  final ScoreItem? last;
  final List<ScoreItem>? values;

  Score({
    this.last,
    this.values,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      last: json['last'] != null ? ScoreItem.fromJson(json['last']) : null,
      values:
          (json['values'] as List?)?.map((e) => ScoreItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last': last?.toJson(),
      'values': values?.map((e) => e.toJson()).toList(),
    };
  }
}

class ScoreItem {
  final String id;
  final double? value;
  final int? quarter;
  final int? year;

  ScoreItem({
    required this.id,
    this.value,
    this.quarter,
    this.year,
  });

  factory ScoreItem.fromJson(Map<String, dynamic> json) {
    return ScoreItem(
      id: json['id'],
      value: json['value'] != null ? (json['value'] is int
          ? (json['value'] as int).toDouble()
          : json['value']): 0.0,
      quarter: json['quarter'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'quarter': quarter,
      'year': year,
    };
  }
}
