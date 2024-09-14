class Sector {
  final String id;
  final String name;

  Sector({
    required this.id,
    required this.name,
  });

  factory Sector.fromJson(Map<dynamic, dynamic> json) {
    return Sector(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}