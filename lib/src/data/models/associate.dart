import 'models.dart';

class Associate {
  final String id;
  final String companyId;
  final String name;
  final num debt;
  final String? cpf;
  final List<ItemConsumed> itemsConsumed;
  final List<Loan> loans;

  Associate(
    this.id,
    this.companyId,
    this.name,
    this.debt,
    this.cpf,
    this.itemsConsumed,
    this.loans,
  );

  factory Associate.fromMap(Map<String, dynamic> map) => Associate(
        map['id'],
        map['companyId'],
        map['name'],
        map['debt'],
        map['cpf'],
        List<ItemConsumed>.from(
            map['itemsConsumed'].map((i) => ItemConsumed.fromMap(i)).toList()),
        List<Loan>.from(map['loans'].map((l) => Loan.fromMap(l)).toList()),
      );
}
