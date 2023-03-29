import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String name;
  final num averagePrice;
  final int quantity;

  Item(this.id, this.name, this.averagePrice, this.quantity);

  factory Item.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();
    return Item(
      map['id'],
      map['name'],
      map['averagePrice'],
      map['quantity'],
    );
  }
}
