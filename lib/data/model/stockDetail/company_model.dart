class Company {
  final String? ipoDate;
  final List<Link>? link;

  Company({
    this.ipoDate,
    this.link,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      ipoDate: json['ipo_date'] ?? '',
      link: json['link'] != null
          ? List<Link>.from(json['link'].map((item) => Link.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ipo_date': ipoDate,
      'link': link?.map((l) => l.toJson()).toList(),
    };
  }
}

class Link {
  final String url;

  Link({
    required this.url,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}