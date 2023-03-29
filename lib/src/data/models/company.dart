import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class Company {
  final String id;
  final String name;
  final String cnpj;
  final List<Item> items;
  final num grossIndividualDistribution;
  final List<Distribution> distributions;

  Company(
    this.id,
    this.name,
    this.cnpj,
    this.items,
    this.grossIndividualDistribution,
    this.distributions,
  );

  factory Company.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();

    return Company(
      document.id,
      map['name'],
      map['cnpj'],
      map['items'],
      map['grossIndividualDistribution'],
      map['distributions'],
    );
  }

  Map<Object, Object?> toMap() {
    return {};
  }
}
// TODO: continue CompanyRepostory -> next impl = toMap on Company
