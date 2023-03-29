import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Associate.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();

    return Associate(
      document.id,
      map['companyId'],
      map['name'],
      map['debt'],
      map['cpf'],
      List<ItemConsumed>.from(map['itemsConsumed']
          .map((i) => ItemConsumed.fromDocument(i))
          .toList()),
      List<Loan>.from(map['loans'].map((l) => Loan.fromDocument(l)).toList()),
    );
  }
}
