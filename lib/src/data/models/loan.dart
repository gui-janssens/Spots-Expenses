class Loan {
  final String id;
  final DateTime dateTime;
  final num value;

  Loan(this.id, this.dateTime, this.value);

  factory Loan.fromMap(Map<String, dynamic> map) => Loan(
        map['id'],
        DateTime.parse(map['dateTime']),
        map['value'],
      );
}
