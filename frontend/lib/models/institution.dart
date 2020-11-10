class Institution {
  final int id;
  final String name;

  Institution({this.id, this.name});

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }
}
