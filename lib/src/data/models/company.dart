import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class Company {
  final String id;
  final String name;
  final String cnpj;
  final List<Item> items;
  final num grossIndividualDistribution;
  final List<Distribution> distributions;
  final List<ItemConsumed> itemsConsumed;
  final List<Loan> loans;

  Company(
    this.id,
    this.name,
    this.cnpj,
    this.items,
    this.grossIndividualDistribution,
    this.distributions,
    this.itemsConsumed,
    this.loans,
  );

  factory Company.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();

    return Company(
      document.id,
      map['name'],
      map['cnpj'],
      List<Item>.from(map['items'].map((i) => Item.fromMap(i)).toList()),
      map['grossIndividualDistribution'],
      List<Distribution>.from(
          map['distributions'].map((d) => Distribution.fromMap(d)).toList()),
      List<ItemConsumed>.from(map['itemsConsumed']
          .map((i) => ItemConsumed.fromDocument(i))
          .toList()),
      List<Loan>.from(map['loans'].map((l) => Loan.fromDocument(l)).toList()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cnpj': cnpj,
      'items': items.map((i) => i.toMap()).toList(),
      'grossIndividualDistribution': grossIndividualDistribution,
      'distributions': distributions.map((d) => d.toMap()).toList(),
      'itemsConsumed': itemsConsumed.map((i) => i.toMap()).toList(),
      'loans': loans.map((l) => l.toMap()).toList(),
    };
  }
}
