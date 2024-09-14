class Sign {
  final List<SignItem>? last;

  Sign({
    this.last,
  });

  factory Sign.fromJson(Map<String, dynamic> json) {
    return Sign(
      last: json['last'] != null
          ? List<SignItem>.from(json['last'].map((item) => SignItem.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last': last?.map((item) => item.toJson()).toList(),
    };
  }
}

class SignItem {
  final String title;
  final String type;
  final String name;
  final String value;
  final Display? display;

  SignItem({
   required this.title,
   required this.type,
   required this.name,
   required this.value,
    this.display,
  });

  factory SignItem.fromJson(Map<String, dynamic> json) {
    return SignItem(
      title: json['title'],
      type: json['type'],
      name: json['name'],
      value: json['value'],
      display: json['display'] != null ? Display.fromJson(json['display']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'name': name,
      'value': value,
      'display': display?.toJson(),
    };
  }
}

class Display {
  final String? text;

  Display({
    this.text,
  });

  factory Display.fromJson(Map<String, dynamic> json) {
    return Display(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
