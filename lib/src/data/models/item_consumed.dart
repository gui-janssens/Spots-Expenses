import 'package:cloud_firestore/cloud_firestore.dart';

class ItemConsumed {
  final String id;
  final DateTime dateTime;
  final String itemId;
  final num valueThen;

  ItemConsumed(this.id, this.dateTime, this.itemId, this.valueThen);

  factory ItemConsumed.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();
    return ItemConsumed(
      map['id'],
      DateTime.parse(map['dateTime']),
      map['itemId'],
      map['valueThen'],
    );
  }
}
