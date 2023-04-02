import 'package:cloud_firestore/cloud_firestore.dart';

class ItemConsumed {
  final String id;
  final DateTime dateTime;
  final String associateId;
  final String itemName;
  final num valueThen;

  ItemConsumed(
    this.id,
    this.dateTime,
    this.itemName,
    this.valueThen,
    this.associateId,
  );

  factory ItemConsumed.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();
    return ItemConsumed(
      map['id'],
      DateTime.parse(map['dateTime']),
      map['itemName'],
      map['valueThen'],
      map['associateId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'itemName': itemName,
      'valueThen': valueThen,
      'associateId': associateId,
    };
  }
}
