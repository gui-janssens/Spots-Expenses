import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class ItemConsumed {
  final String id;
  final DateTime dateTime;
  final String associateId;
  final Item item;
  final num valueThen;

  ItemConsumed(
    this.id,
    this.dateTime,
    this.item,
    this.valueThen,
    this.associateId,
  );

  factory ItemConsumed.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();
    return ItemConsumed(
      map['id'],
      DateTime.parse(map['dateTime']),
      Item.fromMap(map['item']),
      map['valueThen'],
      map['associateId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'item': item.toMap(),
      'valueThen': valueThen,
      'associateId': associateId,
    };
  }
}
