import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  final String id;
  final DateTime dateTime;
  final num value;

  Loan(this.id, this.dateTime, this.value);

  factory Loan.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();

    return Loan(
      document.id,
      DateTime.parse(map['dateTime']),
      map['value'],
    );
  }
}
