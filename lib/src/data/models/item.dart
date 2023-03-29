class Item {
  final String id;
  final String name;
  final num averagePrice;
  final int quantity;

  Item(this.id, this.name, this.averagePrice, this.quantity);

  factory Item.fromMap(Map<String, dynamic> map) => Item(
        map['id'],
        map['name'],
        map['averagePrice'],
        map['quantity'],
      );
}
