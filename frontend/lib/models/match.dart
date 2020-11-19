import 'dart:convert';

class Match {
  int studentID;
  int placementID;
  bool studentAccept;
  bool placementAccept;
  String status;

  Match(
      {this.studentID,
      this.placementID,
      this.studentAccept,
      this.placementAccept,
      this.status});

  factory Match.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Match(
      studentID: json['studentID'],
      placementID: json['placementID'],
      studentAccept: json['studentAccept'],
      placementAccept: json['placementAccept'],
      status: json['status'],
    );
  }

  String toJson() {
    return jsonEncode({
      'studentID': this.studentID,
      'placementID': this.placementID,
      'studentAccept': this.studentAccept,
      'placementAccept': this.placementAccept,
      'status': this.status,
    });
  }
}
