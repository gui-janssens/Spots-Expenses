import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  final String id;
  final DateTime dateTime;
  final num value;
  final String associateId;

  Loan(
    this.id,
    this.dateTime,
    this.value,
    this.associateId,
  );

  factory Loan.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();

    return Loan(
      map['id'],
      DateTime.parse(map['dateTime']),
      map['value'],
      map['associateId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'value': value,
      'associateId': associateId,
    };
  }
}
