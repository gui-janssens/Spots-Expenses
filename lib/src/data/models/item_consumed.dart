class ItemConsumed {
  final String id;
  final DateTime dateTime;
  final String itemId;
  final num valueThen;

  ItemConsumed(this.id, this.dateTime, this.itemId, this.valueThen);

  factory ItemConsumed.fromMap(Map<String, dynamic> map) => ItemConsumed(
        map['id'],
        DateTime.parse(map['dateTime']),
        map['itemId'],
        map['valueThen'],
      );
}
