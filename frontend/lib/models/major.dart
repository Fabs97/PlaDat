class Major {
  final int id;
  final String name;

  Major({this.id, this.name});

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }
}
